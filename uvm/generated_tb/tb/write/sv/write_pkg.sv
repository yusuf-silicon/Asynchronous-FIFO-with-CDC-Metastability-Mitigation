// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: write_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Package for agent write
//=============================================================================

package write_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "write_write_trans.sv"
  `include "write_config.sv"
  `include "write_driver.sv"
  `include "write_monitor.sv"
  `include "write_sequencer.sv"
  `include "write_coverage.sv"
  `include "write_agent.sv"
  `include "write_seq_lib.sv"

endpackage : write_pkg
