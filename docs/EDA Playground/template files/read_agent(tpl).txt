agent_name = read

trans_item = read_trans

trans_var = logic rd_en		;
trans_var = logic [7:0] data		;

if_port = logic read_clk		;
if_port = logic rd_en			;
if_port = logic rd_valid		;
if_port = logic [7:0] data_out	;
if_port = logic empty			;

if_clock = read_clk

driver_inc = read_driver_inc.sv inline
monitor_inc = read_monitor_inc.sv inline
