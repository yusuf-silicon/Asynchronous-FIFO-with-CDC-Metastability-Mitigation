// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: read_coverage.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Mar 14 15:57:18 2026
//=============================================================================
// Description: Coverage for agent read
//=============================================================================

`ifndef READ_COVERAGE_SV
`define READ_COVERAGE_SV

// You can insert code here by setting agent_cover_inc_before_class in file read_agent.tpl

class read_coverage extends uvm_subscriber #(read_trans);

  `uvm_component_utils(read_coverage)

  read_config m_config;    
  bit         m_is_covered;
  read_trans  m_item;
     
  // You can replace covergroup m_cov by setting agent_cover_inc in file read_agent.tpl
  // or remove covergroup m_cov by setting agent_cover_generate_methods_inside_class = no in file read_agent.tpl

  covergroup m_cov;
    option.per_instance = 1;
    // You may insert additional coverpoints here ...

    cp_rd_en: coverpoint m_item.rd_en;
    //  Add bins here if required

    cp_data: coverpoint m_item.data;
    //  Add bins here if required

  endgroup

  // You can remove new, write, and report_phase by setting agent_cover_generate_methods_inside_class = no in file read_agent.tpl

  extern function new(string name, uvm_component parent);
  extern function void write(input read_trans t);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  // You can insert code here by setting agent_cover_inc_inside_class in file read_agent.tpl

endclass : read_coverage 


// You can remove new, write, and report_phase by setting agent_cover_generate_methods_after_class = no in file read_agent.tpl

function read_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  m_is_covered = 0;
  m_cov = new();
endfunction : new


function void read_coverage::write(input read_trans t);
  m_item = t;
  if (m_config.coverage_enable)
  begin
    m_cov.sample();
    // Check coverage - could use m_cov.option.goal instead of 100 if your simulator supports it
    if (m_cov.get_inst_coverage() >= 100) m_is_covered = 1;
  end
endfunction : write


function void read_coverage::build_phase(uvm_phase phase);
  if (!uvm_config_db #(read_config)::get(this, "", "config", m_config))
    `uvm_error(get_type_name(), "read config not found")
endfunction : build_phase


function void read_coverage::report_phase(uvm_phase phase);
  if (m_config.coverage_enable)
    `uvm_info(get_type_name(), $sformatf("Coverage score = %3.1f%%", m_cov.get_inst_coverage()), UVM_MEDIUM)
  else
    `uvm_info(get_type_name(), "Coverage disabled for this agent", UVM_MEDIUM)
endfunction : report_phase


// You can insert code here by setting agent_cover_inc_after_class in file read_agent.tpl

`endif // READ_COVERAGE_SV

