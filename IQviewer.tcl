#See https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii53021.pdf
#and https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii52003.pdf

# run with ~/NAS/primary_a/Projects/fpga/prime/quartus/bin/quartus_stp_tcl
# not quartus_sh

proc pause {{message "Hit Enter to continue ==> "}} {
    puts -nonewline $message
    flush stdout
    gets stdin
}

proc hex_to_signed {value} {
  set sign [expr {($value & 0b10000000000000000000000000000000)}]
  set mag  [expr {($value & 0b01111111111111111111111111111111)}]
  if {$sign==0} {
    set exp 0
  } else {
    set exp [expr -2**31]
  }
  set value [expr {$exp + $mag}]
  return $value
}
#thanks Quantum0xE7 on SO!




set usb [lindex [get_hardware_names] 0]
set device_name [lindex [get_device_names -hardware_name $usb] 0]

start_insystem_source_probe -device_name $device_name -hardware_name $usb

set output_filename "../eppenwolf/runs/phage_experiment_6/fluorescence_slide_1.csv"

array set waveform {}


while {1} {

    set previous_count_binary [read_probe_data -instance_index 0];
    set I_count_binary [read_probe_data -instance_index 0];

    while {$I_count_binary == $previous_count_binary} {
        puts "Integrating..."
        after 1000;
        set I_count_binary [read_probe_data -instance_index 0];
        set Q_count_binary [read_probe_data -instance_index 1];

    }

    binary scan [binary format B64 [format "%064s" $I_count_binary]] W I_count_binary_scanned
    binary scan [binary format B64 [format "%064s" $Q_count_binary]] W Q_count_binary_scanned

    set I_count [hex_to_signed $I_count_binary_scanned];
    set Q_count [hex_to_signed $Q_count_binary_scanned];

    puts $I_count;
    puts $Q_count;

    puts [expr { sqrt((double($I_count)*double($I_count)) + (double($Q_count)*double($Q_count))) } ];
    puts [expr {  atan( $Q_count / double($I_count)) }];

    #set addc_bin [read_probe_data -instance_index 1];
    #binary scan [binary format B64 [format "%064s" $addc_bin]] W addc





}


#set value "11111111111111111111111111111111";




#end_interactive_probe;
