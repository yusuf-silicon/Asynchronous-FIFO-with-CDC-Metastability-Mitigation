// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: read_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Package for agent read
//=============================================================================

package read_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "read_read_trans.sv"
  `include "read_config.sv"
  `include "read_driver.sv"
  `include "read_monitor.sv"
  `include "read_sequencer.sv"
  `include "read_coverage.sv"
  `include "read_agent.sv"
  `include "read_seq_lib.sv"

endpackage : read_pkg
