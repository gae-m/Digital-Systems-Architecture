# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/biagi/5_Cronometro/5_Cronometro.cache/wt [current_project]
set_property parent.project_path C:/Users/biagi/5_Cronometro/5_Cronometro.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.3 [current_project]
set_property ip_output_repo c:/Users/biagi/5_Cronometro/5_Cronometro.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/Downloads/anodes_manager.vhd
  {C:/Users/biagi/Documents/OneDrive - UniversitÓ di Napoli Federico II/elaborato-asdi-shared/components/base_dei_tempi.vhd}
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/src/button_debouncer.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/src/cathodes_manager.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/display_7seg/clock_filter.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/contatore_mod24.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/contatore_mod60.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/convertitore_BCD.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/components/counter.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/cronometro.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/cronometro_sys.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/display_7seg/digits_splitter.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/display_7seg/display_7seg_manager.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/components/memory.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/imports/new/mux2to1.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/unita_controllo.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/unita_operativa.vhd
  C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/sources_1/new/cronometro_on_board.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/constrs_1/imports/code/Nexys-A7-100T-Master.xdc
set_property used_in_implementation false [get_files C:/Users/biagi/5_Cronometro/5_Cronometro.srcs/constrs_1/imports/code/Nexys-A7-100T-Master.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top cronometro_on_board -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cronometro_on_board.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cronometro_on_board_utilization_synth.rpt -pb cronometro_on_board_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
