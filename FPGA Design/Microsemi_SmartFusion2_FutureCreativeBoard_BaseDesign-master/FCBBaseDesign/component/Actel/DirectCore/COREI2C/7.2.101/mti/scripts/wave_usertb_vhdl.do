onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP LEVEL TESTBENCH}
add wave -noupdate -format Logic -radix hexadecimal /testbench/*
add wave -noupdate -divider {INSTANCE0 MASTER:}
add wave -noupdate -format Logic -radix hexadecimal /testbench/ui2c0/*
add wave -noupdate -divider {INSTANCE1 SLAVE:}
add wave -noupdate -format Logic -radix hexadecimal /testbench/ui2c1/*
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 351
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ns} {250000 ns}
