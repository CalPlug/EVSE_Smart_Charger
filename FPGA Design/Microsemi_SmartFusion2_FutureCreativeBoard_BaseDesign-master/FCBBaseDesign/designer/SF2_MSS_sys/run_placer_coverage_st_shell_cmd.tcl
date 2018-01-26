read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/Users/calplug/Documents/GitHub/Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign/FCBBaseDesign/designer/SF2_MSS_sys/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\Users\calplug\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\SF2_MSS_sys_place_and_route_constraint_coverage.xml}]
set reportfile {C:\Users\calplug\Documents\GitHub\Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign\FCBBaseDesign\designer\SF2_MSS_sys\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
