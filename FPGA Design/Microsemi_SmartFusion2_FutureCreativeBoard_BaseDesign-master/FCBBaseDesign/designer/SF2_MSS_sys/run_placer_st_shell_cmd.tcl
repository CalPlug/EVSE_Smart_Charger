read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/Users/Mike Klopfer/Documents/GitHub/Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign/FCBBaseDesign/designer/SF2_MSS_sys/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\Users\Mike Klopfer\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\SF2_MSS_sys_layout_combinational_loops.xml}
report -type slack {C:\Users\Mike Klopfer\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\pinslacks.txt}
