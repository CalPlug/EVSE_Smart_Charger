new_project \
         -name {SF2_MSS_sys} \
         -location {D:\Microsemiprj\UC_Irvine\PWM_6ch_16b_Creative\designer\SF2_MSS_sys\SF2_MSS_sys_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S025} \
         -name {M2S025}
enable_device \
         -name {M2S025} \
         -enable {TRUE}
save_project
close_project
