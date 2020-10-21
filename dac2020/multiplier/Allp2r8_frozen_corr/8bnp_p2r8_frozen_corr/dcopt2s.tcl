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
## Setup DB Done

#aet bitwidth 8
read_file -f verilog ./p2r8_8bit2s.v
read_file -f verilog ./mb8_with_load.v
#read_file -f verilog ./topdelay2s.v

set reports_dir reports
set final_reports_dir final_reports


if { ! [ file exists $reports_dir ] } {
         file mkdir $reports_dir
}
if { ! [ file exists $final_reports_dir ] } { 
         file mkdir $final_reports_dir 
} 

if { ! [ file exists designs] } {
         file mkdir designs
}



#set max_opcon saed32rvt_ff0p85v125c
#set_operating_conditions -min ff1p16v125c  -max ss0p95v125c

# I don't know why DC cannot support MCMM correctly, so I put only one corner here for now

#set_operating_conditions -max ss0p95v125c


##
##
# we want our chip to operate 3Ghz 
##
#set_ungroup objectfalse
#set_dont_retime [get_cell s1*]
#set_dont_retime [get_cell d1*]
#set_dont_retime [get_cell t1*]
#set_dont_retime [get_cell q1*]
#set_dont_retime [get_cell n1*]
#set_dont_retime [get_cell my1*]
#set_dont_retime [get_cell tmy1*]
#set_dont_retime [get_cell product1*]
set_register_type -exact [get_cells s1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells d1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells t1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells q1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells n1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells my1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells tmy1*] -flip_flop DFFX1_HVT
set_register_type -exact [get_cells product1*] -flip_flop DFFX1_HVT

set current_design mb8

#get_cell sbuf*/*
#set_dont_touch [get_cell sbuf*/*]

ungroup -all -flatten

#get_cell sbuf*
#optimize_registers
#set current_design mb16_top
set current_design mb8_with_load


# 100 mhz
# set the constraint for flop-to-flop paths

#create_clock CLK -period [expr 1000.0 /775]

#create_clock CLK -period [expr 1000.0 /730]
#create_clock CLK -period 1.26

#set target_clock_period 1.24
set target_clock_period 1.48

create_clock CLK -period $target_clock_period
#.26

set_driving_cell -lib_cell DFFX1_HVT [remove_from_collection [remove_from_collection [all_inputs] CLK] RST]  -pin Q
set_input_delay 0.20 -clock CLK [all_inputs]

# set the constraint for paths starting from primary inputs
#set_input_delay 0 -clock CLK [all_inputs]
remove_input_delay [get_ports "CLK RST"]
# set the constraint for paths starting from primary inputs
set_output_delay 0 -clock CLK [all_outputs]

#optimize_registers
# this is another way to set the constraint for primary input-to-output paths. Use this for combinational logic circuits.
# set_max_delay 0.33 -from [all_inputs] -to [all_outputs]

# first compile
#set_dont_touch systolic_array_2D


set compile_disable_hierarchical_inverter_opt true

#set_register_type -exact [get_cells uut/mx_reg*] -flip_flop DFFX1_HVT
#set_register_type -exact [get_cells uut/my_reg*] -flip_flop DFFX1_HVT
#set_dont_use {saed32hvt_ss0p95v125c/DFFX2_HVT saed32hvt_ss0p95v125c/DFFSSRX2_HVT saed32hvt_ss0p95v125c/DFFSSRX1_HVT}


compile_ultra -gate_clock -no_autoungroup 
#-retime
#optimize_registers
#set_dont_touch core
#set_structure false
#compile ultra
#compile_ultra -top
#optimize_registers

# create the scan chains
# insert_dft
#set_dont_touch core
# second compile
#compile_ultra -incr -no_autoungroup

#optimize_registers

#redirect change_names { change_names -rules verilog -hierarchy -verbose }
#remove_cell [get_cell sbuf*]


report_qor > $reports_dir/qor_report.txt
report_constraint -all_violators > $reports_dir/violator_report.txt
report_register -level_sensitive > $reports_dir/latch_report.txt
report_clock_gating > $reports_dir/clock_gating.txt
report_area
report_timing
report_power -hier > $reports_dir/power.txt

## to measure qor
set_dont_touch [get_designs mb8]
read_file -f verilog ./mb8_td.v
read_file -f verilog ./topdelay2s.v

create_clock CLK -period $target_clock_period
compile_ultra -gate_clock -no_autoungroup 

write_file -f verilog -hier -output designs/postdc_netlistp2r82s.v
write_file -f ddc -hier -output designs/postdc_netlistp2r82s.ddc

report_timing
report_timing > $final_reports_dir/delay.txt
current_design mb8_td
report_area
report_area > $final_reports_dir/area.txt
report_register > $final_reports_dir/register.txt

#remove_design
