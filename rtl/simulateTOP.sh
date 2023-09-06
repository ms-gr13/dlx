#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

#COMPILE DATAPATH
vcom dlx_box/datapath/myTypes.vhd
vcom dlx_box/datapath/fetch/ffd.vhd
vcom dlx_box/datapath/fetch/register_generic.vhd
vcom dlx_box/datapath/decode/ffd.vhd
vcom dlx_box/datapath/decode/register_generic.vhd
vcom dlx_box/datapath/decode/signExtend.vhd
vcom dlx_box/datapath/decode/RegisterFile.vhd
vcom dlx_box/datapath/fetch/rca.vhd
vcom dlx_box/datapath/fetch/fetch.vhd
vcom dlx_box/datapath/decode/decode.vhd
vcom dlx_box/datapath/exe/constants.vhd
vcom dlx_box/datapath/exe/myTypes.vhd
vcom dlx_box/datapath/exe/mux21generic.vhd
vcom dlx_box/datapath/exe/lfsr.vhd
vcom dlx_box/datapath/exe/fa.vhd
vcom dlx_box/datapath/exe/rca.vhd
vcom dlx_box/datapath/exe/csb.vhd
vcom dlx_box/datapath/exe/SumGenerator.vhd
vcom dlx_box/datapath/exe/pg.vhd
vcom dlx_box/datapath/exe/g.vhd
vcom dlx_box/datapath/exe/pg_generator.vhd
vcom dlx_box/datapath/exe/CLA_SPARSE_TREE.vhd
vcom dlx_box/datapath/exe/xor.vhd
vcom dlx_box/datapath/exe/P4_ADDER.vhd
vcom dlx_box/datapath/exe/ctrl_alu.vhd
vcom dlx_box/datapath/exe/logic_and_shift.vhd
vcom dlx_box/datapath/exe/comparator.vhd
vcom dlx_box/datapath/exe/outputSelect.vhd
vcom dlx_box/datapath/exe/alu_top.vhd 
vcom dlx_box/datapath/exe/ZERO_DET.vhd
vcom dlx_box/datapath/exe/ffd.vhd
vcom dlx_box/datapath/exe/register_generic.vhd
vcom dlx_box/datapath/exe/mux21generic.vhd
vcom dlx_box/datapath/exe/execute.vhd
vcom dlx_box/datapath/memory/constants.vhd
vcom dlx_box/datapath/memory/ffd.vhd
vcom dlx_box/datapath/memory/mux21.vhd
vcom dlx_box/datapath/memory/mux21generic.vhd
vcom dlx_box/datapath/memory/register_generic.vhd
vcom dlx_box/datapath/memory/memory.vhd
vcom dlx_box/datapath/wb/constants.vhd
vcom dlx_box/datapath/wb/mux21generic.vhd
vcom dlx_box/datapath/wb/WB.vhd
vcom dlx_box/datapath/datapath.vhd

#COMPILE CONTROL UNIT
vcom dlx_box/cu/CU_HW.vhd

#COMPILE DLX
vcom dlx_box/dlx.vhd

vcom mmu/dram/src/dram.vhd
vcom mmu/iram/iram.vhd
vcom topModule.vhd

#COMPILE TESTBENCH
vcom TB_top_module.vhd

vsim -do run.do 

