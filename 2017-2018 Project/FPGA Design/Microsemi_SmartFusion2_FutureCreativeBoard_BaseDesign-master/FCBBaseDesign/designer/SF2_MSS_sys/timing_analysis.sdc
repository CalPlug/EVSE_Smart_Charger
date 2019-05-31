# Microsemi Corp.
# Date: 2017-Mar-06 08:54:17
# This file was generated based on the following SDC source files:
#   D:/Microsemiprj/UC_Irvine/NewProject/PWM_8ch_16b_Creative/constraint/SF2_MSS_sys_derived_constraints.sdc
#

create_clock -name {SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {SF2_MSS_sys_sb_0/CCC_0/GL0} -multiply_by 7 -divide_by 5 -source [ get_pins { SF2_MSS_sys_sb_0/CCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { SF2_MSS_sys_sb_0/CCC_0/CCC_INST/GL0 } ]
create_generated_clock -name {SF2_MSS_sys_sb_0/CCC_0/GL1} -multiply_by 7 -divide_by 350 -source [ get_pins { SF2_MSS_sys_sb_0/CCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { SF2_MSS_sys_sb_0/CCC_0/CCC_INST/GL1 } ]
set_false_path -through [ get_nets { SF2_MSS_sys_sb_0/CORERESETP_0/ddr_settled SF2_MSS_sys_sb_0/CORERESETP_0/count_ddr_enable SF2_MSS_sys_sb_0/CORERESETP_0/release_sdif*_core SF2_MSS_sys_sb_0/CORERESETP_0/count_sdif*_enable } ]
set_false_path -from [ get_cells { SF2_MSS_sys_sb_0/CORERESETP_0/MSS_HPMS_READY_int } ] -to [ get_cells { SF2_MSS_sys_sb_0/CORERESETP_0/sm0_areset_n_rcosc SF2_MSS_sys_sb_0/CORERESETP_0/sm0_areset_n_rcosc_q1 } ]
set_false_path -from [ get_cells { SF2_MSS_sys_sb_0/CORERESETP_0/MSS_HPMS_READY_int SF2_MSS_sys_sb_0/CORERESETP_0/SDIF*_PERST_N_re } ] -to [ get_cells { SF2_MSS_sys_sb_0/CORERESETP_0/sdif*_areset_n_rcosc* } ]
set_false_path -through [ get_nets { SF2_MSS_sys_sb_0/CORERESETP_0/CONFIG1_DONE SF2_MSS_sys_sb_0/CORERESETP_0/CONFIG2_DONE SF2_MSS_sys_sb_0/CORERESETP_0/SDIF*_PERST_N SF2_MSS_sys_sb_0/CORERESETP_0/SDIF*_PSEL SF2_MSS_sys_sb_0/CORERESETP_0/SDIF*_PWRITE SF2_MSS_sys_sb_0/CORERESETP_0/SDIF*_PRDATA[*] SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_EXT_RESET_OUT SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_RESET_F2M SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_M3_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_MDDR_DDR_AXI_S_CORE_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_FDDR_CORE_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_SDIF*_PHY_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_SDIF*_CORE_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_SDIF0_0_CORE_RESET SF2_MSS_sys_sb_0/CORERESETP_0/SOFT_SDIF0_1_CORE_RESET } ]
