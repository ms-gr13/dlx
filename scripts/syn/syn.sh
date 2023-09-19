#!/bin/sh

folder_path="./syn"

# Check if the folder exists
if [ ! -d "$folder_path" ]; then
    # Folder doesn't exist, so create it
    mkdir -p "$folder_path"
fi


find ./rtl/dlx_box/ -type f -name *.vhd -exec cp {} ./syn/ \;

cp ./scripts/syn/.synopsys_dc.setup ./scripts/syn/syn.tcl ./syn;

cd syn;

dc_shell-xg-t -f ./syn.tcl;


