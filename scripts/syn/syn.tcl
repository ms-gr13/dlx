set blockName "dlx_top"


set active_design $blockName

set dirname "./syn/${active_design}"
if {![file exists $dirname]} {
	file mkdir $dirname
}
set dirname "./saved/${active_design}/synthesis"
if {![file exists $dirname]} {
	file mkdir $dirname
}

set libDir "./saved/${active_design}/synthesis/synlib"
file mkdir $libDir
define_design_lib $active_design -path $libDir

# ANALYZE HDL SOURCES
set HdlFileList [glob -dir "./rtl/${blockName}/verilog" "*.v*"]
foreach hdlFile $HdlFileList {
	if {[file extension $hdlFile]==".v"} {
		analyze -format verilog  -library $blockName $hdlFile
   } elseif {[file extension $hdlFile]==".vhd"} {
		analyze -format vhdl -library $blockName $hdlFile
    }
}
# Analyze the VHDL files 'constants.vhd' and 'registerfileWindowing.vhd' in the WORK library
analyze -library WORK -format vhdl {constants.vhd registerfileWindowing.vhd}

# Elaborate the REGISTER_FILE_WINDOWING entity using the BEHAVIORAL architecture in the WORK library
elaborate REGISTER_FILE_WINDOWING -architecture BEHAVIORAL -library WORK

# Compile the design using exact mapping
compile -exact_map

# Generate a timing report without constraints
report_timing > timingReport.rpt

# Create a clock named 'CLK' with a period of 2ns
create_clock -name "CLK" -period 2.5 CLK
# Report the properties of the clock just created

report_clock

# Compile the design again after clock creation
compile

# Generate a timing report with clock constraints
report_timing > timingReportWithclock.rpt

# Write the post-synthesis VHDL netlist to the file 'PostSynthRegFileWindowing.vhdl'
write -hierarchy -format vhdl -output PostSynthRegFileWindowing.vhdl
