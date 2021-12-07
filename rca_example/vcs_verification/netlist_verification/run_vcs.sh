mkdir work
cd work
vcs -full64 ../tb_RCA_32b_final.v ../top.v /soc/vlsi/PDK/SAED32_EDK_01132015/lib/stdcell_rvt/verilog/saed32nm.v -debug -gui -o simv

./simv
