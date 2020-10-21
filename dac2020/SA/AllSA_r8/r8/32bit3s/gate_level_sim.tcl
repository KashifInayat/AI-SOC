power uut1
run 200ns
power -enable
run 200ns
power -disable
power -report netlist.saif 1e-9 uut1
quit
