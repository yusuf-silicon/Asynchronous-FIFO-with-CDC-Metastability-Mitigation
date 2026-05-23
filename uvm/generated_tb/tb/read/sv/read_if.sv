// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: read_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Signal interface for agent read
//=============================================================================

`ifndef READ_IF_SV
`define READ_IF_SV

interface read_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import read_pkg::*;

  logic read_clk		;
  logic rd_en			;
  logic rd_valid		;
  logic [7:0] data_out	;
  logic empty			;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file read_agent.tpl

endinterface : read_if

`endif // READ_IF_SV

