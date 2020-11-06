

# run with ~/NAS/primary_a/Projects/fpga/prime/quartus/bin/quartus_stp_tcl
# not quartus_sh


set usb [lindex [get_hardware_names] 0]
set device_name [lindex [get_device_names -hardware_name $usb] 0]

start_insystem_source_probe -device_name $device_name -hardware_name $usb


#set value [read_probe_data -instance_index 0];

set value "11111111111111111111111111111111";

#gets stdin someVar

#$after 30000

set outfile [open "report.out" w]
binary scan [binary format B64 [format "%032s" $value]] W dec
puts $outfile $dec
close $outfile


end_interactive_probe;
