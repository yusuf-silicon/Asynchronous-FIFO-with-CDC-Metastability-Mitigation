static bit first = 1;

task write_driver::do_drive();

  if (first) begin
    @(posedge vif.write_clk);
    vif.rst <= 1;

    repeat (5) @(posedge vif.write_clk);

    vif.rst <= 0;

    repeat (5) @(posedge vif.write_clk);

    first = 0;
  end

  // Wait until reset finished
  wait(!vif.rst);

  // Drive transaction
  vif.data_in <= req.data;

  @(posedge vif.write_clk);
  vif.wr_en <= 1;

  `uvm_info("WRITE_DRV",
  $sformatf("WRITE: data=%0d full=%0b", req.data, vif.full),
  UVM_MEDIUM)

  @(posedge vif.write_clk);
  vif.wr_en <= 0;

endtask