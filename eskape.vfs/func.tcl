#parses ISO 8601-like dates and returns Unix timestamps.  Takes a list of two dates, the start and end of a range
proc parseDates {dates {zone ":localtime"}}  {
	set end 0
	set data [list]
	#parse each of the two dates in turn
	foreach d $dates {
		set week 0
		set ord 0
		set add ""
		if {[regexp -nocase {^(\d{4})()-?(\d{3})(?!\d)(?:(?:\s+|T)(\d?\d)(?:[:\.]?(\d\d))?(?:[:\.]?(\d\d))?(?:\s*(AM|PM))?(?:\s*([+-]\d\d(?:[:\.]?\d\d)?|Z))?)?} $d match Y M D h m s t z]} {
			#matches an ordinal date
			incr ord
			set f "%Y%j %H:%M:%S"
		} elseif {[regexp -nocase {^(\d{4})-?W(\d\d)(?:-?(\d)(?:(?:\s+|T)(\d?\d)(?:[:\.]?(\d\d))?(?:[:\.]?(\d\d))?(?:\s*(AM|PM))?(?:\s*([+-]\d\d(?:[:\.]?\d\d)?|Z))?)?)?} $d match Y M D h m s t z]} {
			#matches a week number
			incr week
			set f "%G%V%u %H:%M:%S"
		} elseif {[regexp -nocase {^(\d{4})(?:-?(\d\d)(?:-?(\d\d)(?:(?:\s+|T)(\d?\d)(?:[:\.]?(\d\d))?(?:[:\.]?(\d\d))?(?:\s*(AM|PM))?(?:\s*([+-]\d\d(?:[:\.]?\d\d)?|Z))?)?)?)?} $d match Y M D h m s t z]} {
			#matches a conventional date
			set f "%Y%m%d %H:%M:%S"
		} else {
			#invalid dates are silently ignored
			lappend data ""
			incr end
			continue
		}
		#adjust input to deal with varying levels of precision
		if {$M=="" && !$ord && !$week} {
			#year only
			set add "year"
			set d "${Y}0101 00:00:00"
		} elseif {$D=="" && $week} {
			#year and week
			set add "week"
			set d "$Y${M}1 00:00:00"
		} elseif {$D==""} {
			#year and month
			set add "month"
			set d "$Y${M}01 00:00:00"
		} elseif {$h==""}  {
			#date without time
			set add "day"
			set d "$Y$M$D 00:00:00"
		} elseif {$m==""} {
			#date with hours only
			set add "hour"
			set d "$Y$M$D $h:00:00"
		} elseif {$s==""} {
			#date with hours and minutes
			set add "minute"
			set d "$Y$M$D $h:$m:00"
		} else {
			#complete date and time
			set add "second"
			set d "$Y$M$D $h:$m:$s"
		}
		#if a time of day (AM/PM) was in the input, add this to the input format
		if {$t != ""} {
			append d " " $t
			append f " " "%p"
			set f [string map {"%H" "%I"} $f]
		}
		#if a time zone offset was in the input, add this to the input format
		if {$z != ""} {
			if {[string toupper $z] == "Z"} {
				append d " " "Z"
			} else {
				append d " " [string map {: ""} $z]
			}
			append f " " "%z"
		}
		#attempt to produce a date.  If this doesn't work it's probably because of an invalid time zone.
		try {set stamp [clock scan $d -format $f -timezone $zone]} on error {} {
			err -1
			set stamp [clock scan $d -format $f]
		}
		#if the date in question is an end date, adjust to the end of an imprecise range
		if {$end} {set stamp [expr {[clock add $stamp 1 $add] - 1}]}
		incr end
		lappend data $stamp
	}
	return $data
}

