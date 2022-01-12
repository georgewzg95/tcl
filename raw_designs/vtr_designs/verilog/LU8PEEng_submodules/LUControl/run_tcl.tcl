#updated on Jan 11
set outputDir /misc/scratch/zwei1/reports_Jan12/raw_designs/vtr_designs/verilog/LU8PEEng_submodules/LUControl
file mkdir $outputDir
read_verilog -quiet /misc/scratch/zwei1/raw_data/raw_designs/vtr_designs/verilog/LU8PEEng_submodules/LUControl.v
synth_design -part xc7z020clg484-3 -top LUControl -mode out_of_context
#synth_design -part xc7v585tffg1761-3 -top attention
set_units -power mW
create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

write_checkpoint -force $outputDir/post_synth
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_power -file $outputDir/post_synth_power.rpt

opt_design
power_opt_design
place_design
phys_opt_design
write_checkpoint -force $outputDir/post_place
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

route_design
write_checkpoint -force $outputDir/post_route
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
#write_verilog -force $outputDir/xxx.v
#write_xdc -no_fixed_only -force $outputDir/xxx.xdc
#
#write_bitstream -force $outputDir/xxx.bit
