# module load syn/syn/2013
# run this file with: dc_shell-xg-t -f dcopt.tcl | tee dcopt.out
# evince /usr/local/packages/SAED32_EDK/lib/stdcell_rvt/doc/SAED32.28nm_Digital_Standard_Cell_Library_b100_01312012.pdf
# or http://esc.inu.ac.kr/~chung/SAED_DOC.pdf

set search_path [list .]

set edk_home /soc/vlsi/PDK/SAED32_EDK_01132015/
set io_dir $edk_home/lib/io_std
set pll_dir $edk_home/lib/pll
set stdcell_dir $edk_home/lib/stdcell_hvt

## Setup DB
set io_db_dir $io_dir/db_nldm
set pll_db_dir $pll_dir/db_nldm
set stdcell_db_dir $stdcell_dir/db_nldm

set synthetic_library dw_foundation.sldb

set link_library "*  $stdcell_db_dir/saed32hvt_ss0p95v125c.db   $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db  $io_db_dir/saed32io_fc_ss0p95v125c_2p25v.db     $synthetic_library"
set target_library "  $stdcell_db_dir/saed32hvt_ss0p95v125c.db  $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db   $io_db_dir/saed32io_fc_ss0p95v125c_2p25v.db  "


sh rm -rf ./WORK
define_design_lib WORK -path WORK


set hpe $array_size
set vpe $array_size
## Setup DB Done


#aet bitwidth 8
#read_file -f verilog ./top.v 

#analyze -format verilog ./BLACKBOX.v -library WORK
#analyze -format verilog ./topdelay.v -library WORK -define [list "HPE=$hpe" "VPE=$vpe"]


#elaborate top_sa_2D
#compile_ultra -gate_clock -no_autoungroup

#set_dont_touch [get_designs PE_OS_16_R8]

set reports_dir reports
set final_reports_dir final_reports



set reports_dir reports_$hpe\_$vpe
set final_reports_dir final_reports_$hpe\_$vpe
set design_dir designs_$hpe\_$vpe


if { ! [ file exists $reports_dir ] } { 
         file mkdir $reports_dir 
} 

if { ! [ file exists $final_reports_dir ] } {
         file mkdir $final_reports_dir
}

if { ! [ file exists $design_dir] } { 
         file mkdir $design_dir
} 

 
if { $array_size==256 } { 
analyze -format verilog ./sa_2D2s_256.v -library WORK
} else {
analyze -format verilog ./sa_2D2s.v -library WORK
}
elaborate -parameters $hpe,$vpe sa_2D


set target_clock_period 1.26

#set max_opcon saed32rvt_ff0p85v125c
#set_operating_conditions -min ff1p16v125c  -max ss0p95v125c

# I don't know why DC cannot support MCMM correctly, so I put only one corner here for now

#set_operating_conditions -max ss0p95v125c

set current_design pre_process_TMY
ungroup -all -flatten
create_clock CLK -period $target_clock_period
set_driving_cell -lib_cell DFFX1_HVT [remove_from_collection [remove_from_collection [all_inputs] CLK] RST]  -pin Q
set_input_delay 0.20 -clock CLK [all_inputs]
remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
set_output_delay 0 -clock CLK [all_outputs]
set_register_output_inversion [get_cells my_out*] false
compile_ultra -gate_clock
set_dont_touch [get_designs pre_process_TMY]
set current_design pre_process_be
ungroup -all -flatten
create_clock CLK -period $target_clock_period
set_driving_cell -lib_cell DFFX1_HVT [remove_from_collection [remove_from_collection [all_inputs] CLK] RST]  -pin Q
set_input_delay 0.20 -clock CLK [all_inputs]
remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
set_output_delay 0 -clock CLK [all_outputs]
compile_ultra -gate_clock
set_dont_touch [get_designs pre_process_be]





##
# we want our chip to operate 3Ghz 
##
#set_ungroup objectfalse
#set current_design mb32

set current_design sa_2D_HPE$hpe\_VPE$vpe
ungroup -all -flatten

#write_file -f verilog -hier -output tmp.v

#set current_design top_sa_2D

#set_optimize_registers

# 100 mhz
# set the constraint for flop-to-flop paths
  
create_clock CLK -period $target_clock_period
# set the constraint for paths starting from primary inputs
#set_input_delay 0 -clock CLK [all_inputs]
#remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
#set_output_delay 0 -clock CLK [all_outputs]

set_driving_cell -lib_cell DFFX1_HVT [remove_from_collection [remove_from_collection [all_inputs] CLK] RST]  -pin Q
set_input_delay 0.20 -clock CLK [all_inputs]
remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
set_output_delay 0 -clock CLK [all_outputs]

# this is another way to set the constraint for primary input-to-output paths. Use this for combinational logic circuits.
# set_max_delay 0.33 -from [all_inputs] -to [all_outputs]

# first compile

#set_dont_use {saed32hvt_ss0p95v125c/DFFX2_HVT}
#set_dont_use {saed32hvt_ss0p95v125c/DFFX2_HVT saed32hvt_ss0p95v125c/DFFSSRX2_HVT saed32hvt_ss0p95v125c/DFFSSRX1_HVT}

#compile_ultra -gate_clock  -no_autoungroup

#set_dont_touch core
#set_structure false
#compile ultra
#compile_ultra -top

# create the scan chains
# insert_dft
#set_dont_touch core
# second compile
#compile_ultra -incr



#report_qor > $reports_dir/qor_report.txt
#report_constraint -all_violators > $reports_dir/violator_report.txt
#report_register -level_sensitive > $reports_dir/latch_report.txt
#report_clock_gating > $reports_dir/clock_gating.txt
#report_area
#report_timing



#remove_design PE_OS_16_R8
read_file -f ddc designs/PE.ddc
set current_design sa_2D_HPE$hpe\_VPE$vpe
link

write_file -f ddc -hier -output $design_dir/postdc_netlistr42s.ddc
write_file -f verilog -hier -output $design_dir/postdc_netlistr42s.v

report_timing > $final_reports_dir/delay.txt
sh cat $final_reports_dir/delay.txt
set current_design sa_2D_HPE$hpe\_VPE$vpe
report_area > $final_reports_dir/area.txt
sh cat $final_reports_dir/area.txt

exit
#remove_design
