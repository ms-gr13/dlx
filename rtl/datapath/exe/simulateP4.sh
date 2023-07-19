#!/bin/sh

# Exit immediately if any command fails
set -e


vcom constants.vhd
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
vcom tb_P4ADDER.vhd
vsim -do dofileP4.do
