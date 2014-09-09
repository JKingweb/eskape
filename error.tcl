proc err {code {etc ""}} {
	set fatal 0
	if {$code < 0} {set warn 1} else {set warn 0}
	switch $code {
		-4 {set text "Could not open \"$etc\" for writing."}
		-3 {set text "Specified database is not a Skype database."}
		-2 {set text "Specified database is not readable."}
		-1 {set text "Specified input timezone is invalid; using local time instead."}
		1  {set text "Tcl version mismatch."; set fatal 1}
		2  {set text "Package '$etc' could not be loaded."; set fatal 1}
		3  {set text "Command '$etc' not recognized."}
		4  {set text "Command option '$etc' not recognized."}
		5  {set text "Missing option before first value."}
		6  {lassign $etc opt val; set text "Value '${val}' not allowed for option '${opt}'."}
		7  {set text "Values are not allowed for option '$etc'."}
		8  {set text "Selected output file is not writable."}
		9  {set text "Selected output directory is not writable."}
		10 {set text "Selected output file could not be created."}
		11 {set text "Selected output directory could not be created."}
	}
	if {$fatal} {
		set type "FATAL ERROR"
	} elseif {$warn} {
		set type "Warning"
	} else {
		set type "Error"
	}
	puts stderr "$type: $text"
	if {!$warn} {exit $code}
}
