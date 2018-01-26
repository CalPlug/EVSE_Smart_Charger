onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {APB signals}
add wave -noupdate -format Literal /testbench/dut/paddr
add wave -noupdate -format Logic /testbench/dut/pclk
add wave -noupdate -format Logic /testbench/dut/psel
add wave -noupdate -format Logic /testbench/dut/penable
add wave -noupdate -format Logic /testbench/dut/pwrite
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/prdata
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/pwdata
add wave -noupdate -format Logic /testbench/dut/presetn
add wave -noupdate -divider GPIO
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/gpio_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/gpio_oe
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/gpio_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/int
add wave -noupdate -format Logic /testbench/dut/int_or
add wave -noupdate -divider Internal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25886 ns} 0}
configure wave -namecolwidth 441
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {7080 ns}
