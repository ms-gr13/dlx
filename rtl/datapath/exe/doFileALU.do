vsim work.TBALU(TEST) -t 100ps -voptargs=+acc
add wave *
add wave -position insertpoint sim:/tbalu/ALU_DUT/*
run 50 ns
wave zoom full
radix hexadecimal