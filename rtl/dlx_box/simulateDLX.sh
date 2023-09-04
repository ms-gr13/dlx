#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

#COMPILE DATAPATH
vcom datapath/myTypes.vhd
vcom datapath/fetch/ffd.vhd
vcom datapath/fetch/register_generic.vhd
vcom datapath/decode/ffd.vhd
vcom datapath/decode/register_generic.vhd
vcom datapath/decode/signExtend.vhd
vcom datapath/decode/RegisterFile.vhd
vcom datapath/fetch/rca.vhd
vcom datapath/fetch/fetch.vhd
vcom datapath/decode/decode.vhd
vcom datapath/exe/constants.vhd
vcom datapath/exe/myTypes.vhd
vcom datapath/exe/mux21generic.vhd
vcom datapath/exe/lfsr.vhd
vcom datapath/exe/fa.vhd
vcom datapath/exe/rca.vhd
vcom datapath/exe/csb.vhd
vcom datapath/exe/SumGenerator.vhd
vcom datapath/exe/pg.vhd
vcom datapath/exe/g.vhd
vcom datapath/exe/pg_generator.vhd
vcom datapath/exe/CLA_SPARSE_TREE.vhd
vcom datapath/exe/xor.vhd
vcom datapath/exe/P4_ADDER.vhd
vcom datapath/exe/ctrl_alu.vhd
vcom datapath/exe/logic_and_shift.vhd
vcom datapath/exe/comparator.vhd
vcom datapath/exe/outputSelect.vhd
vcom datapath/exe/alu_top.vhd 
vcom datapath/exe/ZERO_DET.vhd
vcom datapath/exe/ffd.vhd
vcom datapath/exe/register_generic.vhd
vcom datapath/exe/mux21generic.vhd
vcom datapath/exe/execute.vhd
vcom datapath/memory/constants.vhd
vcom datapath/memory/ffd.vhd
vcom datapath/memory/mux21.vhd
vcom datapath/memory/mux21generic.vhd
vcom datapath/memory/register_generic.vhd
vcom datapath/memory/memory.vhd
vcom datapath/wb/constants.vhd
vcom datapath/wb/mux21generic.vhd
vcom datapath/wb/WB.vhd
vcom datapath/datapath.vhd

#COMPILE CONTROL UNIT
vcom cu/myTypes.vhd
vcom cu/CU_HW.vhd

#COMPILE DLX
vcom dlx.vhd
