`uvm_info("DEBUG","Scoreboard build_phase executing",UVM_LOW)
scb = fifo_scoreboard::type_id::create("scb", this);