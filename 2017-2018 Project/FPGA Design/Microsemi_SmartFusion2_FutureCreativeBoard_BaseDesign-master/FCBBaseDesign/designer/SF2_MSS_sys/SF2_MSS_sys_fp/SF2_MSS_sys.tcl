open_project -project {C:\Users\Mike Klopfer\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\SF2_MSS_sys_fp\SF2_MSS_sys.pro}
set_programming_file -name {M2S025} -file {C:\Users\Mike Klopfer\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\SF2_MSS_sys.ipd}
enable_device -name {M2S025} -enable 1
enable_procedure \
		 -name {M2S025} \
		 -action {PROGRAM} \
		 -procedure {DO_VERIFY} \
		 -enable 1
set_programming_action -action {PROGRAM} -name {M2S025} 
run_selected_actions
set_programming_file -name {M2S025} -no_file
save_project
close_project
