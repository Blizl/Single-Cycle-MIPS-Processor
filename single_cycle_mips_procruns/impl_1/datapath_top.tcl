proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.cache/wt [current_project]
  set_property parent.project_path C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.xpr [current_project]
  set_property ip_repo_paths c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.cache/ip [current_project]
  set_property ip_output_repo c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.cache/ip [current_project]
  add_files -quiet C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/synth_1/datapath_top.dcp
  add_files -quiet C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/instr_mem_synth_1/instr_mem.dcp
  set_property netlist_only true [get_files C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/instr_mem_synth_1/instr_mem.dcp]
  add_files -quiet C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/vio_0_synth_1/vio_0.dcp
  set_property netlist_only true [get_files C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/vio_0_synth_1/vio_0.dcp]
  add_files -quiet C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/data_memory_synth_1/data_memory.dcp
  set_property netlist_only true [get_files C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/data_memory_synth_1/data_memory.dcp]
  add_files -quiet C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/charLib_synth_1/charLib.dcp
  set_property netlist_only true [get_files C:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.runs/charLib_synth_1/charLib.dcp]
  read_xdc -mode out_of_context -ref instr_mem -cells U0 c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/instr_mem/instr_mem_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/instr_mem/instr_mem_ooc.xdc]
  read_xdc -mode out_of_context -ref vio_0 c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/vio_0/vio_0_ooc.xdc]
  read_xdc -ref vio_0 c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/vio_0/vio_0.xdc
  set_property processing_order EARLY [get_files c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/vio_0/vio_0.xdc]
  read_xdc -mode out_of_context -ref data_memory -cells U0 c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/data_memory/data_memory_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/leclair.m.NUNET/Downloads/lab7completed/lab7completed/lab7completed.srcs/sources_1/ip/data_memory/data_memory_ooc.xdc]
  read_xdc -mode out_of_context -ref charLib c:/Users/leclair.m.NUNET/Downloads/OLED_source_files/OLED_source_files/IP_srcs/charLib_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/leclair.m.NUNET/Downloads/OLED_source_files/OLED_source_files/IP_srcs/charLib_ooc.xdc]
  read_xdc C:/Users/leclair.m.NUNET/Downloads/datapath.xdc
  link_design -top datapath_top -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force datapath_top_opt.dcp
  catch {report_drc -file datapath_top_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file datapath_top.hwdef}
  place_design 
  write_checkpoint -force datapath_top_placed.dcp
  catch { report_io -file datapath_top_io_placed.rpt }
  catch { report_utilization -file datapath_top_utilization_placed.rpt -pb datapath_top_utilization_placed.pb }
  catch { report_control_sets -verbose -file datapath_top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force datapath_top_routed.dcp
  catch { report_drc -file datapath_top_drc_routed.rpt -pb datapath_top_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file datapath_top_timing_summary_routed.rpt -rpx datapath_top_timing_summary_routed.rpx }
  catch { report_power -file datapath_top_power_routed.rpt -pb datapath_top_power_summary_routed.pb }
  catch { report_route_status -file datapath_top_route_status.rpt -pb datapath_top_route_status.pb }
  catch { report_clock_utilization -file datapath_top_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force datapath_top.bit 
  catch { write_sysdef -hwdef datapath_top.hwdef -bitfile datapath_top.bit -meminfo datapath_top.mmi -ltxfile debug_nets.ltx -file datapath_top.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

