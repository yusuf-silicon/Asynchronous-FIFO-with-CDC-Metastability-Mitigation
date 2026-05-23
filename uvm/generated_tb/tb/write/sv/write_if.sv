// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: write_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Signal interface for agent write
//=============================================================================

`ifndef WRITE_IF_SV
`define WRITE_IF_SV

interface write_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import write_pkg::*;

  logic rst				;
  logic write_clk		;
  logic wr_en			;
  logic [7:0] data_in	;
  logic full			;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file write_agent.tpl

endinterface : write_if

`endif // WRITE_IF_SV

