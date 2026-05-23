// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: read_config.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Configuration for agent read
//=============================================================================

`ifndef READ_CONFIG_SV
`define READ_CONFIG_SV

// You can insert code here by setting agent_config_inc_before_class in file read_agent.tpl

class read_config extends uvm_object;

  // Do not register config class with the factory

  virtual read_if          vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  // You can insert variables here by setting config_var in file read_agent.tpl

  // You can remove new by setting agent_config_generate_methods_inside_class = no in file read_agent.tpl

  extern function new(string name = "");

  // You can insert code here by setting agent_config_inc_inside_class in file read_agent.tpl

endclass : read_config 


// You can remove new by setting agent_config_generate_methods_after_class = no in file read_agent.tpl

function read_config::new(string name = "");
  super.new(name);
endfunction : new


// You can insert code here by setting agent_config_inc_after_class in file read_agent.tpl

`endif // READ_CONFIG_SV

