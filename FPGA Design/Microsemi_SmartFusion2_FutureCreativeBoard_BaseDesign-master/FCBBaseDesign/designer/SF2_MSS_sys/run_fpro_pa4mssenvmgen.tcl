set_device \
    -fam SmartFusion2 \
    -die PA4M2500_N \
    -pkg vf256
set_input_cfg \
	-path {C:/Users/calplug/Documents/GitHub/Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign/FCBBaseDesign/component/work/SF2_MSS_sys_sb_MSS/ENVM.cfg}
set_output_efc \
    -path {C:\Users\calplug\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\SF2_MSS_sys.efc}
set_proj_dir \
    -path {C:\Users\calplug\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign}
gen_prg -use_init false