#determine the operating platform.
proc osType {} {
	if {$::tcl_platform(platform)  == "windows"} {
		return win
	} elseif {$::tcl_platform(os) == "Darwin"} {
		return osx
	} else {
		return lin
	}		
}
#determines the default path to look for Skype data
proc getPath {} {
	if {[isArg path]} {
		return [file normalize $::args(path)]
	}
	switch [osType] {
		win {
			if {[isArg win8]} {set win8 $::args(win8)} else {set win8 "desktop"}
			set modern  [file join $::env(LOCALAPPDATA) Packages Microsoft.SkypeApp_kzf8qxf38zg5c LocalState main.db]
			set desktop  [file join $::env(APPDATA)  Skype]
			if {$win8=="modern" && [file isfile $modern]} {
				set path $modern
			} elseif {$win8 != "modern" && ![llength [glob -nocomplain -join $desktop * main.db]] && [file isfile $modern]} {
				set path $modern
			} else {
				set path $desktop
			}					
		}
		lin {set path [file join ~ .Skype]}
		osx {set path [file join ~ Library "Application Support" Skype]}
	}
	return [file normalize $path]
}
proc getDbFiles {path} {
	if {[file isdirectory $path]} {
		set list [glob -nocomplain -join $path * main.db]
		return [lmap file $list {list $file [file tail [file dirname $file]]}]
	} elseif {[file isfile $path]} {
		return [list [list $path [getAccounts $path]]]
	} else {
		return {}
	}
}
proc readyDb {db path {users {}}} {
	set files [getDbFiles $path]
	if {[llength $users] > 0} {
		for {set a 0} {$a < [llength $files]} {incr a} {
			if {[lsearch $users [lindex [lindex $files $a] 1]] == -1} {
				set files [lreplace $files $a $a]
				incr a -1
			}
		}
	}
	try {
		sqlite3 $db ":memory:" -readonly true
		$db eval "pragma temp_store = MEMORY;"
		$db eval "PRAGMA query_only = 1;"
		foreach file $files {
			lassign $file path acct
			$db eval "attach database '$path' as \"$acct\";"
		}
		return 1
	} on error {} {
		err -2 
		return 0
	}
}
proc acctNames {db} {
	set names [list]
	$db eval {pragma database_list;} "" {
		if {$seq > 0} {lappend names $name}
	}
	return $names
}
proc parseList {db which {acct ""}} {
	set acct ""
	set data [dict create]
	if {$acct==""} {
		set accts [acctNames $db]
		if {[llength $accts] == 1} {set acct [lindex $accts 0]}
	}
	foreach id $which {
		if {[regexp {^(?:([^:]+):)?(\d+)} $id match user convo]} {
			if {$user != ""} {set acct $user}
			if {$acct == ""} {continue}
			dict lappend data $acct $convo
		}
	}
	foreach key [dict keys $data] {
		if {[lsearch $accts $key] == -1} {dict unset data $key}
	}
	return $data
}
proc prepareQuery {convos mode {times {"" ""}}} {
	set columns "chatmsg_type as type, timestamp as time, from_dispname as name, body_xml as msg"
	set orderBy "order by timestamp"
	set exclusions [list "body_xml <> ''" "chatname <> ''" "chatmsg_type <> 18"]
	if {[lindex $times 0] != ""} {lappend exclusions "timestamp >= [lindex $times 0]"}
	if {[lindex $times 1] != ""} {lappend exclusions "timestamp <= [lindex $times 1]"}
	set queries [list]
	switch $mode {
		merge {
			set unions [list]
			foreach acct [dict keys $convos] {
				lappend unions [concat select chatmsg_type, timestamp, from_dispname, body_xml, chatname from "\"${acct}\".Messages" where convo_id in( [join [dict get $convos $acct] ","] )]
			}
			lappend queries [list [concat select $columns from ( [join $unions " union all "] ) where [join $exclusions " and "] $orderBy ";"] "merged"]
		}
		serial {
			foreach acct [dict keys $convos] {
				foreach id [dict get $convos $acct] {
					lappend queries [list [concat select $columns from "\"${acct}\".Messages" where convo_id = $id and [join $exclusions " and "] $orderBy ";"] [join [list $acct $id] ":"]]
				}
			}
		}
			
	}
	return $queries
}
proc prepareChannel {out {type ""}} {
	set dir 0
	set close 0
	if {$type != ""} {
		# do nothing
	} elseif {[llength [chan names $out]] > 0} {
		set type chan
	} elseif {[file isdirectory $out]} {
		set type dir
	} else {
		set type file
	}
	switch $type {
		chan {return [list $out $dir $close]}
		folder - 
		dir {
			set dir 1
			if {[file exists $out]  && ![file writable $out]} {throw {WRITE DIR} "Selected output directory is not writable."}
			if {![file exists $out]} {
				try {file mkdir $out} on error {} {throw {CREATE DIR} "Selected output directory could not be created."}
			}
			return [list $out $dir $close]
		}
		multifile {
			set dir 1
			if {[file exists $out] && ![file writable $out]} {throw {WRITE FILE} "Selected output file is not writable."}
			set parent [file dirname $out]
			if {[file exists $parent] && ![file writable $parent]} {throw {CREATE FILE} "Selected output file could not be created."}
			if {![file exists $parent]} {
				try {file mkdir $parent} on error {} {throw {CREATE DIR} "Selected output directory could not be created."}
			}
			set out [open $out w]
			chan configure $out -encoding utf-8
			puts -nonewline $out \uFEFF
			return [list $out $dir $close]
		}
		file -
		default {
			set close 1
			if {[file exists $out] && ![file writable $out]} {throw {WRITE FILE} "Selected output file is not writable."}
			set parent [file dirname $out]
			if {[file exists $parent] && ![file writable $parent]} {throw {CREATE FILE} "Selected output file could not be created."}
			if {![file exists $parent]} {
				try {file mkdir $parent} on error {} {throw {CREATE DIR} "Selected output directory could not be created."}
			}
			set out [open $out w]
			chan configure $out -encoding utf-8
			puts -nonewline $out \uFEFF
			return [list $out $dir $close]
		}
	}
}
	
	

