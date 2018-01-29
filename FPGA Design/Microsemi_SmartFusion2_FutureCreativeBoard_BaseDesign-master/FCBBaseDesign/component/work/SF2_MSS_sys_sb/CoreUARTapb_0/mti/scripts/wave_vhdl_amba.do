onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/failed_apb_bfm
add wave -noupdate -divider APB
add wave -noupdate -format Logic /testbench/pclk
add wave -noupdate -format Logic /testbench/presetn
add wave -noupdate -format Literal /testbench/paddr
add wave -noupdate -format Logic /testbench/psel1
add wave -noupdate -format Logic /testbench/psel2
add wave -noupdate -format Logic /testbench/penable
add wave -noupdate -format Logic /testbench/pwrite
add wave -noupdate -format Literal /testbench/pwdata
add wave -noupdate -format Literal /testbench/prdata
add wave -noupdate -divider {UART1 (TX)}
add wave -noupdate -format Logic /testbench/txrdy1
add wave -noupdate -format Logic /testbench/rxrdy1
add wave -noupdate -format Logic /testbench/tx1
add wave -noupdate -format Logic /testbench/rx1
add wave -noupdate -format Logic /testbench/parity_err1
add wave -noupdate -format Logic /testbench/overflow1
add wave -noupdate -divider UART2(RX)
add wave -noupdate -format Logic /testbench/dut2/framing_err
add wave -noupdate -format Logic /testbench/txrdy2
add wave -noupdate -format Logic /testbench/rxrdy2
add wave -noupdate -format Logic /testbench/tx2
add wave -noupdate -format Logic /testbench/rx2
add wave -noupdate -format Logic /testbench/parity_err2
add wave -noupdate -format Logic /testbench/overflow2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {178056279 ns} 0}
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {46472686 ns}
