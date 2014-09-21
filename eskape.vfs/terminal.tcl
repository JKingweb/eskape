#determine what to do based on the command specified
proc loadConsole {} {
	set cmd [getCmd]
	getArgs $cmd
	array set ::args [list path [getPath]]
	switch $cmd {
		a {listAccountsConsole}
		c {listConversationsConsole}
		x {extractLogConsole}
		v {showVersionConsole}
		h {showUsageConsole}
		"" {
			#if no command is specified, check to see if any Unix-typical options are specified
			if {[isArg v]} {
				showVersionConsole
			} elseif {[isArg h] || [isArg help] || [isArg "-help"] || !$::argc} {
				showUsageConsole
			} else {
				err 3
			}
		}
		default {err 3 $cmd}
	}
}
#read out a numbered command-line argument
proc getArg {arg} {
	return [lindex $::argv $arg]
	
}
#read out the first command-line argument.  If it doesn't look like a command (more than one char), insert an empty string as the first argument and return that.
proc getCmd {} {
	if {[string length [getArg 0]] > 1} {
		set ::argv [linsert $::argv 0 ""]
	}
	return [string tolower [getArg 0]]
}
#process command-line arguments to the "args" array in global scope
proc getArgs {cmd} {
	set a 1
	set opt ""
	array set ::args {}
	#define a structure of each command's allowed options and allowed values if applicable
	set props {
		global {
			path {1 {}}
			win8 {1 {desktop modern}}
		}
		v {}
		h {
			more {0 {}}
		}
		a {}
		c {
			account {2 {}}
			type {2 {contact group blocked other all}}
		}
		x {
			which {2 {}}
			out {1 {}}
			outtype {1 {file dir folder}}
			mode {1 {serial merge}}
			start {1 {}}
			end {1 {}}
			tzin {1 {}}
			tzout {1 {}}
			tformat {1 {}}
		}
		"" {
			v {0 {}}
			h {0 {}}
			help {0 {}}
			"-help" {0 {}}
		}
	}
	#check to see if the command itself is allowed
	set valid [dict keys $props]
	if {[lsearch $valid $cmd] < 0} {err 3 $cmd}
	#create one list of allowed options consisting of options for the selected command and global options.
	set props [concat [dict get $props global] [dict get $props $cmd]]
	set valid [dict keys $props]
	#loop through arguments and build a dictionary of options and values
	set arg [getArg $a]
	while {$arg != ""} {
		#check if argument is an option or value
		if {[string range $arg 0 0] == "-"} {
			#make option lowercase
			set opt [string tolower [string range $arg 1 end]]
			#check it against allowed list
			if {[lsearch $valid $opt] > -1} {
				#add option to the dictionary 
				set ::args($opt) [list]
				#populate option properties for forthcoming values
				lassign [dict get $props $opt] howmany allowed
			} else {
				#if it's not a valid option, error out
				err 4 $opt
			}
		} else {
			#if no option has been seen before the first value, this is an error
			if {$opt == ""} {err 5}
			#if the list of values is restricted and the value we're seeing is not one of these, this is also an error
			if {[llength $allowed]} {
				set arg [string tolower $arg]
				if {[lsearch $allowed $arg] < 0} {err 6 [list $opt $arg]}
			}
			# if only one value is allowed, overwite any previously stored value; otherwise, append to a list
			if {$howmany==1} {
				set ::args($opt) $arg
			} elseif {$howmany > 1} {
				lappend ::args($opt) $arg
			} else {
				err 7 $opt
			}
		}
		#retrieve the next argument
		incr a
		set arg [getArg $a]
	}
}
#checks whether an option has been specified
proc isArg {name} {
	if {[array names ::args $name] != ""} {
		return 1
	} else {
		return 0
	}
}


