proc loadGUI {} {
	#throw {NOT_IMPLEMENTED} {}
	package require Tk
	package require autoscroll
	package require mentry
	#create window elements
	ttk::frame 				.top
	ttk::labelframe 		.outf	-text "Save to"
	ttk::entry				.out 	-textvariable outpath
	ttk::button				.outbd	-text "D" -command selectOutputDirGUI -width 2
	ttk::button 			.outbf 	-text "F" -command selectOutputFileGUI -width 2
	ttk::button 			.conf 	-text "C" -width 2
	ttk::frame 				.listf
	ttk::treeview 			.list 	-show headings -yscroll ".listv set" -xscroll ".listh set"
	ttk::scrollbar 			.listv 	-orient vertical -command ".list yview"
	ttk::scrollbar 			.listh 	-orient horizontal -command ".list xview"
	ttk::frame				.datef
	::mentry::dateMentry 	.dates 	"Ymd" "-"
	::mentry::dateMentry 	.datee 	"Ymd" "-"
	#create global variables for use with various widgets
	set ::lastSorted ""
	set ::outpath ""
	set ::outtype ""
	#set up the conversation list treeview
	::autoscroll::autoscroll .listh
	::autoscroll::autoscroll .listv
	set cols {
		id {t "ID" s 0 a center}
		acct {t "Account" s 150 a w}
		who {t "Contact" s 250 a w}
		type {t "Type" s 70 a w}
		start {t "First Message" s 120 a w}
		end {t "Latest Message" s 120 a w}
	}
	.list configure -columns [dict keys $cols]
	set displayed {}
	dict for {id dict} $cols {
		.list heading $id -text [dict get $dict t] -anchor [dict get $dict a] -command "sortConversationsGUI .list $id"
		.list column $id -width [dict get $dict s] -anchor [dict get $dict a]
		if {[dict get $dict s]} {lappend displayed $id}
	}
	.list configure -displaycolumns $displayed
	#set up the window
	. configure -padx 10 -pady 10
	pack .top -fill both -expand 1
	pack .outf -fill both -expand 1 -pady {0 15} -side left -in .top
	pack .conf -padx {15 0} -side right -in .top -anchor e
	pack .out -in .outf -anchor w -fill x -expand 1 -side left -padx {5 10}
	pack .outbf .outbd -anchor e -after .out -side right -padx {0 5}
	pack .listf -fill both -expand 1 
	grid .list .listv -in .listf -sticky nsew
	grid .listh -in .listf -sticky nsew
	grid column .listf 0 -weight 1
	grid row    .listf 0 -weight 1
	pack .dates .datee
	#get the database ready and populate values	
	readyDb db [getPath]
	listConversationsGUI .list db {contact group other}
	set ::outpath [file nativename [pwd]]
}
proc listConversationsGUI {list db {types {}}} {
	set convos [getConversations $db $types]
	$list delete [$list children ""]
	set grouptext {
		contact	Contact
		group 	Group
		blocked	Blocked
		other	Other
	}
	set timeformat "%Y-%m-%d %T"
	foreach convo $convos {
		lassign $convo id account num identity displayname type first last
		if {$displayname==$identity} {
			set fullname $identity
		} elseif {$type=="group"} {
			set fullname $displayname
		} else {
			set fullname "$displayname ($identity)"
		}
		set type [dict get $grouptext $type]
		set first [clock format $first -format $timeformat]
		set last [clock format $last -format $timeformat]
		$list insert "" end -values [list $id $account $fullname $type $first $last]
	}
	sortConversationsGUI $list who
	sortConversationsGUI $list type
	sortConversationsGUI $list acct	
}
proc sortConversationsGUI {list col} {
	set items {}
	foreach row [$list children ""] {
		lappend items [list [$list set $row $col] $row]
	}
	if {$::lastSorted==$col} {
		set items [lsort -dictionary -index 0 -decreasing $items]
		set ::lastSorted ""
	} else {
		set items [lsort -dictionary -index 0 -increasing $items]
		set ::lastSorted $col
	}
	set a -1
	foreach row $items {
		$list move [lindex $row 1] {} [incr a]
	}
}
proc selectOutputFileGUI {} {
	set ext ""
	if {[osType]=="win"} {set ext "txt"}
	set choice [tk_getSaveFile -defaultextension $ext -parent .]
	if {$choice != ""} {
		set ::outtype "file"
		set ::outpath [file nativename $choice]
	}
}
proc selectOutputDirGUI {} {
	set choice [tk_chooseDirectory]
	if {$choice != ""} {
		set ::outtype "dir"
		set ::outpath [file nativename $choice]
	}
}