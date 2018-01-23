set_family {SmartFusion2}
read_adl {C:\Users\calplug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.adl}
map_netlist
read_sdc {C:\Users\calplug\Desktop\Servo-arm2\constraint\SF2_MSS_sys_derived_constraints.sdc}
check_constraints {C:\Users\calplug\Desktop\Servo-arm2\designer\SF2_MSS_sys\placer_coverage.log}
write_sdc -strict {C:\Users\calplug\Desktop\Servo-arm2\designer\SF2_MSS_sys\place_route.sdc}
