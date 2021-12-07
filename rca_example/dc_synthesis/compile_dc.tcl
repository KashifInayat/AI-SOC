#/* SET libraries                                 */
set search_path [list .]

set edk_home /soc/vlsi/PDK/SAED32_EDK_01132015
set io_dir $edk_home/lib/io_std
set pll_dir $edk_home/lib/pll
set stdcell_dir $edk_home/lib/stdcell_rvt
set sram_dir $edk_home/lib/sram_lp

## Setup DB
set io_db_dir $io_dir/db_nldm
set pll_db_dir $pll_dir/db_nldm
set stdcell_db_dir $stdcell_dir/db_nldm
set sram_db_dir $sram_dir/db_nldm


set synthetic_library dw_foundation.sldb


set link_library "* $stdcell_db_dir/saed32rvt_dlvl_ss0p7v125c_i0p7v.db $stdcell_db_dir/saed32rvt_dlvl_ss0p7v125c_i0p95v.db $stdcell_db_dir/saed32rvt_dlvl_ss0p95v125c_i0p95v.db $stdcell_db_dir/saed32rvt_pg_ss0p7v125c.db $stdcell_db_dir/saed32rvt_pg_ss0p95v125c.db $stdcell_db_dir/saed32rvt_ss0p7v125c.db $stdcell_db_dir/saed32rvt_ss0p95v125c.db $stdcell_db_dir/saed32rvt_ulvl_ss0p7v125c_i0p7v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p75v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p7v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p95v.db $sram_db_dir/saed32sramlp_ss0p7v125c_i0p7v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p75v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p7v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p95v.db $sram_db_dir/saed32sramlp_ss0p95v25c_i0p75v.db $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db $synthetic_library"


set target_library "  $stdcell_db_dir/saed32rvt_dlvl_ss0p7v125c_i0p7v.db $stdcell_db_dir/saed32rvt_dlvl_ss0p7v125c_i0p95v.db $stdcell_db_dir/saed32rvt_dlvl_ss0p95v125c_i0p95v.db $stdcell_db_dir/saed32rvt_pg_ss0p7v125c.db $stdcell_db_dir/saed32rvt_pg_ss0p95v125c.db $stdcell_db_dir/saed32rvt_ss0p7v125c.db $stdcell_db_dir/saed32rvt_ss0p95v125c.db $stdcell_db_dir/saed32rvt_ulvl_ss0p7v125c_i0p7v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p75v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p7v.db $stdcell_db_dir/saed32rvt_ulvl_ss0p95v125c_i0p95v.db $sram_db_dir/saed32sramlp_ss0p7v125c_i0p7v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p75v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p7v.db $sram_db_dir/saed32sramlp_ss0p95v125c_i0p95v.db $sram_db_dir/saed32sramlp_ss0p95v25c_i0p75v.db $pll_db_dir/saed32pll_ss0p95v125c_2p25v.db "

#/* All verilog files, separated by spaces         */
set my_verilog_files [list ../full_adder_final.v ../powercontrol_final.v ../RCA_16b_final.v ../RCA_32b_final.v]

#/* Top-level Module                               */
set my_toplevel RCA_32b_final

#*/ Setting paths for outputs and reports              */
set reports_dir reports
set designs_dir designs
set _CONSTRAINTS_PATH Constraints 
set analyze_dir analyze
if { ! [ file exists $reports_dir ] } { 
         file mkdir $reports_dir 
} 
if { ! [ file exists $designs_dir] } { 
         file mkdir $designs_dir
} 

if {![file exists ${_CONSTRAINTS_PATH}]} {
  file mkdir ${_CONSTRAINTS_PATH}
  puts "Creating directory ${_CONSTRAINTS_PATH}"
}

#*/ Analyze the design                               */
analyze -f verilog $my_verilog_files 

read_file -format verilog {../RCA_32b_final.v}

set upf_create_implicit_supply_sets false

#*/ Set power intent and environment                */
source -echo -verb ../final.upf


set_voltage 0.7 -obj {VDDL}
set_voltage 0.95 -obj {VDD }
set_voltage 0.000 -obj {VSS}

name_format \
  -isolation_prefix "ISO_" \
  -level_shift_prefix "LS_"


#*/ Set timing constraints                           */
source -echo ../rca.sdc

#*/ Link and Check and report any violations         */ 
link
if {[link] ==0} {
echo “Linking Error”
exit; 
}

check_design

if {[check_design] ==0} {
echo “Check Design Error”
exit; 
}


#*/ Some library settings                             */
remove_attribute   saed32rvt_ss0p7v125c/ISOL* dont_use
remove_attribute   saed32rvt_ss0p7v125c/ISOL* dont_touch
remove_attribute   saed32rvt_ss0p95v125c/ISOL* dont_touch
remove_attribute   saed32rvt_ss0p95v125c/ISOL* dont_use

#*/ Compile                                            */	
compile_ultra

#*/ Report constraint violations                       */

report_constraint -all_violators

#*/ Reports and outputs                                */
report_timing
report_area

report_qor > $reports_dir/qor_report.txt
report_constraint -all_violators > $reports_dir/violator_report.txt
report_register -level_sensitive > $reports_dir/latch_report.txt
report_clock_gating > $reports_dir/clock_gating.txt
report_area > $reports_dir/area.txt
report_timing > > $reports_dir/delay.txt
report_power -hier > $reports_dir/power.txt

write_file -f verilog -hier -output $designs_dir/top.v
write_file -f ddc -hier -output $designs_dir/top.ddc

save_upf >  $_CONSTRAINTS_PATH/out.upf 

quit
