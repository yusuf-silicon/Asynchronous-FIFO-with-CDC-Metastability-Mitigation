`uvm_analysis_imp_decl(_write)
`uvm_analysis_imp_decl(_read)

class fifo_scoreboard extends uvm_component;

  `uvm_component_utils(fifo_scoreboard)

  // Analysis ports
  uvm_analysis_imp_write #(write_trans, fifo_scoreboard) write_imp;
  uvm_analysis_imp_read  #(read_trans , fifo_scoreboard) read_imp;

  // Reference FIFO model
  bit [7:0] expected_q[$];

  // Statistics counters
  int total_writes;
  int total_reads;

  int pass_count;
  int fail_count;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);

    write_imp = new("write_imp", this);
    read_imp  = new("read_imp" , this);
  endfunction


  // WRITE side analysis
  function void write_write(write_trans t);

    expected_q.push_back(t.data);
    total_writes++;

    `uvm_info("SCB",
      $sformatf("WRITE PUSH %0d  qsize=%0d",
      t.data, expected_q.size()),
      UVM_LOW)

  endfunction


  // READ side analysis
  function void write_read(read_trans t);

    bit [7:0] exp;

    total_reads++;

    if(expected_q.size()==0) begin
      `uvm_error("SCB","READ when queue empty")
      fail_count++;
      return;
    end

    exp = expected_q.pop_front();

    `uvm_info("SCB",
      $sformatf("COMPARE exp=%0d got=%0d",
      exp, t.data),
      UVM_LOW)

    if(exp != t.data) begin
        `uvm_error("SCB","FIFO mismatch")
        fail_count++;
    end
    else begin
        pass_count++;
    end

  endfunction


  // Final report
  function void report_phase(uvm_phase phase);

    int total;
    real accuracy;

    total = pass_count + fail_count;

    if(total > 0)
      accuracy = (pass_count * 100.0) / total;
    else
      accuracy = 0;

    `uvm_info("SCB_SUMMARY",
              $sformatf("
---------------- FIFO SCOREBOARD SUMMARY ----------------
Total Writes : %0d \nTotal Reads  : %0d\n
Read Pass    : %0d \nRead Fail    : %0d
Total Pass   : %0d \nTotal Fail   : %0d
Accuracy     : %0.2f %%
---------------------------------------------------------",
      total_writes,
      total_reads,
      pass_count,
      fail_count,
      pass_count,
      fail_count,
      accuracy),
      UVM_NONE)

  endfunction

endclass