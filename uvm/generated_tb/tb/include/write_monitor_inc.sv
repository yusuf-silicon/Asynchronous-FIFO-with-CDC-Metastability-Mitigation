task write_monitor::do_mon();

  forever begin
    @(posedge vif.write_clk);

    if (vif.wr_en && !vif.full) begin
        m_trans.data = vif.data_in;

        `uvm_info("WRITE_MON",
           $sformatf("WRITE data = %0h", vif.data_in),
           UVM_LOW)

        analysis_port.write(m_trans);
    end

  end

endtask