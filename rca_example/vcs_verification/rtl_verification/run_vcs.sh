mkdir work
cd work
vcs -full64 ../tb_RCA_32b_final.v ../full_adder_final.v ../powercontrol_final.v ../RCA_16b_final.v ../RCA_32b_final.v -debug -gui -o simv

./simv
