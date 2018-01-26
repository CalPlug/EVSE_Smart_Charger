set_family {SmartFusion2}
read_adl {D:\Microsemiprj\UC_Irvine\NewProject\PWM_8ch_16b_Creative\designer\SF2_MSS_sys\SF2_MSS_sys.adl}
map_netlist
read_sdc {D:\Microsemiprj\UC_Irvine\NewProject\PWM_8ch_16b_Creative\constraint\SF2_MSS_sys_derived_constraints.sdc}
check_constraints {D:\Microsemiprj\UC_Irvine\NewProject\PWM_8ch_16b_Creative\constraint\timing_sdc_errors.log}
write_sdc -strict {D:\Microsemiprj\UC_Irvine\NewProject\PWM_8ch_16b_Creative\designer\SF2_MSS_sys\timing_analysis.sdc}
