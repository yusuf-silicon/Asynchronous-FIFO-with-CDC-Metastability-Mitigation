dut_top = FIFO

top_default_seq_count = 900

top_env_inc_inside_class = top_env_inc_inside_class.sv inline
top_env_prepend_to_build_phase  = top_env_build_phase_inc.sv inline
top_env_append_to_connect_phase  = top_env_connect_phase_inc.sv inline