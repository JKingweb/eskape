proc loadGUI {} {
	package require mentry
	package require gridplus
	#create global variables for use with various widgets
	set ::lastSorted ""
	set ::outpath ""
	set ::outtype ""
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