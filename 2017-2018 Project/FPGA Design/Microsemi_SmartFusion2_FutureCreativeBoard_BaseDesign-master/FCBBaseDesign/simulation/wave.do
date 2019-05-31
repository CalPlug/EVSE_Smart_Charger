onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sf2_mss_sys_tb/RESET_GEN_0_RESET
add wave -noupdate -expand /sf2_mss_sys_tb/PWM
add wave -noupdate -divider {CCC signals}
add wave -noupdate -expand -group {CCC signals} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/CCC_0/GL0
add wave -noupdate -expand -group {CCC signals} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/CCC_0/GL1
add wave -noupdate -expand -group {CCC signals} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/CCC_0/LOCK
add wave -noupdate -expand -group {CCC signals} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/CCC_0/RCOSC_25_50MHZ
add wave -noupdate -divider {FIC_0 Interface}
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PADDR
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PADDR_net_0
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PENABLE
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PENABLE_net_0
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PSELx
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PWDATA
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_MASTER_PWRITE
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PADDR
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PENABLE
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PRDATA
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PREADY
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PSEL
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PSLVERR
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PWDATA
add wave -noupdate -group {FIC_0 Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/SF2_MSS_sys_sb_MSS_0/FIC_0_APB_M_PWRITE
add wave -noupdate -divider {CorePWM APB interface}
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PRESETN
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PCLK
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PADDR
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PSEL
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PENABLE
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PWRITE
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PWDATA
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PRDATA
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PREADY
add wave -noupdate -expand -group {CorePWM ABP Interface} /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PSLVERR
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PWM_CLK
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/PWM
add wave -noupdate -divider {CorePWM internal signals}
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/period_cnt
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/period_cnt_int
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/period_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/prescale_cnt
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/prescale_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/PCLK
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/PRESETN
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/SYNC_RESET
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/G0b/timebase_inst/sresetn
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/period_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/prescale_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/pwm_clk_int
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/pwm_enable_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/pwm_posedge_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/pwm_negedge_reg
add wave -noupdate /sf2_mss_sys_tb/SF2_MSS_sys_0/SF2_MSS_sys_sb_0/corepwm_0_0/sync_pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {238167364 ps} 0} {{Cursor 2} {17034380 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 460
configure wave -valuecolwidth 53
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {25424863522 ps}
