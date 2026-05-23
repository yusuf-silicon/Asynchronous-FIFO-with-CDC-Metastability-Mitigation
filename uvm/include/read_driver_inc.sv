task read_driver::do_drive();

  @(posedge vif.read_clk);

  if (!vif.empty) begin
    vif.rd_en <= 1;
    @(posedge vif.read_clk);
    vif.rd_en <= 0;
  end

endtask
