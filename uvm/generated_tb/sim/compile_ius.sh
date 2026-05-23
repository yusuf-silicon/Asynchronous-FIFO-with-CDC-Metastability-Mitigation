#!/bin/sh
IUS_HOME=`ncroot`
irun -vtimescale 1ns/1ps -uvmhome ${IUS_HOME}/tools/methodology/UVM/CDNS-1.2 \
+incdir+../tb/include \
+incdir+../tb/write/sv \
+incdir+../tb/read/sv \
+incdir+../tb/top/sv \
+incdir+../tb/top_test/sv \
+incdir+../tb/top_tb/sv \
-F ../dut/files.f \
../tb/write/sv/write_pkg.sv \
../tb/write/sv/write_if.sv \
../tb/read/sv/read_pkg.sv \
../tb/read/sv/read_if.sv \
../tb/top/sv/top_pkg.sv \
../tb/top_test/sv/top_test_pkg.sv \
../tb/top_tb/sv/top_th.sv \
../tb/top_tb/sv/top_tb.sv \
+UVM_TESTNAME=top_test  $* 
