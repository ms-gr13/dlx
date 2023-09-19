###################################################################

# Created by write_sdc on Mon Sep 18 20:38:00 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
create_clock [get_ports Clk_port]  -period 2.5  -waveform {0 1.25}
