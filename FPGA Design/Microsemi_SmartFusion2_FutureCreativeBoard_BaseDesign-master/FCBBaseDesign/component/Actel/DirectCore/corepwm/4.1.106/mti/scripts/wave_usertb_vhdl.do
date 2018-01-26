
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {tb_user_corepwm}
add wave -noupdate -format Logic -radix hexadecimal -r /*
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 300
configure wave -valuecolwidth 150
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
