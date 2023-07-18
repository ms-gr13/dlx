vsim work.testFetch(TEST) -t 100ps -voptargs=+acc
add wave *
add wave -position insertpoint  \
sim:/testFetch/fetch/sigVec(0) \
sim:/testFetch/fetch/sigVec(1) 
run 50 ns
wave zoom full
radix hexadecimal

