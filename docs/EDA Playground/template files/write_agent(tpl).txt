agent_name = write

trans_item = write_trans

trans_var = rand logic [7:0] data 	;
trans_var = 	 logic wr_en 		;

if_port = logic rst				;
if_port = logic write_clk		;
if_port = logic wr_en			;
if_port = logic [7:0] data_in	;
if_port = logic full			;

if_clock = write_clk


driver_inc = write_driver_inc.sv inline
monitor_inc = write_monitor_inc.sv inline