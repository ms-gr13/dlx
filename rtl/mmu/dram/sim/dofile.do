vsim work.tb_dram(sim) -t 100ps -voptargs=+acc
add wave *
run 50 ns
wave zoom full
radix hexadecimal
