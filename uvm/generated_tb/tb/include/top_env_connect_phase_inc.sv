`uvm_info("DEBUG","Scoreboard connect_phase executing",UVM_LOW)
m_write_agent.m_monitor.analysis_port.connect(scb.write_imp);
m_read_agent.m_monitor.analysis_port.connect(scb.read_imp);