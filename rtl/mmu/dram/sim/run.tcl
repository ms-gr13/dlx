#!/bin/tclsh
#vdel -all

#vlib work

#vcom -F compile.f
source ./simulate.sh
# Simulate the design
#vsim -c -do {run -all; quit} tb_dram

# Open the transcript file to write the report messages
set transcript_file [open "sim_report.txt" "w"]

# Define a procedure to capture messages and write them to the file
proc capture_message {message level} {
    puts $transcript_file "$level: $message"
}

# Redirect report messages to the capture_message procedure
add_message_observer -id report_capture_message capture_message

# Run the simulation
run -all

# Close the transcript file
close $transcript_file

# Exit ModelSim
quit -f