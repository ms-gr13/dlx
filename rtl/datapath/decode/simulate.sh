#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

vcom ffd.vhd
vcom register_generic.vhd
vcom signExtend.vhd
vcom RegisterFile.vhd
vcom rca.vhd
vcom decode.vhd
vcom fetch.vhd
vsim -do doFile.do