proc listAccountsConsole {} {
	set list [getAccounts $::args(path)]
	if {[llength $list] == 0} {
		exit 2
	}
	puts [join $list "\n"]
}
proc listConversationsConsole {} {
	if {[isArg account]} {set accts $::args(account)} else {set accts {}}
	if {[isArg type]} {set types $::args(type)} else {set types {}}
	readyDb db $::args(path) $accts
	set convos [getConversations db $types]
	foreach convo $convos {
		lassign $convo fullid acct id user name
		puts "$acct:[format "%-7d" $id] $name ($user)"
	}
}
proc extractLogConsole {} {
	set times [list]
	readyDb db $::args(path)
	if {[isArg account]} {set acct $::args(account)} else {set acct ""}
	if {[isArg which]} {
		set data [parseList db $::args(which) $acct]
	} else {
		set data [parseList db [split [chan read stdin] "\n"] $acct]
	}
	if {[isArg mode]} {set mode $::args(mode)} else {set mode serial}
	if {[isArg start]} {lappend times $::args(start)} else {lappend times ""}
	if {[isArg end]} {lappend times $::args(end)} else {lappend times ""}
	if {[isArg tzin]} {set tzin $::args(tzin)} else {set tzin ":localtime"}
	if {[isArg tzout]} {set tzout $::args(tzin)} else {set tzout ":localtime"}
	if {[isArg tformat]} {set tformat $::args(tformat)} else {set tformat "%Y-%m-%d %T"}
	if {[isArg out]} {set out [file normalize $::args(out)]} else {set out stdout}
	if {[isArg outtype]} {set outtype $::args(outtype)} else {set outtype ""}
	set times [parseDates $times $tzin]
	set queries [prepareQuery $data $mode $times]
	try {
		dumpLog db $queries $out $outtype text $tzout $tformat
	} trap {WRITE FILE} {} {err 8} trap {WRITE DIR} {} {err 9} trap {CREATE FILE} {} {err 10} trap {CREATE DIR} {} {err 11}
}
proc showVersionConsole {} {
	puts $::VERSION
}
proc showUsageConsole {} {
	if {[isArg more]} {
		puts [string trim {
Usage: eskape <command> [option] ...

Available commands:

	h	Displays this text
	v	Displays version number
	a	Lists accounts with history in the selected database set
	c	Lists conversations which may be extracted
	x	Extracts conversations


Global options:

	-path <path to folder or file>

		Specifies a path to an alternate Skype database-set directory 
		or to a specific database file.  The default path is 
		platform-dependent.

	-win8 <desktop|modern>

		On Windows 8, specifies whether to look first for a "Modern" 
		app database or a desktop app database.  In either case both 
		will be tried if the first choice cannot be found.  The default
		is to look for a desktop database set first.  On platforms 
		other than Windows 8 this option has no effect.


Help options:

	-more
		
		Displays more detailed help text (this text)


Account list options:
	
	This command has no options besides the global options.


Conversation list options:
	
	-account <skype name> ...
		
		Restricts the conversation list to include only those for the 
		specified accounts.
	
	-type <contact|group|blocked|other|all> ...
	
		Specifies which types of conversations to list:
			contact
				Conversations with users currently in 
				your contact list.  This is the default
			group
				Group chats with any users
			blocked
				Conversations with blocked contacts
			other
				Conversations with non-contacts
			all
				Conversations of any type


Extraction options:
	
	-which <conversation> ...
	
		The list of conversations to extract, in the same format as 
		returned by the conversation list command:
		
			account_name:conversation_number
		
		Multiple conversations may be specified.  If this option is not
		specified, the list of conversations is instead read from 
		standard input, with one conversation per line.
	
	-out <path to folder or file>
		
		Sets the output folder or file.  Multiple conversations may be 
		output to one file, with some caveats; see "Outputting 
		multiple conversations to a single file" below for details.  
		By default logs are sent to standard output, which is 
		effectively a file.
		
		If the specified path does not exist, it is assumed to be a 
		file and will be created as such.  The -outtype option may be
		used to force creation of a folder.
		
	-outtype <file|folder|dir>
	
		Used to force the interpretation of the -out option as a file
		or folder in situations where the intent may be ambiguous.

	-mode <serial|merge>
	
		When multiple conversations are selected, specifies whether 
		these should be output in sequence or merged together as a 
		single conversation along the same timeline.  This is useful 
		if e.g. one person has two accounts.  The default is to output
		conversations separately.
	
	-start <ISO 8601 date>
	
		Specifies a starting date for log output; any messages 
		previous to this date will be excluded.  See "Date input" 
		below for more details.
	
	-end <ISO 8601 date>
	
		Specifies an end date for log output; any messages after this
		date will be excluded.  See "Date input" below for more 
		details.
	
	-tzin <zoneinfo name>
	
		Time zone to use when interpreting dates for the -start and 
		-end options.  By default system time is used, or any 
		time offset accompanying the date value in question.
		
	-tzout <zoneinfo name>
	
		Time zone to use when printing dates in logs.  By default 
		system time is used.
	
	-tformat <Tcl time format>
	
		Time format to use when printing dates in logs.  This can be
		any date format string acceptable to the Tcl interpreter.  The
		default format is "%Y-m-%d %T".  See the following Web page 
		for further details: 
		
		<http://www.tcl.tk/man/tcl8.6/TclCmd/clock.htm#M26>


Date input:
	
	The -start and -end extraction options take ISO 8601 dates as their
	values.  This may be any point-in-time format as described here:
	
	<http://en.wikipedia.org/wiki/ISO_8601>
	
	This software, however, deviates from ISO 8601 in the following ways:
	
	* Durations and intervals are not supported
	* A 12-hour clock may be explicitly used by appending AM or PM
	  to the time before the time zone offset
	* Date and time may be separated by a space rather than "T"
	* Time parts may be separated by periods rather than colons
	* Fractions of seconds are not supported (Skype precision is seconds)
		
	While time zone offsets are accepted, using the -tzin option is 
	highly recommended to avoid errors stemming from DST.
	
	For end dates, imprecise dates are assumed to be inclusive.  For
	example, "2001" will expand to "2001-12-31 23:59:59".
	
	Examples of valid dates:
	
		2012
		201309
		2015-04-03
		1999W02-3
		2020-193
		20140525 2:34:45AM
		2008-12-13T14:50:12-03:30


Outputting multiple conversations to a single file:

	While writing several separate logs to a single file (or standard 
	output) is supported, there are a small number of formatting 
	considerations worthy of note:
	
	* A header will be prepended to the file, listing the ID of each 
	  conversation in the order it will thereafter appear.  This is not 
	  guaranteed to be input order.  The header is terminated by a line 
	  with a single "End of Transmission Block" (0x17; ETB) character.
	* Logs are separated with ETB characters on separate lines.  The final 
	  log is not followed by an ETB character.
	* Any ETB characters within log text are stripped.
	

Usage examples:
	
	Listing conversations with contacts:
		eskape c
	Listing group chats:
		eskape c -type group
	Printing a single conversation to screen:
		eskape x -which johndoe:2112
	Merging two conversations:
		eskape x -which samson:1337 adon:1001001 -mode merge
	Writing conversations to many files in a folder:
		eskape x -which a:42 q:54 -out "some/folder name"
	Writing all conversations to a folder:
		eskape c -type all | eskape x -out "some/folder name"
	Printing six months of a conversation:
		eskape x -which hln:64 -start "2012-07" -end "2012-12"
		}]
	} else {
		puts [string trim {
Usage: eskape <command> [option] ...

Available commands:

	h	Displays this text
	v	Displays version number
	a	Lists accounts with history in the selected database set
	c	Lists conversations which may be extracted
	x	Extracts conversations


Global options:

	-path <path to folder or file>
	-win8 <desktop|modern>

Help options:

	-more

Account list options:
	
	This command has no options besides the global options.

Conversation list options:
	
	-account <skype name> ...
	-type <contact|group|blocked|other|all> ...

Extraction options:
	
	-which <conversation> ...
	-out <path to folder or file>
	-outtype <file|folder|dir>
	-mode <serial|merge>
	-start <ISO 8601 date>
	-end <ISO 8601 date>
	-tzin <zoneinfo name>
	-tzout <zoneinfo name>
	-tformat <Tcl time format>

Usage examples:
	
	Listing conversations with contacts:
		eskape c
	Listing group chats:
		eskape c -type group
	Printing a single conversation to screen:
		eskape x -which johndoe:2112
	Merging two conversations:
		eskape x -which samson:1337 adon:1001001 -mode merge
	Writing conversations to many files in a folder:
		eskape x -which a:42 q:54 -out "some/folder name"
	Writing all conversations to a folder:
		eskape c -type all | eskape x -out "some/folder name"
	Printing six months of a conversation:
		eskape x -which hln:64 -start "2012-07" -end "2012-12"
		}]
	}		
}