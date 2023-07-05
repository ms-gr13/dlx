#!/usr/bin/env sh

# Exit immediately if any command fails
set -e

vcom ffd.vhd
vcom register_generic.vhd
vcom rca.vhd
vcom fetch.vhd
vcom testbenchFetch.vhd
vsim -do doFile.do
