# ####################################################################

#  Created by Encounter(R) RTL Compiler v08.10-s222_1 on Fri Jun 22 16:04:07 CEST 2012

# ####################################################################

set sdc_version 1.7
set PERIOD  7.0
set CLOCK_LATENCY 1.5

#set_units -capacitance 1.0fF
#set_units -time 1000.0ps

# Set the current design
current_design RCA_32b_final

#create_clock -name "main_clk" -add -period 1 -waveform {0.0 0.5} [get_ports clk]

create_clock -name "clock" -period $PERIOD [get_ports clk]
set_clock_latency $CLOCK_LATENCY [get_clocks clock]
set_clock_uncertainty 0.3 [get_clocks clock]
set_clock_transition 0.4 [get_clocks clock]


#set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
#set_dont_use [get_lib_cells NangateOpenCellLibrary/ANTENNA_X1]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X1]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X2]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X4]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X8]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X16]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/FILLCELL_X32]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/LOGIC0_X1]
#set_dont_use [get_lib_cells NangateOpenCellLibrary/LOGIC1_X1]

#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/HEADER_X1]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/HEADER_X2]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/HEADER_X4]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0N_X1]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0N_X2]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0N_X4]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0_X1]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0_X2]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE0_X4]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1N_X1]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1N_X2]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1N_X4]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1_X1]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1_X2]
#set_dont_use [get_lib_cells LowPowerOpenCellLibrary/ISO_FENCE1_X4]
