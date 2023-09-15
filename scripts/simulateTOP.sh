#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

#COMPILE DATAPATH
vcom ../rtl/basic_elements/*
vcom ../rtl/dlx_box/datapath/fetch.vhd
vcom ../rtl/dlx_box/datapath/decode/signExtend.vhd
vcom ../rtl/dlx_box/datapath/decode/RegisterFile.vhd
vcom ../rtl/dlx_box/datapath/decode/decode.vhd
vcom ../rtl/dlx_box/datapath/exe/lfsr.vhd
vcom ../rtl/dlx_box/datapath/exe/fa.vhd
vcom ../rtl/dlx_box/datapath/exe/rca.vhd
vcom ../rtl/dlx_box/datapath/exe/csb.vhd
vcom ../rtl/dlx_box/datapath/exe/SumGenerator.vhd
vcom ../rtl/dlx_box/datapath/exe/pg.vhd
vcom ../rtl/dlx_box/datapath/exe/g.vhd
vcom ../rtl/dlx_box/datapath/exe/pg_generator.vhd
vcom ../rtl/dlx_box/datapath/exe/CLA_SPARSE_TREE.vhd
vcom ../rtl/dlx_box/datapath/exe/xor.vhd
vcom ../rtl/dlx_box/datapath/exe/P4_ADDER.vhd
vcom ../rtl/dlx_box/datapath/exe/ctrl_alu.vhd
vcom ../rtl/dlx_box/datapath/exe/logic_and_shift.vhd
vcom ../rtl/dlx_box/datapath/exe/comparator.vhd
vcom ../rtl/dlx_box/datapath/exe/outputSelect.vhd
vcom ../rtl/dlx_box/datapath/exe/alu_top.vhd 
vcom ../rtl/dlx_box/datapath/exe/ZERO_DET.vhd
vcom ../rtl/dlx_box/datapath/exe/xnor.vhd
vcom ../rtl/dlx_box/datapath/exe/execute.vhd
vcom ../rtl/dlx_box/datapath/memory.vhd
vcom ../rtl/dlx_box/datapath/WB.vhd
vcom ../rtl/dlx_box/datapath/datapath.vhd

#COMPILE CONTROL UNIT
vcom ../rtl/dlx_box/cu/CU_HW.vhd

#COMPILE DLX
vcom ../rtl/dlx_box/dlx.vhd

vcom ../rtl/mmu/dram/src/dram.vhd
vcom ../rtl/mmu/iram/iram.vhd
vcom ../rtl/topModule.vhd

#COMPILE TESTBENCH
vcom ../tb/TB_top_module.vhd

vsim -do run.do 

