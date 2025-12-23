vsim -c
vlog "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/src/main.v"
vlog "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/src/binary_to_gray.v"
vlog "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/src/gray_to_binary.v"
vlog "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/src/synchronizer.v"
vlog "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/tb/tb_main.v"
vsim "C:/Users/Yusuf/Documents/Production/VLSI/Projects/Async FIFO/work.tb_FIFO"
add wave -r /*
run -all