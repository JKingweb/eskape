proc dumpLog {db queries out {outtype ""} {format text} {tz :localtime} {tformat "%Y-%m-%d %T"}} {
	lassign [prepareChannel $out $outtype] out dir close
	set qcount [llength $queries]
	if {$qcount > 1} {
		if {!$dir} {
			set chan $out
			set head [list]
			foreach q $queries {
				lappend head [lindex $q 1]
			}
			puts $chan [join $head "\n"]
			puts $chan "\f"
		}
	} elseif {$dir} {
		lassign [prepareChannel [file join $out [string map {":" "-"}  "[lindex [lindex $queries 0] 1].txt"]] file] chan dir close
	} else {
		set chan $out
	}
	for {set a 0} {$a < $qcount} {incr a} {
		if {$dir} {
			try {lassign [prepareChannel [file join $out [string map {":" "-"} "[lindex [lindex $queries $a] 1].txt"]] multifile] chan dir close} on error {} {
				err -4
				continue
			}
		}
		$db eval "[lindex [lindex $queries $a] 0]" "" {
			set doc [dom parse -simple -keepEmpties "<p>$msg</p>"]
			if {$type == 7 && [string range $msg 0 6] == "<files "} {
				set msg "$name sent files: [string trim [$doc asText]]"
			} elseif {$type == 7} {
				set msg "$name [string trim [$doc asText]]"
			} else {
				set msg [$doc asText]
			}
			$doc delete
			set msg [string trim $msg]
			set time [clock format $time -format $tformat -timezone $tz]
			if {!$dir && $a < [expr $qcount - 1]} {
				puts $chan [string map {"\x17" ""} "\[$time\] $name: $msg"]
			} else {
				puts $chan "\[$time\] $name: $msg"
			}
		}
		if {!$dir && $a < [expr $qcount - 1]} {
			puts $chan "\x17"
		} elseif {$dir} {
			chan close $chan
		}
	}
	if {$close} {chan close $chan}
}