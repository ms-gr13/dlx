#!/bin/sh

# Exit immediately if any command fails
set -e

vcom -F ./compile.f

vsim -do dofile.do

