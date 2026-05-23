task read_monitor::do_mon();

  forever begin
    @(posedge vif.read_clk);

    if (vif.rd_valid) begin

      m_trans.data = vif.data_out;

      `uvm_info("READ_MON",
      $sformatf("READ DATA %0d empty=%0b", vif.data_out, vif.empty),
      UVM_MEDIUM)

      analysis_port.write(m_trans);

    end

  end

endtask