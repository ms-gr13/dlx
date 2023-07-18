vsim work.TBSUM_GENERATOR(test) -t 100ps -voptargs=+acc
add wave *
run 50 ns
wave zoom full
radix hexadecimal
