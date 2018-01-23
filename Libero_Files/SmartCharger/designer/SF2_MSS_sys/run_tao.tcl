set_family {SmartFusion2}
read_vhdl -mode vhdl_2008 {C:\Users\andre\Desktop\Sr Design\Github\EVSE_Smart_Charger-master\EVSE_Smart_Charger\Libero_Files\SmartCharger\component\work\SF2_MSS_sys_sb_MSS\SF2_MSS_sys_sb_MSS.vhd}
read_vhdl -mode vhdl_2008 {C:\Users\andre\Desktop\Sr Design\Github\EVSE_Smart_Charger-master\EVSE_Smart_Charger\Libero_Files\SmartCharger\component\work\SF2_MSS_sys\SF2_MSS_sys.vhd}
set_top_level {SF2_MSS_sys}
map_netlist
read_sdc {C:\Users\andre\Desktop\Sr Design\Github\EVSE_Smart_Charger-master\EVSE_Smart_Charger\Libero_Files\SmartCharger\constraint\SF2_MSS_sys_derived_constraints.sdc}
check_constraints {C:\Users\andre\Desktop\Sr Design\Github\EVSE_Smart_Charger-master\EVSE_Smart_Charger\Libero_Files\SmartCharger\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\andre\Desktop\Sr Design\Github\EVSE_Smart_Charger-master\EVSE_Smart_Charger\Libero_Files\SmartCharger\designer\SF2_MSS_sys\synthesis.fdc}
