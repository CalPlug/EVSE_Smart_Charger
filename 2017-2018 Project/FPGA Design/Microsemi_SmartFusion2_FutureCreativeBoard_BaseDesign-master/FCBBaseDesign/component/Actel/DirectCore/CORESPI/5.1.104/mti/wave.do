onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {SPI Master}
add wave -noupdate -divider APB
add wave -noupdate -format Literal /testbench/USPIM/PADDR
add wave -noupdate -format Logic /testbench/USPIM/PCLK
add wave -noupdate -format Logic /testbench/USPIM/PENABLE
add wave -noupdate -format Literal /testbench/USPIM/PRDATA
add wave -noupdate -format Logic /testbench/USPIM/PREADY
add wave -noupdate -format Logic /testbench/USPIM/PRESETN
add wave -noupdate -format Logic /testbench/USPIM/PSEL
add wave -noupdate -format Logic /testbench/USPIM/PSLVERR
add wave -noupdate -format Literal /testbench/USPIM/PWDATA
add wave -noupdate -format Logic /testbench/USPIM/PWRITE
add wave -noupdate -divider Serial
add wave -noupdate -format Logic /testbench/USPIM/SPICLKI
add wave -noupdate -format Logic /testbench/USPIM/SPIINT
add wave -noupdate -format Logic /testbench/USPIM/SPIMODE
add wave -noupdate -format Logic /testbench/USPIM/SPIOEN
add wave -noupdate -format Logic /testbench/USPIM/SPIRXAVAIL
add wave -noupdate -format Logic /testbench/USPIM/SPISCLKO
add wave -noupdate -format Logic /testbench/USPIM/SPISDI
add wave -noupdate -format Logic /testbench/USPIM/SPISDO
add wave -noupdate -format Literal /testbench/USPIM/SPISS
add wave -noupdate -format Logic /testbench/USPIM/SPISSI
add wave -noupdate -format Logic /testbench/USPIM/SPITXRFM
add wave -noupdate -divider {SPI Slave}
add wave -noupdate -divider APB
add wave -noupdate -radix hexadecimal -format Literal /testbench/USPIS/PADDR
add wave -noupdate -format Logic /testbench/USPIS/PCLK
add wave -noupdate -format Logic /testbench/USPIS/PENABLE
add wave -noupdate -format Literal /testbench/USPIS/PRDATA
add wave -noupdate -format Logic /testbench/USPIS/PREADY
add wave -noupdate -format Logic /testbench/USPIS/PRESETN
add wave -noupdate -format Logic /testbench/USPIS/PSEL
add wave -noupdate -format Logic /testbench/USPIS/PSLVERR
add wave -noupdate -format Literal /testbench/USPIS/PWDATA
add wave -noupdate -format Logic /testbench/USPIS/PWRITE
add wave -noupdate -divider Serial
add wave -noupdate -format Logic /testbench/USPIS/SPICLKI
add wave -noupdate -format Logic /testbench/USPIS/SPIINT
add wave -noupdate -format Logic /testbench/USPIS/SPIMODE
add wave -noupdate -format Logic /testbench/USPIS/SPIOEN
add wave -noupdate -format Logic /testbench/USPIS/SPIRXAVAIL
add wave -noupdate -format Logic /testbench/USPIS/SPISCLKO
add wave -noupdate -format Logic /testbench/USPIS/SPISDI
add wave -noupdate -format Logic /testbench/USPIS/SPISDO
add wave -noupdate -format Literal /testbench/USPIS/SPISS
add wave -noupdate -format Logic /testbench/USPIS/SPISSI
add wave -noupdate -format Logic /testbench/USPIS/SPITXRFM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44450164832 ps} 0} {{Cursor 11} {8169427 ps} 0} {{Cursor 12} {44640351578 ps} 0} {{Cursor 4} {44639015000 ps} 0}
configure wave -namecolwidth 408
configure wave -valuecolwidth 85
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
WaveRestoreZoom {0 ps} {23535750 ps}
