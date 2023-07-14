#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

vcom fetch/ffd.vhd
vcom fetch/register_generic.vhd
vcom decode/signExtend.vhd
vcom decode/RegisterFile.vhd
vcom fetch/rca.vhd
vcom fetch/fetch.vhd
vcom decode/decode.vhd
vcom datapath.vhd
vsim -do doFile.do