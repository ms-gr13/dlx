#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

vcom myTypes.vhd
vcom ffd.vhd
vcom register_generic.vhd
vcom mux.vhd
vcom ZERO_DET.vhd
vcom alu.vhd
vcom execute.vhd

rm -r work 
