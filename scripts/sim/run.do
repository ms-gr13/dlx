vsim work.TB_top(TEST) -t ns -voptargs=+architecture
add wave *
add wave -position insertpoint sim:/tb_top/DLX_TOP/DLX_INST/CONTROL_UNIT/*

add wave -divider -height 30 "INTERIOR OF THE REGISTER FILE: "
add wave -position insertpoint sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/*
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(0) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(1) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(2) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(3) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(4) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(5) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(6) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(7) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(8) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(9) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(10) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(11) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(12) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(13) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(14) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(15) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(16) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(17) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(18) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(19) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(20) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(21) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(22) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(23) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(24) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(25) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(26) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(27) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(28) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(29) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(30) \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF/REGISTERS(31)

add wave -divider -height 30 "FETCH STAGE SIGNALS"
add wave -position insertpoint sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/FETCH/*


add wave -divider -height 30 "DECODE STAGE SIGNALS"
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/IR_OUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/A_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/B_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/Imm_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/signExtOut \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF_out1 \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RF_out2 \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RS1 \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/RS2 \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/WR_ADDR \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/datainRF \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/IR_IN2s \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/IR_OUT2s \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/DECODE/WR_ADDR 


add wave -divider -height 30 "EXECUTE STAGE SIGNALS"
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/NPC_OUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/A_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/B_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/Imm_out \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/ALUREG_OUTPUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/B_outregs \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/XNOR_OUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/ZERO_DEC_OUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/COND_OUT \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/IR_IN3s \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/IR_OUT3s
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/EXECUTE/alu1/FUNC_SIGNAL


add wave -divider -height 30 "MEMORY STAGE SIGNALS"
add wave -position insertpoint  \sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/MEMORY/*


add wave -divider -height 30 "WRITE BACK STAGE SIGNALS"
add wave -position insertpoint  \sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/WB/*

add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATA_PATH/RF_WE

add wave -divider -height 30 "DLX SIGNALS: "
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/DLX_INST/DATAread_DRAM_port \
sim:/tb_top/DLX_TOP/DLX_INST/ADDRESS_DRAM_port \
sim:/tb_top/DLX_TOP/DLX_INST/DATAwrite_DRAM_port \
sim:/tb_top/DLX_TOP/DLX_INST/DRAM_WE_signal

add wave -divider -height 30 "INTERIOR OF DATA MEMORY: "
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/D_DRAM/data_memory

add wave -divider -height 30 "INTERIOR OF INSTRUCTION MEMORY: "
add wave -position insertpoint  \
sim:/tb_top/DLX_TOP/I_RAM/IRAM_mem


run 500 ns
wave zoom full