proc getAccounts {path} {
	if {[file isdirectory $path]} {
		return [lmap file [glob -nocomplain -join $path * main.db] {file tail [file dirname $file]}]	
	} elseif {[file isfile $path]} {
		set accts [list]
		try {sqlite3 tempDb $path -readonly true} on error {} {return {}}
		try {
			tempDb eval {select skypename from Accounts;} "" {
				lappend accts $skypename
			}
		} finally {
			tempDb close
			return $accts
		}
	} else {
		return {}
	}
}
proc getConversations {db {types {}}} {
	set convos {}
	set convoStat {}
	set convoList {}
	set convoTimes {}
	set accts [acctNames $db]
	if {[llength $types] == 0} {
		set types [list contact]
	} elseif {[lsearch $types all] > -1} {
		set types [list contact group other blocked]
	} else {
		set types [lsort -unique $types]
	}
	foreach acct $accts {
		lappend convoStat  "select '${acct}:'||id as id, case when type in(2,4) then 'group' when identity in(select skypename from \"$acct\".Contacts where availability=9) then 'blocked' when identity in(select skypename from \"$acct\".Contacts where availability>0) then 'contact' else 'other' end as type from \"$acct\".Conversations"
		lappend convoList  "select '${acct}:'||id as id, id as num, '${acct}' as account, identity, displayname from \"$acct\".Conversations"
		lappend convoTimes "select '${acct}:'||convo_id as id, min(timestamp) as first,  max(timestamp) as last from \"$acct\".Messages group by convo_id"
	}
	set convoStat  [join $convoStat " union all "]
	set convoList  [join $convoList " union all "]
	set convoTimes [join $convoTimes " union all "]
	set having "having type in('[join $types "','"]')"
	set query "select ConvoList.*, ConvoStat.type, ConvoTimes.first, ConvoTimes.last from ($convoStat) as ConvoStat, ($convoList) as ConvoList, ($convoTimes) as ConvoTimes on ConvoList.id = ConvoStat.id and ConvoList.id = ConvoTimes.id and ConvoStat.id = ConvoTimes.id group by ConvoList.id $having order by account, displayname collate nocase"
	try {$db eval "$query" "" {lappend convos [list $id $account  $num $identity  $displayname $type $first $last]}} on error {} {
		err -3 
	}
	return $convos
}