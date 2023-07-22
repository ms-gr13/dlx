vsim work.TBDP(TEST) -t 100ps -voptargs=+acc
add wave *
add wave -position insertpoint sim:/tbdp/DATA_DUT/FETCH/*
add wave -position insertpoint sim:/tbdp/DATA_DUT/DECODE/*
add wave -position insertpoint sim:/tbdp/DATA_DUT/EXECUTE/*
add wave -position insertpoint sim:/tbdp/DATA_DUT/MEMORY/*
add wave -position insertpoint sim:/tbdp/DATA_DUT/WB/*
run 50 ns
wave zoom full
radix hexadecimal