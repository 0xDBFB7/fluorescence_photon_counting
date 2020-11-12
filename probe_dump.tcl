#See https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii53021.pdf
#and https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/qts/qts_qii52003.pdf

# run with ~/NAS/primary_a/Projects/fpga/prime/quartus/bin/quartus_stp_tcl  -t probe_dump.tcl
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

set output_filename "../eppenwolf/runs/phage_experiment_7/fluorescence_slide_0.csv"


set cuvette 0

while {$cuvette < 8} {
    pause "move to cuvette $cuvette and hit enter";

    set previous_count_binary [read_probe_data -instance_index 0];
    set count_binary [read_probe_data -instance_index 0];

    while {$count_binary == $previous_count_binary} {
        #wait for a fresh integration time
        after 1000;
        set count_binary [read_probe_data -instance_index 0];
    }

    set iter 0;
    while {$iter < 5} {


        set previous_count_binary [read_probe_data -instance_index 0];
        while {$count_binary == $previous_count_binary} {
            puts "Integrating..."
            after 1000;
            set count_binary [read_probe_data -instance_index 0];
        }

        set I_count_binary [read_probe_data -instance_index 0];
        set Q_count_binary [read_probe_data -instance_index 1];
        set ipcn_binary [read_probe_data -instance_index 2];
        set qacn_binary [read_probe_data -instance_index 3];

        binary scan [binary format B64 [format "%064s" $I_count_binary]] W I_count_binary_scanned
        binary scan [binary format B64 [format "%064s" $Q_count_binary]] W Q_count_binary_scanned
        binary scan [binary format B64 [format "%064s" $ipcn]] W ipcn_binary_scanned
        binary scan [binary format B64 [format "%064s" $qacn]] W qacn_binary_scanned

        set I_count [hex_to_signed $I_count_binary_scanned];
        set Q_count [hex_to_signed $Q_count_binary_scanned];
        set ipcn [hex_to_signed $ipcn_binary_scanned];
        set qacn [hex_to_signed $qacn_binary_scanned];

        set mag [expr { sqrt((double($I_count)*double($I_count)) + (double($Q_count)*double($Q_count))) } ];
        set phase [expr {  atan( $Q_count / double($I_count)) }];


        set outfile [open $output_filename a]

        puts -nonewline $outfile $cuvette;
        puts -nonewline $outfile ",";
        puts -nonewline $outfile $I_count;
        puts -nonewline $outfile ",";
        puts -nonewline $outfile $Q_count;
        puts -nonewline $outfile ",";
        puts -nonewline $outfile $ipcn;
        puts -nonewline $outfile ",";
        puts -nonewline $outfile $qacn;
        puts -nonewline $outfile "\n";

        close $outfile; # no buffering

        puts $I_count;

        incr iter;

    }


    incr cuvette;
}


#set value "11111111111111111111111111111111";




#end_interactive_probe;
