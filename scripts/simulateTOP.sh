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
#vcom ../rtl/dlx_box/datapath/exe/fa.vhd
#vcom ../rtl/dlx_box/datapath/exe/rca.vhd
vcom ../rtl/dlx_box/datapath/exe/csb.vhd
vcom ../rtl/dlx_box/datapath/exe/sumGenerator.vhd
vcom ../rtl/dlx_box/datapath/exe/pg.vhd
vcom ../rtl/dlx_box/datapath/exe/g.vhd
vcom ../rtl/dlx_box/datapath/exe/pg_generator.vhd
vcom ../rtl/dlx_box/datapath/exe/cla_sparse_tree.vhd
vcom ../rtl/dlx_box/datapath/exe/xor.vhd
vcom ../rtl/dlx_box/datapath/exe/p4_adder.vhd
vcom ../rtl/dlx_box/datapath/exe/ctrl_alu.vhd
vcom ../rtl/dlx_box/datapath/exe/logic_and_shift.vhd
vcom ../rtl/dlx_box/datapath/exe/comparator.vhd
vcom ../rtl/dlx_box/datapath/exe/outputSelect.vhd
vcom ../rtl/dlx_box/datapath/exe/alu.vhd 
vcom ../rtl/dlx_box/datapath/exe/zero_det.vhd
vcom ../rtl/dlx_box/datapath/exe/xnor.vhd
vcom ../rtl/dlx_box/datapath/exe/executionUnit.vhd
vcom ../rtl/dlx_box/datapath/memory.vhd
vcom ../rtl/dlx_box/datapath/WB.vhd
vcom ../rtl/dlx_box/datapath/datapath.vhd

#COMPILE CONTROL UNIT
vcom ../rtl/dlx_box/cu/CU_HW.vhd

#COMPILE DLX
vcom ../rtl/dlx_box/dlx.vhd

vcom ../rtl/mmu/dram.vhd
vcom ../rtl/mmu/iram.vhd
vcom ../rtl/topModule.vhd

#COMPILE TESTBENCH
vcom ../tb/TB_top_module.vhd

vsim -do run.do 

