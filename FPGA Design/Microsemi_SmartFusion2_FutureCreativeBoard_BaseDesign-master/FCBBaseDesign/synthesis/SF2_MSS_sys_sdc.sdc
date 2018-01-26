# Written by Synplify Pro version map201609actrcp1, Build 005R. Synopsys Run ID: sid1516930629 
# Top Level Design Parameters 

# Clocks 
create_clock -period 20.000 -waveform {0.000 10.000} -name {SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ:CLKOUT}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {SF2_MSS_sys|SPI_0_CLK_F2M} [get_ports {SPI_0_CLK_F2M}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {spi_chanctrl|un1_resetn_rx_inferred_clock} [get_pins {SF2_MSS_sys_sb_0/CORESPI_0/USPI/UCC/un1_resetn_rx:Y}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {SF2_MSS_sys_sb_0/CCC_0/GL0} -multiply_by {7} -divide_by {5} -source [get_pins {SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ:CLKOUT}]  [get_pins {SF2_MSS_sys_sb_0/CCC_0/CCC_INST:GL0}] 
create_generated_clock -name {SF2_MSS_sys_sb_0/CCC_0/GL1} -multiply_by {7} -divide_by {350} -source [get_pins {SF2_MSS_sys_sb_0/FABOSC_0/I_RCOSC_25_50MHZ:CLKOUT}]  [get_pins {SF2_MSS_sys_sb_0/CCC_0/CCC_INST:GL1}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {SF2_MSS_sys|SPI_0_CLK_F2M}]
set_clock_groups -asynchronous -group [get_clocks {spi_chanctrl|un1_resetn_rx_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -through [get_nets { SF2_MSS_sys_sb_0.CORERESETP_0.ddr_settled SF2_MSS_sys_sb_0.CORERESETP_0.count_ddr_enable SF2_MSS_sys_sb_0.CORERESETP_0.release_sdif*_core SF2_MSS_sys_sb_0.CORERESETP_0.count_sdif*_enable }]
# set_false_path -from [get_cells { SF2_MSS_sys_sb_0.CORERESETP_0.MSS_HPMS_READY_int }] -to [get_cells { SF2_MSS_sys_sb_0.CORERESETP_0.sm0_areset_n_rcosc SF2_MSS_sys_sb_0.CORERESETP_0.sm0_areset_n_rcosc_q1 }]
# set_false_path -from [get_cells { SF2_MSS_sys_sb_0.CORERESETP_0.MSS_HPMS_READY_int SF2_MSS_sys_sb_0.CORERESETP_0.SDIF*_PERST_N_re }] -to [get_cells { SF2_MSS_sys_sb_0.CORERESETP_0.sdif*_areset_n_rcosc* }]
# set_false_path -through [get_nets { SF2_MSS_sys_sb_0.CORERESETP_0.CONFIG1_DONE SF2_MSS_sys_sb_0.CORERESETP_0.CONFIG2_DONE SF2_MSS_sys_sb_0.CORERESETP_0.SDIF*_PERST_N SF2_MSS_sys_sb_0.CORERESETP_0.SDIF*_PSEL SF2_MSS_sys_sb_0.CORERESETP_0.SDIF*_PWRITE SF2_MSS_sys_sb_0.CORERESETP_0.SDIF*_PRDATA[*] SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_EXT_RESET_OUT SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_RESET_F2M SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_M3_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_MDDR_DDR_AXI_S_CORE_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_FDDR_CORE_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_SDIF*_PHY_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_SDIF*_CORE_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_SDIF0_0_CORE_RESET SF2_MSS_sys_sb_0.CORERESETP_0.SOFT_SDIF0_1_CORE_RESET }]

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

