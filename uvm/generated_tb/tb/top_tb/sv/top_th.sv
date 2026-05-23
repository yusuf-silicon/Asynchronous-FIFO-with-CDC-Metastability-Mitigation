// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_th.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Test Harness
//=============================================================================

module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // You can remove clock and reset below by setting th_generate_clock_and_reset = no in file common.tpl

  // Example clock and reset declarations
  logic clock = 0;
  logic reset;

  // Example clock generator process
  always #10 clock = ~clock;

  // Example reset generator process
  initial
  begin
    reset = 0;         // Active low reset in this example
    #75 reset = 1;
  end

  assign write_if_0.write_clk = clock;
  assign read_if_0.read_clk   = clock;

  // You can insert code here by setting th_inc_inside_module in file common.tpl

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  write_if  write_if_0 ();
  read_if   read_if_0 (); 

  FIFO uut (
    .reset     (write_if_0.rst),
    .ClkWrite  (write_if_0.write_clk),
    .ControlIn (write_if_0.wr_en),
    .DataIn    (write_if_0.data_in),
    .HaltInput (write_if_0.full),
    .ClkRead   (read_if_0.read_clk),
    .ControlOut(read_if_0.rd_en),
    .ReadValid (read_if_0.rd_valid),
    .DataOut   (read_if_0.data_out),
    .HaltOutput(read_if_0.empty)
  );

endmodule

