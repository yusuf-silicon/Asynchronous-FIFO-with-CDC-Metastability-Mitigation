# TO RUN SCRIPT
# do ../../sim/run.do


# 1. Setup local environment
vlib work
vmap work work

# 2. Compile files (Using relative paths is better!)
vlog "../../rtl/main.v"
vlog "../../rtl/binary_to_gray.v"
vlog "../../rtl/gray_to_binary.v"
vlog "../../rtl/synchronizer.v"
vlog "../../tb/tb_main.v"

# 3. Load the simulation from the 'work' library
# Use -voptargs="+acc" so you can actually see the waves
#vsim -voptargs="+acc" work.tb_new

vsim work.tb_main

radix binary

#sim:/tb_main/*
add wave -group {TB} \
    -divider {General} \
    sim:/tb_main/uut/reset \
    sim:/tb_main/uut/ClkRead \
    sim:/tb_main/uut/ClkWrite \
    -divider {Input Controls} \
    sim:/tb_main/uut/HaltInput \
    sim:/tb_main/uut/ControlIn \
    sim:/tb_main/uut/ReadValid \
    sim:/tb_main/uut/haltInputDrive \
    sim:/tb_main/uut/readValid \
    -divider {Output Controls} \
    sim:/tb_main/uut/HaltOutput \
    sim:/tb_main/uut/ControlOut \
    sim:/tb_main/uut/dataOutReg \
    sim:/tb_main/uut/haltOutputDrive \
    -divider {Data Streams} \
    sim:/tb_main/uut/DataIn \
    sim:/tb_main/uut/DataOut \
    -divider {pointers} \
    sim:/tb_main/uut/ptrWriteBin \
    sim:/tb_main/uut/ptrReadBin \
    sim:/tb_main/uut/ptrReadGray \
    sim:/tb_main/uut/syncReadGray \
    sim:/tb_main/uut/syncReadBin \
    sim:/tb_main/uut/ptrWriteGray \
    sim:/tb_main/uut/syncWriteGray \
    sim:/tb_main/uut/syncWriteBin


add wave -group {MAIN} -position insertpoint sim:/tb_main/uut/*

add wave -group {TEMP} -position insertpoint \
sim:/tb_main/ClkRead\
sim:/tb_main/uut/DataOut\
sim:/tb_main/DataOut\
sim:/tb_main/uut/ptrReadBin\
sim:/tb_main/uut/syncWriteBin\
sim:/tb_main/HaltOutput\
sim:/tb_main/ReadValid\
sim:/tb_main/ControlOut\
sim:/tb_main/memOut\
sim:/tb_main/uut/mem

run -all
