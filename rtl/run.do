vsim work.TB_top(TEST) -t ns -voptargs=+architecture
add wave *
run 500 ns
wave zoom full