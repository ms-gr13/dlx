#!/bin/sh

# Exit immediately if any command fails
set -e


vcom constants.vhd
vcom myTypes.vhd
vcom mux21generic.vhd
vcom lfsr.vhd
vcom fa.vhd
vcom rca.vhd
vcom csb.vhd
vcom SumGenerator.vhd
vcom pg.vhd
vcom g.vhd
vcom pg_generator.vhd
vcom CLA_SPARSE_TREE.vhd
vcom xor.vhd
vcom P4_ADDER.vhd
vcom ctrl_alu.vhd
vcom logic_and_shift.vhd
vcom comparator.vhd
vcom outputSelect.vhd
vcom alu_top.vhd
vcom tb_ALU.vhd
vsim -do doFileALU.do

