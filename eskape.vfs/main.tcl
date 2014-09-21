package require Tcl 8.6
set VERSION "1.0.0"

try {
	package require starkit
	starkit::startup
	set here $starkit::topdir
	lappend auto_path [file join $here lib]
} on error {} {
	set here [file dirname $argv0]
}

source [file join $here error.tcl]
source [file join $here func.tcl]
source [file join $here dump.tcl]
source [file join $here terminal.tcl]
#source [file join $here gui.tcl]

package require sqlite3
package require tdom

#if {!$argc} {
	#loadGUI
	#try {loadGUI} on error {} {loadConsole}
#} else {
	loadConsole
#}