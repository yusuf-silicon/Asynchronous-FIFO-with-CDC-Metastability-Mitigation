// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_tb.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Testbench
//=============================================================================

module top_tb;

  timeunit      1ns;
  timeprecision 1ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import top_test_pkg::*;
  import top_pkg::top_config;

  // Configuration object for top-level environment
  top_config top_env_config;

  // Test harness
  top_th th();

  // You can insert code here by setting tb_inc_inside_module in file common.tpl

  // You can remove the initial block below by setting tb_generate_run_test = no in file common.tpl

  initial
  begin
    // You can insert code here by setting tb_prepend_to_initial in file common.tpl

    // Create and populate top-level configuration object
    top_env_config = new("top_env_config");
    if ( !top_env_config.randomize() )
      `uvm_error("top_tb", "Failed to randomize top-level configuration object" )

    top_env_config.write_vif             = th.write_if_0;
    top_env_config.is_active_write       = UVM_ACTIVE;   
    top_env_config.checks_enable_write   = 1;            
    top_env_config.coverage_enable_write = 1;            

    top_env_config.read_vif              = th.read_if_0; 
    top_env_config.is_active_read        = UVM_ACTIVE;   
    top_env_config.checks_enable_read    = 1;            
    top_env_config.coverage_enable_read  = 1;            


    uvm_config_db #(top_config)::set(null, "uvm_test_top", "config", top_env_config);
    uvm_config_db #(top_config)::set(null, "uvm_test_top.m_env", "config", top_env_config);

    // You can insert code here by setting tb_inc_before_run_test in file common.tpl

    run_test();
  end

endmodule

