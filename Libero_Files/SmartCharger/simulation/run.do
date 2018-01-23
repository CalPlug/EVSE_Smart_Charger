quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "D:/Microsemiprj/UC_Irvine/PWM_8ch_16b_Creative"
source "${PROJECT_DIR}/simulation/CM3_compile_bfm.tcl";source "${PROJECT_DIR}/simulation/bfmtovec_compile.tcl";

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v11.7///Designer//lib//modelsim//precompiled/vhdl/SmartFusion2"
if {[file exists COREAPB3_LIB/_info]} {
   echo "INFO: Simulation library COREAPB3_LIB already exists"
} else {
   file delete -force COREAPB3_LIB 
   vlib COREAPB3_LIB
}
vmap COREAPB3_LIB "COREAPB3_LIB"
if {[file exists ../component/Actel/DirectCore/corepwm/4.1.106/mti/lib_vhdl_rtl/COREPWM_LIB/_info]} {
   echo "INFO: Simulation library ../component/Actel/DirectCore/corepwm/4.1.106/mti/lib_vhdl_rtl/COREPWM_LIB already exists"
} else {
   file delete -force ../component/Actel/DirectCore/corepwm/4.1.106/mti/lib_vhdl_rtl/COREPWM_LIB 
   vlib ../component/Actel/DirectCore/corepwm/4.1.106/mti/lib_vhdl_rtl/COREPWM_LIB
}
vmap COREPWM_LIB "../component/Actel/DirectCore/corepwm/4.1.106/mti/lib_vhdl_rtl/COREPWM_LIB"
if {[file exists COREGPIO_LIB/_info]} {
   echo "INFO: Simulation library COREGPIO_LIB already exists"
} else {
   file delete -force COREGPIO_LIB 
   vlib COREGPIO_LIB
}
vmap COREGPIO_LIB "COREGPIO_LIB"
if {[file exists COREUARTAPB_LIB/_info]} {
   echo "INFO: Simulation library COREUARTAPB_LIB already exists"
} else {
   file delete -force COREUARTAPB_LIB 
   vlib COREUARTAPB_LIB
}
vmap COREUARTAPB_LIB "COREUARTAPB_LIB"

vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Actel/DirectCore/CoreResetP/7.1.100/rtl/vhdl/core/coreresetp_pcie_hotreset.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Actel/DirectCore/CoreResetP/7.1.100/rtl/vhdl/core/coreresetp.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CCC_0/SF2_MSS_sys_sb_CCC_0_FCCC.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/FABOSC_0/SF2_MSS_sys_sb_FABOSC_0_OSC.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb_MSS/SF2_MSS_sys_sb_MSS.vhd"
vcom -2008 -explicit  -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vhdl/core/coreapb3_muxptob3.vhd"
vcom -2008 -explicit  -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vhdl/core/coreapb3_iaddr_reg.vhd"
vcom -2008 -explicit  -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vhdl/core/coreapb3.vhd"
vcom -2008 -explicit  -work COREGPIO_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreGPIO/3.1.101/rtl/vhdl/core/coregpio_pkg.vhd"
vcom -2008 -explicit  -work COREGPIO_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreGPIO/3.1.101/rtl/vhdl/core/coregpio.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/pwm_gen.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/reg_if.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/tach_if.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/timebase.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/t_corepwm_pkg.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/corepwm.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/Clock_gen.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/Rx_async.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/Tx_async.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/fifo_256x8_g4.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/coreuart_pkg.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/CoreUART.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/CoreUARTapb.vhd"
vcom -2008 -explicit  -work COREAPB3_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAPB3/4.1.100/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work COREGPIO_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreGPIO/3.1.101/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work COREPWM_LIB "${PROJECT_DIR}/component/Actel/DirectCore/corepwm/4.3.101/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work COREUARTAPB_LIB "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/CoreUARTapb_0/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys_sb/SF2_MSS_sys_sb.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys/SF2_MSS_sys.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1/RESET_GEN.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SF2_MSS_sys_tb/SF2_MSS_sys_tb.vhd"

vsim -L SmartFusion2 -L presynth -L COREAPB3_LIB -L COREPWM_LIB -L COREGPIO_LIB -L COREUARTAPB_LIB  -t 1ps presynth.SF2_MSS_sys_tb
do "${PROJECT_DIR}/simulation/wave.do"
run 1000 ns
