set_device \
    -fam SmartFusion2 \
    -die PA4M2500_N \
    -pkg vf256
set_input_cfg \
	-path {C:/Users/CalPlug/Desktop/Servo-arm2/component/work/SF2_MSS_sys_sb_MSS/ENVM.cfg}
set_output_efc \
    -path {C:\Users\CalPlug\Desktop\Servo-arm2\designer\SF2_MSS_sys\SF2_MSS_sys.efc}
set_proj_dir \
    -path {C:\Users\CalPlug\Desktop\Servo-arm2}
gen_prg -use_init false
