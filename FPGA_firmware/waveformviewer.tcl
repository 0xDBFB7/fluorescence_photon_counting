#See https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii53021.pdf
#and https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii52003.pdf

# run with ~/NAS/primary_a/Projects/fpga/prime/quartus/bin/quartus_stp_tcl
# not quartus_sh

proc no-op {args} {}
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

set output_filename "../eppenwolf/runs/phage_experiment_7/fluorescence_slide_1.csv"


set num_waveform_samples 38



while {1} {

    set waveform [list ]

    set binary_index [read_probe_data -instance_index 5];
    set binary_waveform_count [read_probe_data -instance_index 4];
    binary scan [binary format B64 [format "%064s" $binary_index]] W waveform_index
    binary scan [binary format B64 [format "%064s" $binary_waveform_count]] W waveform_count

    while {$waveform_index >= $num_waveform_samples-1} {
        set binary_index [read_probe_data -instance_index 5];
        binary scan [binary format B64 [format "%064s" $binary_index]] W waveform_index
    }
    set prev_index 0;
    while {$waveform_index < $num_waveform_samples-1} {
        # unsigned

        if { $waveform_index != $prev_index } {
            set prev_index $waveform_index;
            lappend waveform $waveform_count;
            puts $waveform_index;
        }

        #lset waveform $waveform_index $waveform_count */
        set binary_index [read_probe_data -instance_index 5];
        after 1;
        set binary_waveform_count [read_probe_data -instance_index 4];
        binary scan [binary format B64 [format "%064s" $binary_index]] W waveform_index
        binary scan [binary format B64 [format "%064s" $binary_waveform_count]] W waveform_count
    }

    puts $waveform;
}


#set value "11111111111111111111111111111111";
while {1} {
    set binary_index [read_probe_data -instance_index 5];
    set binary_waveform_count [read_probe_data -instance_index 4];
    binary scan [binary format B64 [format "%064s" $binary_index]] W waveform_index
    binary scan [binary format B64 [format "%064s" $binary_waveform_count]] W waveform_count
    puts $waveform_index;
    puts $waveform_count;
}




#end_interactive_probe;
