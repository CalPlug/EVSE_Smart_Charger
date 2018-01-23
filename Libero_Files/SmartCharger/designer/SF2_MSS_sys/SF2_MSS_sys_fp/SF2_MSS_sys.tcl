open_project -project {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys_fp\SF2_MSS_sys.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S025} \
    -fpga {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.map} \
    -header {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.hdr} \
    -envm {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.efc}  \
    -spm {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.spm} \
    -dca {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.dca}
set_programming_file -name {M2S025} -no_file
save_project
close_project
