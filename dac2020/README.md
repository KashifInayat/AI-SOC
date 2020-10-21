This is the DAC2020 Factored Systolic Array verilog code sources of unsigned multipliers and 8x8,16x16,32x32,64x64,128x128 in verilog with TCL and Shell files of synopsys tools VCS, DC, PrimeTime PX, PrimePower. 


SAs usage:
1) copy the right multiplier into  ./designs/mult.ddc
2) dc_shell-xg-t -f dcopt_PE.tcl (to synthesize PE)
3) ./run_dc.sh [array_size]  (.e.g., ./run_dc.sh 16) for DC
4) ./run_vcs.sh [array_zie] for VCS
5) ./run_pt.sh [array_size] for PrimeTime Px/PrimePower

Multiplier usage:
1) ./run_dc.sh  for DC
2) ./run_vcs.sh for VCS
3) ./run_pt.sh  for PrimeTime Px/PrimePower
