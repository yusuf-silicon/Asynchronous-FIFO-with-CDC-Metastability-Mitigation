// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: read_seq_item.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Sequence item for read_sequencer
//=============================================================================

`ifndef READ_SEQ_ITEM_SV
`define READ_SEQ_ITEM_SV

// You can insert code here by setting trans_inc_before_class in file read_agent.tpl

class read_trans extends uvm_sequence_item; 

  `uvm_object_utils(read_trans)

  // To include variables in copy, compare, print, record, pack, unpack, and compare2string, define them using trans_var in file read_agent.tpl
  // To exclude variables from compare, pack, and unpack methods, define them using trans_meta in file read_agent.tpl

  // Transaction variables
  logic rd_en		;
  logic [7:0] data		;


  extern function new(string name = "");

  // You can remove do_copy/compare/print/record and convert2string method by setting trans_generate_methods_inside_class = no in file read_agent.tpl
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

  // You can insert code here by setting trans_inc_inside_class in file read_agent.tpl

endclass : read_trans 


function read_trans::new(string name = "");
  super.new(name);
endfunction : new


// You can remove do_copy/compare/print/record and convert2string method by setting trans_generate_methods_after_class = no in file read_agent.tpl

function void read_trans::do_copy(uvm_object rhs);
  read_trans rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  rd_en = rhs_.rd_en;
  data  = rhs_.data; 
endfunction : do_copy


function bit read_trans::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  read_trans rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("rd_en", rd_en, rhs_.rd_en, $bits(rd_en));
  result &= comparer.compare_field("data", data,   rhs_.data,  $bits(data));
  return result;
endfunction : do_compare


function void read_trans::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void read_trans::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  // Use the record macros to record the item fields:
  `uvm_record_field("rd_en", rd_en)
  `uvm_record_field("data",  data) 
endfunction : do_record


function void read_trans::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(rd_en) 
  `uvm_pack_int(data)  
endfunction : do_pack


function void read_trans::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(rd_en) 
  `uvm_unpack_int(data)  
endfunction : do_unpack


function string read_trans::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "rd_en = 'h%0h  'd%0d\n", 
    "data  = 'h%0h  'd%0d\n"},
    get_full_name(), rd_en, rd_en, data, data);
  return s;
endfunction : convert2string


// You can insert code here by setting trans_inc_after_class in file read_agent.tpl

`endif // READ_SEQ_ITEM_SV

