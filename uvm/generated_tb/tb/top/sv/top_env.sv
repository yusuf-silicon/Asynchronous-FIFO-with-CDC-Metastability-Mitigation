// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_env.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Environment for top
//=============================================================================

`ifndef TOP_ENV_SV
`define TOP_ENV_SV

// You can insert code here by setting top_env_inc_before_class in file common.tpl

class top_env extends uvm_env;

  `uvm_component_utils(top_env)

  extern function new(string name, uvm_component parent);


  // Child agents
  write_config    m_write_config;  
  write_agent     m_write_agent;   
  write_coverage  m_write_coverage;

  read_config     m_read_config;   
  read_agent      m_read_agent;    
  read_coverage   m_read_coverage; 

  top_config      m_config;
       
  // You can remove build/connect/run_phase by setting top_env_generate_methods_inside_class = no in file common.tpl

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);

  // Start of inlined include file generated_tb/tb/include/top_env_inc_inside_class.sv
  `include "fifo_scoreboard.sv"
  
  fifo_scoreboard scb;  // End of inlined include file

endclass : top_env 


function top_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


// You can remove build/connect/run_phase by setting top_env_generate_methods_after_class = no in file common.tpl

function void top_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)

  // Start of inlined include file generated_tb/tb/include/top_env_build_phase_inc.sv
  `uvm_info("DEBUG","Scoreboard build_phase executing",UVM_LOW)
  scb = fifo_scoreboard::type_id::create("scb", this);  // End of inlined include file

  if (!uvm_config_db #(top_config)::get(this, "", "config", m_config)) 
    `uvm_error(get_type_name(), "Unable to get top_config")

  m_write_config                 = new("m_write_config");         
  m_write_config.vif             = m_config.write_vif;            
  m_write_config.is_active       = m_config.is_active_write;      
  m_write_config.checks_enable   = m_config.checks_enable_write;  
  m_write_config.coverage_enable = m_config.coverage_enable_write;

  // You can insert code here by setting agent_copy_config_vars in file write_agent.tpl

  uvm_config_db #(write_config)::set(this, "m_write_agent", "config", m_write_config);
  if (m_write_config.is_active == UVM_ACTIVE )
    uvm_config_db #(write_config)::set(this, "m_write_agent.m_sequencer", "config", m_write_config);
  uvm_config_db #(write_config)::set(this, "m_write_coverage", "config", m_write_config);

  m_read_config                 = new("m_read_config");         
  m_read_config.vif             = m_config.read_vif;            
  m_read_config.is_active       = m_config.is_active_read;      
  m_read_config.checks_enable   = m_config.checks_enable_read;  
  m_read_config.coverage_enable = m_config.coverage_enable_read;

  // You can insert code here by setting agent_copy_config_vars in file read_agent.tpl

  uvm_config_db #(read_config)::set(this, "m_read_agent", "config", m_read_config);
  if (m_read_config.is_active == UVM_ACTIVE )
    uvm_config_db #(read_config)::set(this, "m_read_agent.m_sequencer", "config", m_read_config);
  uvm_config_db #(read_config)::set(this, "m_read_coverage", "config", m_read_config);


  m_write_agent    = write_agent   ::type_id::create("m_write_agent", this);
  m_write_coverage = write_coverage::type_id::create("m_write_coverage", this);

  m_read_agent     = read_agent    ::type_id::create("m_read_agent", this);
  m_read_coverage  = read_coverage ::type_id::create("m_read_coverage", this);

  // You can insert code here by setting top_env_append_to_build_phase in file common.tpl

endfunction : build_phase


function void top_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)

  m_write_agent.analysis_port.connect(m_write_coverage.analysis_export);

  m_read_agent.analysis_port.connect(m_read_coverage.analysis_export);


  // Start of inlined include file generated_tb/tb/include/top_env_connect_phase_inc.sv
  `uvm_info("DEBUG","Scoreboard connect_phase executing",UVM_LOW)
  m_write_agent.m_monitor.analysis_port.connect(scb.write_imp);
  m_read_agent.m_monitor.analysis_port.connect(scb.read_imp);  // End of inlined include file

endfunction : connect_phase


// You can remove end_of_elaboration_phase by setting top_env_generate_end_of_elaboration = no in file common.tpl

function void top_env::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  `uvm_info(get_type_name(), "Information printed from top_env::end_of_elaboration_phase method", UVM_MEDIUM)
  `uvm_info(get_type_name(), $sformatf("Verbosity threshold is %d", get_report_verbosity_level()), UVM_MEDIUM)
  uvm_top.print_topology();
  factory.print();
endfunction : end_of_elaboration_phase


// You can remove run_phase by setting top_env_generate_run_phase = no in file common.tpl

task top_env::run_phase(uvm_phase phase);
  top_default_seq vseq;
  vseq = top_default_seq::type_id::create("vseq");
  vseq.set_item_context(null, null);
  if ( !vseq.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize virtual sequence")
  vseq.m_write_agent = m_write_agent;
  vseq.m_read_agent  = m_read_agent; 
  vseq.set_starting_phase(phase);
  vseq.start(null);

  // You can insert code here by setting top_env_append_to_run_phase in file common.tpl

endtask : run_phase


// You can insert code here by setting top_env_inc_after_class in file common.tpl

`endif // TOP_ENV_SV

