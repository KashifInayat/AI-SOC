#vcs -full64 ./test.v ./sa_2D2s.v ./designs/PE.v ./designs/mult.v /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v -ld ld -LDFLAGS "/usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o" +v2k -sverilog -gui
if [ $# -eq 0 ] 
then
	echo "ex> ./run_vcs.sh [array size]"
	exit
fi
if [ $1 -eq 256 ]
then
vcs -full64 ./test_netlist_256.v ./designs_$1\_$1/postdc_netlistr42s.v /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v -ld ld -LDFLAGS "/usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o" +v2k -sverilog -gui +define+VPE=$1 +define+HPE=$1 +define+DUT=sa_2D_HPE$1\_VPE$1
else
vcs -full64 ./test_netlist.v ./designs_$1\_$1/postdc_netlistr42s.v /soc/vlsi/PDK/SAED32_EDK/lib/stdcell_hvt/verilog/saed32nm_hvt.v -ld ld -LDFLAGS "/usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o" +v2k -sverilog -gui +define+VPE=$1 +define+HPE=$1 +define+DUT=sa_2D_HPE$1\_VPE$1
fi
./simv -ucli -do gate_level_sim.tcl 
#+incdir+../../rtl/s_ice/ +define+SERIAL_MULTIPLIER_TEST
#-sverilog 
