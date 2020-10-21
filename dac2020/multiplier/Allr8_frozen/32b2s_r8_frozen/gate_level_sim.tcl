power test1.uut1
run 40ns
power -enable
run 10000ns
power -disable
power -report netlist.saif 1e-9 test1.uut1
quit
