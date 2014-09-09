#========================================================================#
# SCRIPT : gridplus.tcl                                                  #
# PURPOSE: Gridplus layout manager.                                      #
# AUTHOR : Adrian Davis                                                  #
#        : Incudes code from tile "combobox.tcl" by Joe English.         #
# VERSION: 2.10                                                          #
# DATE   : 01/07/2013                                                    #
#------------------------------------------------------------------------#
# HISTORY: 2.0 07/10/2006  - First release of Tile based GRIDPLUS.       #
#        : 2.1 24/02/2007  - Enchanced gpmap: Array mapping.             #
#        :                 - Documents gpinsert and gpselect.            #
#        :                 - Adds Container.                             #
#        :                 - Removes special main/title condition.       #
#        :                 - Adds notebook "-command" option.            #
#        :                 - Fix tablelist sort problem.                 #
#        :                 - Adds text "-font" option.                   #
#        : 2.2 22/07/2007  - Change gpmap to set dropdown value not list.#
#        :                 - Adds "-icons" option for tree.              #
#        :                 - Fix padding problem in layout.              #
#        :                 - Fix "container".                            #
#        :                 - Changes "gridplus window" for container.    #
#        : 2.3 15/05/2008  - Adds Find dialog to text pop-up menu.       #
#        :                 - Adds "-labelanchor" option.                 #
#        :                 - Adds "-validateauto" option.                #
#        :                 - Adds "-validate" for tablelist/tree.        #
#        :                 - Adds option to specify an event to "-ecmd". #
#        :                 - Adds option to fix maximum entry characters.#
#        :                 - Adds "popup" validation error messages.     #
#        :                 - Adds "?!" help text set to validation text. #
#        :                 - Adds menu "underline" option.               #
#        :                 - Adds gpfind_dialog.                         #
#        :                 - Adds gpfind, gpclear, gpcut, gpcopy, gppaste#
#        :                 - Adds "-topmost" option to "gridplus window".#
#        :                 - Adds "-columnformat & -cfmt".               #
#        :                 - Change menu "=" as separator.               #
#        :                 - Change menu allow "~" to indicate command.  #
#        :                 - Fix problem with date validations.          #
#        :                 - Fix Validation in contained window problem. #
#        : 2.4 05/02/2009  - Adds "-columnstretch".                      #
#        :                 - Adds "-basename".                           #
#        :                 - Adds new syntax for embedded grids.         #
#        :                 - Adds #style" widget option.                 #
#        :                 - Adds radiobutton groups.                    #
#        :                 - Adds "gridplus define".                     #
#        :                 - Adds resize options to layout and "pack"    #
#        :                   command mode.                               #
#        :                 - Adds "-command" to text - Triggered when    #
#        :                   text is modified.                           #
#        :                 - Fix validate popup for toplevel windows.    #
#        :                 - Fix for "gpEditMenu" in contained windows.  #
#        :                 - Fix problem with validation for command     #
#        :                   invoked by pressing enter in entry. If a    #
#        :                   field has both a command and a validation   #
#        :                   specified, the validation will always be    #
#        :                   done when a command specified for the entry #
#        :                   is invoked.                                 #
#        :                 - Fix problem setting dropdown using gpmap.   #
#        :                 - "gpselect" modified to "see" tablelist row. #
#        :                 - Fix date validations.                       #
#        :                 - Fix validation popup in notebooks.          #
#        :                 - Fix problem displaying label text when      #
#        :                   default widget is button/link/menubutton.   #
#        : 2.5 25/10/2009  - Adds "calendar" gridplus command mode.      #
#        :                 - Adds "dateselector" gridplus command mode.  #
#        :                 - Adds "gpnav" command.                       #
#        :                 - Adds extra pre-defined entry validations.   #
#        :                 - Adds "trim:" option for entry validations.  #
#        :                 - Adds "!+" button wigdet option.             #
#        :                 - Adds "-overrideredirect" option for window. #
#        :                 - Adds default (".") optionset.               #
#        :                 - Change gpset and gpselect to set values for #
#        :                   "calendar" and "dateselector".              #
#        :                 - Change button widget so that Enter key will #
#        :                   invoke the button command.                  #
#        :                 - Change entry validation behaviour to work   #
#        :                   better losing focus to toplevel windows.    #
#        :                 - Fix entry validation losing focus to a      #
#        :                   toplevel window.                            #
#        :                 - Fix entry validation popup messages in      #
#        :                   notebooks.                                  #
#        :                 - Fix "num" validation pattern.               #
#        :                 - Fix "expected integer" font problem due to  #
#        :                   Tcl/Tk bug.                                 #
#        : 2.6 23/10/2010  - Adds "single/space" option to tree.         #
#        :                 - Adds "ISO" date format.                     #
#        :                 - Fix Unix container problem.                 #
#        : 2.7 26/02/2012  - Adds option to set locale.                  #
#        :                 - Adds "gpdefault" command.                   #
#        :                 - Adds "gpdate" command.                      #
#        :                 - Adds "=inline" entry/date default option.   #
#        :                 - Adds "tablelist" sort options.              #
#        :                 - Adds label width option.                    #
#        :                 - Adds "Gridplus.optionsetDefaultStyle".      #
#        :                 - Fix date selector problem in topmost window.#
#        :                 - Fix problem clearing radiobutton groups.    #
#        :                 - Fix modal flag clear problem.               #
#        : 2.8 28/03/2012  - Adds "=inline" dropdown default option.     #
#        :                 - Adds "~command" link option.                #
#        :                 - Change "checkbutton" so that the "+" option #
#        :                   always results in a checked button.         #
#        :                 - Fix "gpset" to make sure window is updated. #
#        :                 - Fix problem clearing "radiobutton" groups.  #
#        :                 - Fix link indent problem.                    #
#        :                 - Fix gap in "theme" style border caused by   #
#        :                   ttk::labelframe bug.                        #
#        : 2.9 04/07/2012  - Fix problem with value of tree node         #
#        :                   containing spaces.                          #
#        :                 - Fix problem with "container" frame sizing.  #
#        :                 - Fix problem with some validations in        #
#        :                   "contained" toplevels.                      #
#        :                 - Fix "clear" to withdraw validation pop-up   #
#        :                   message.                                    #
#        : 2.10 01/07/2013 - Adds "spinbox" gridplus command mode.       #
#        :                 - Adds "pane" gridplus command mode.          #
#        :                 - Adds "gpoptions" command.                   #
#        :                 - Adds interface (and supporting procedures)  #
#        :                   to create user defined widget types for     #
#        :                   "widget" grid.                              #
#        :                 - Adds "dateselector" option to display icon  #
#        :                   instead of downarrow.                       #
#        :                 - Adds "-menu" option to "text".              #
#        :                 - Adds "-seeinsert" option to "text".         #
#        :                 - Adds "-seeinsert" option to "tablelist".    #
#        :                 - Adds "-takefocus" option to "tablelist".    #
#        :                 - Adds "-selectpage" option to "tablelist".   #
#        :                 - Adds "+" (focus) button widget option.      #
#        :                 - Adds new "gpselect" syntax/options.         #
#        :                 - Adds "-title" option to "gpset".            #
#        :                 - Adds "-name" option to "gpset".             #
#        :                 - Adds "gpmap" option to map to dict.         #
#        :                 - Adds Grid/Layout and Notebook command       #
#        :                   substitution.
#        :                 - Adds Popup/Balloon help display duration.   #
#        :                 - Change Popup/Balloon help to display at     #
#        :                   pointer position.                           #
#        :                 - Change to allow "@" embedded widgets to     #
#        :                   work in embedded grids.                     #
#        :                 - Change: Support for old "&w" embedded       #
#        :                   widget grid syntax removed.                 #
#        :                 - Fix problem setting tablelist sort column   #
#        :                   when first column is integer/real.          #
#        :                 - Fix problem with tablelist row selection.   # 
#        :                 - Fix problem with clipboard operations when  #
#        :                   widget with focus not of suitable type.     #
#        :                 - Fix problem with "gpfind" with patterns     #
#        :                   begining with "-".                          #
#        :                 - Fix problem when selecting tablelist row    #
#        :                   using (Up and Down) cursor keys.            #
#        :                 - Fix menu separator problem with cascade     #
#        :                   style menus.                                #
#        :                 - Code Tidy:-                                 #
#        :                   gpWidget rewritten/retructured/modularised. #
#        :                   Four namespace variables eliminated.        #
#========================================================================#

package require Tk 8.5

package require msgcat
namespace import msgcat::*

catch {package require icons}
catch {package require tablelist_tile}

package provide gridplus 2.10

#=======================================================================#
# Export the public interface.                                          #
#=======================================================================#

namespace eval ::gridplus:: {
   namespace export gridplus
   namespace export gpcopy
   namespace export gpclear
   namespace export gpcut
   namespace export gpdate
   namespace export gpdefault
   namespace export gpfind
   namespace export gpfind_dialog
   namespace export gpinsert
   namespace export gpmap
   namespace export gpnav
   namespace export gpoptions
   namespace export gppaste
   namespace export gpselect
   namespace export gpset
   namespace export gpunset
   variable gpWidgetHelp
   variable gpConfig
   variable gpInfo
   variable gpOptionSets
   variable gpTabOrder
   variable gpValidate
   variable gpValidateError
   variable gpValidations
}

#=======================================================================#
# PROC   : ::gridplus::gridplus                                         #
# PURPOSE: Exported command.                                            #
#=======================================================================#

proc ::gridplus::gridplus {args} {
   variable gpConfig
   variable gpInfo

   # If first call run initialisation.
   if {! [info exists gpConfig]} {
      gpInit
   }

   # Set array of valid/default options.
   array set options [list                               \
      -action             none                           \
      -anchor             [=< anchor s]                  \
      -autogroup          [=< autoGroup]                 \
      -attach             [=< attach]                    \
      -background         [=< background]                \
      -borderwidth        [=< borderWidth 2]             \
      -basename           {}                             \
      -calcolor           [=< calColor black/white]      \
      -calrelief          [=< calRelief flat]            \
      -calselectcolor     [=< calSelectColor black/gray] \
      -ccmd               {}                             \
      -century            $gpConfig(date:century)        \
      -cfmt               [=< columnFormat]              \
      -checkbuttoncommand {}                             \
      -columnformat       [=< columnFormat]              \
      -columnsort         [=< columnSort 1]              \
      -command            {}                             \
      -compound           left                           \
      -date               {}                             \
      -dateclear          [=< dateClear 1]               \
      -datecommand        {}                             \
      -dateformat         $gpConfig(dateformat)          \
      -dcmd               {}                             \
      -Dcmd               {}                             \
      -dropdowncommand    {}                             \
      -ecmd               [=< entryCommand]              \
      -entrycommand       [=< entryCommand]              \
      -errormessage       $gpConfig(errormessage)        \
      -fileicon           [=< fileIcon file]             \
      -fixed              [=< fixed 999999]              \
      -foldericon         [=< folderIcon folder]         \
      -font               [=< font]                      \
      -foreground         [=< foreground black]          \
      -from               [=< from]                      \
      -group              {}                             \
      -height             [=< height 10]                 \
      -icon               [=< icon]                      \
      -iconfile           $gpConfig(iconfile)            \
      -iconpath           $gpConfig(iconpath)            \
      -icons              [=< icons 1]                   \
      -in                 {}                             \
      -increment          [=< increment 1]               \
      -insertexpr         {}                             \
      -insertoptions      {}                             \
      -justify            left                           \
      -labelanchor        [=< labelAnchor]               \
      -labelcolor         [=< labelColor /]              \
      -labelstyle         [=< labelStyle /]              \
      -linerelief         [=< lineRelief sunken]         \
      -linewidth          [=< lineWidth 2]               \
      -linkcolor          [=< linkColor black/black]     \
      -linkcursor         [=< linkCursor arrow]          \
      -linkstyle          [=< linkStyle /underline]      \
      -listvariable       {}                             \
      -locale             $gpConfig(locale)              \
      -menu               {}                             \
      -minx               100                            \
      -miny               100                            \
      -modal              0                              \
      -names              {}                             \
      -navbar             [=< navBar 1]                  \
      -navcommand         {}                             \
      -navselect          [=< navSelect 0]               \
      -open               [=< open 0]                    \
      -optionset          {}                             \
      -overrideredirect   0                              \
      -pad                [=< pad 5]                     \
      -padding            [=< padding {5 5 5 5}]         \
      -padx               [=< padX [=< pad 5]]           \
      -pady               [=< padY [=< pad 5]]           \
      -pattern            {}                             \
      -prefix             $gpConfig(prefix)              \
      -proc               $gpConfig(proc)                \
      -radiobuttoncommand {}                             \
      -rcmd               {}                             \
      -relief             [=< relief flat]               \
      -resize             {}                             \
      -scroll             none                           \
      -seeinsert          [=< seeInsert 0]               \
      -selectfirst        0                              \
      -selectmode         [=< selectMode browse]         \
      -selectpage         [=< selectPage 0]              \
      -selecttoday        [=< selectToday 0]             \
      -show               [=< show tree]                 \
      -sortfirst          0                              \
      -sortorder          increasing                     \
      -space              [=< space 20]                  \
      -spacestretch       {}                             \
      -spinformat         [=< spinFormat]                \
      -state              normal                         \
      -sticky             [=< sticky]                    \
      -stretch            {}                             \
      -style              {}                             \
      -subst              [=< subst 1]                   \
      -tableoptions       {}                             \
      -taborder           column                         \
      -takefocus          1                              \
      -tags               0                              \
      -text               {}                             \
      -title              {}                             \
      -to                 [=< to]                        \
      -topmost            [=< topmost 0]                 \
      -validate           [=< validate 0]                \
      -validateauto       [=< validateAuto 1]            \
      -validatepopup      [=< validatePopup 0]           \
      -validation         {}                             \
      -variable           {}                             \
      -variables          1                              \
      -wcmd               {}                             \
      -weekstart          [=< weekStart 1]               \
      -widget             [=< widget grid]               \
      -width              [=< width 40]                  \
      -windowcommand      {}                             \
      -wrap               word                           \
      -wraplength         0                              \
      -wtitle             {}                             \
   ]

   # Read mode.
   set mode [lindex $args 0]

   # Validate mode and set parameter template.
   switch -- $mode {
      add         {set argTemplate [list "name 1" "options 2 end"]}
      button      {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      calendar    {set argTemplate [list "name 1" "options 2 end"]}
      checkbutton {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      clear       {set argTemplate [list "name 1" "options 2 end"]}
      container   {set argTemplate [list "name 1" "options 2 end"];set options(-height) [=< containerHeight 200];set options(-width) [=< containerWidth 250]}
      date        {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      define      {set argTemplate [list "layout 1"]}
      dropdown    {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      entry       {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      goto        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      grid        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      init        {set argTemplate [list "options 1 end"]}
      layout      {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      line        {set argTemplate [list "name 1" "options 2 end"]}
      link        {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      menu        {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      menubutton  {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      notebook    {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      optionset   {set argTemplate [list "name 1" "options 2 end-1" "layout end"]}
      pack        {set argTemplate [list "name 1" "options 2 end"]}
      pane        {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-height) [=< paneHeight 0];set options(-width) [=< paneWidth 0]}
      radiobutton {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width)  [=< widgetWidth 10]}
      set         {set argTemplate [list "options 1 end"]}
      spinbox     {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      tablelist   {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< tableWidth 40];set options(-takefocus) 0}
      text        {set argTemplate [list "name 1" "options 2 end"];set options(-width) [=< textWidth 40]}
      tree        {set argTemplate [list "name 1" "options 2 end"];set options(-width) [=< treeWidth 200]}
      widget      {set argTemplate [list "name 1" "options 2 end-1" "layout end"];set options(-width) [=< widgetWidth 10]}
      window      {set argTemplate [list "name 1" "options 2 end"]}
      default     {error "GRIDPLUS ERROR: Invalid mode ($mode)"}
   }

   # Check if sufficient args.
   if {[llength $args] < [llength $argTemplate]} {
      error "GRIDPLUS ERROR: Wrong number of Args."
   }

   # Check if sufficient args remain for option/value pairs.
   if {$mode ne "define" && [expr {([llength $args] - [llength $argTemplate]) % 2}] != 0} {
      error "GRIDPLUS ERROR: Unmatched option/value."
   }

   # Unset gpUnknown.
   foreach unknownItem [array names gpInfo <gpUnknown>*] {
      unset gpInfo($unknownItem)
   }

   # Read/validate arguments.
   foreach template $argTemplate {
      set argName  [lindex $template 0]
      set argStart [lindex $template 1]
      set argEnd   [lindex $template 2]
      # If argName is "options" read option/value pairs.
      if {$argName eq "options"} {
         foreach {option value} [lrange $args $argStart $argEnd] {
            if {[info exists options($option)]} {
               switch -- $option {
                  -pad {
                     set options(-padx) $value
                     set options(-pady) $value
                  }
                  -title {
                     set options(-title) $value
                      if {$options(-title) ne ""} {
                        set options(-relief) theme
                     }
                  }              
                  default {
                     set options($option) $value
                  }
               }
            } else {
               if {[=< unknown 1]} {
                  set gpInfo(<gpUnknown>$option) $value
               } else {
                  error "GRIDPLUS ERROR: Invalid option ($option)."
               }
            }
         }
      } else {
         set options($argName) [lindex $args $argStart]
      }
   }

   # Set optionset.
   gpSetOptionset

   # Remove blank lines from "layout".
   if {[info exists options(layout)]} {
      regsub -all -- {\n\n}                $options(layout) "\n" options(layout)
      regsub -all -- {(^\n)|(\n$)|(\n +$)} $options(layout) ""   options(layout)
   }

   # Call appropriate procedure according to specified mode.
   switch -- $mode {
      add         {gpAdd}
      button      {set options(-widget) b;gpWidget}
      calendar    {gpCalendar}
      checkbutton {set options(-widget) c;gpWidget}
      clear       {gpClear}
      container   {gpContainer}
      date        {set options(-widget) D;gpWidget}
      define      {gpDefine}
      dropdown    {set options(-widget) d;gpWidget}
      entry       {set options(-widget) e;gpWidget}
      goto        {gpGoto}
      grid        {gpGrid}
      layout      {gpLayout}
      line        {gpLine}
      link        {set options(-widget) l;gpWidget}
      menu        {gpMenu}
      menubutton  {set options(-widget) m;gpWidget}
      notebook    {gpNotebook}
      optionset   {gpOptionset}
      pack        {gpPack}
      pane        {gpPane}
      radiobutton {set options(-widget) r;gpWidget}
      set         {gpSet}
      spinbox     {set options(-widget) s;gpWidget}
      tablelist   {gpTablelist}
      text        {gpText}
      tree        {gpTree}
      widget      {gpWidget}
      window      {gpWindow}
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpWidget                                         #
# PURPOSE: Create widget grid.                                          #
#=======================================================================#

proc ::gridplus::gpWidget {} {
   upvar 1 options globaloptions

   array set options [array get globaloptions]

   global {}

   variable gpConfig
   variable gpInfo
   variable gpValidation
   variable gpValidations

   if {$options(-fixed) eq ""} {
      set defaultFixed $options(-width)
   } else {
      set defaultFixed $options(-fixed)
   }

   if {$options(-basename) eq ""} {
      set basename $options(name)
   } else {
      set basename $options(-basename)
   }

   set defaultWidget [string range $options(-widget) 0 0]
   set gridData      {}
   set rowCount      0
   set widgetID      1

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   foreach row [split $options(layout) "\n"] {
      set columnCount 0
      foreach column $row {
         set action           0
         set createWidget     0
         set errorMessage     {}
         set fixed            $defaultFixed
         set gridColumn       {}
         set itemFixed        {}
         set itemWidth        {}
         set state            $options(-state)
         set style            $options(-style)
         set widget           $defaultWidget
         set widgetHelp       {}
         set widgetOptions    [dict create widget options]
         set width            $options(-width)

         if {$options(-autogroup) ne ""} {}

         set column [::gridplus::gpDefineWidget      $column]
         set column [::gridplus::gpParseEmbeddedGrid $column]

         foreach item $column {
            switch -regexp -- $item {
               
               ^[&]=[a-zA-Z] {
                  set widget       "="
                  set userWidget   [string range $item 2 2]
                  set widgetLayout [lrange $item 2 end]
                  regexp {^[&]=[^: ]+:([^ ]*)} $item -> style
               }
               ^[&] {
                  set widgetLayout [lrange $item 1 end]
                  if {! [regexp {^[&]([^: ]+):([^ ]*)} $item -> widget style]} {
                     set widget [lindex [string range $item 1 end] 0]
                  }
                  if {$widget eq "&" && $style eq ""} {
                     set style "{}"
                  }
                  if {$widget eq "d"} {
                     set state readonly
                  }
               }
               ^[.] {
                  set createWidget 1
                  if {[regexp -- {(^[.]$)|(^[.]:)} $item]} {
                     if {$widget eq "&"} {
                        regsub -- {[.]} $item $options(name)-$widgetID item
                     } else {
                        regsub -- {[.]} $item [regsub -- {([^.]+)[.]} $options(name)-$widgetID {\1_-_}] item
                     }
                     incr widgetID
                  }
                  if {! [regexp {(^[^:]+)(:[nsewc]+$)} $item -> item sticky]} {set sticky {}}
                  if {$widget in "g &"} {
                     set widgetName $item
                  } else {
                     set widgetName $basename,[string range $item 1 end]
                  }
                  if {$options(-autogroup) ne ""} {dict set widgetOptions > "::gridplus::gpAutoGroup $widgetName $options(-autogroup) normal"}
                  if {$options(-group)     ne ""} {set gpInfo($widgetName:group) $options(-group)}
                  lappend gridColumn $widgetName$sticky
               }
               ^: {
                  dict set widgetOptions : [string range $item 1 end]
                  if {$widget in "b m"} {
                     if {! $createWidget} {
                        set createWidget 1
                        set widgetName   $options(name),[= $widgetOptions :]
                        if {$options(-group) ne ""} {set gpInfo($widgetName:group) $options(-group)}  
                        lappend gridColumn $widgetName
                     }
                  } elseif {! $createWidget && $widget ne "l"} {
                     lappend gridColumn $item%%
                  }
               }
               ^[0-9]+$ {
                  set width $item
               }
               ^([0-9]*)/([0-9]*)$ {
                  regexp -- {^([0-9]*)/([0-9]*)$} $item -> itemWidth itemFixed
                  if {$itemWidth eq ""} {
                     set width $options(-width)
                  } else {
                     set width $itemWidth
                  }
                  if {$itemFixed eq ""} {
                     set fixed $width
                  } else {
                     set fixed $itemFixed
                  }
               }
               ^@ {
                  set gridName .[string range $item 1 end]
                  lappend gridColumn $gridName
               }
               ^% {
                  set gpInfo($widgetName:group) [string range $item 1 end]
               }
               ^[-+*~!] {
                  dict set widgetOptions [string range $item 0 0] [string range $item 1 end]
               }
               ^[?] {
                  set widgetHelp [mc [string range $item 1 end]]
               }
               ^[|]$ {
                  lappend gridColumn $item
               }
               ^[=]$ {
                  lappend gridColumn $item
               }
               ^[=].+ {
                  dict set widgetOptions = [string range $item 1 end]
               }
               ^<$ {
                  set state disabled
               }
               ^>$ {
                  set state normal
               }
               ^<.+ {
                  ::gridplus::gridplus set -group [string range $item 1 end] -state normal
                  dict set widgetOptions < "::gridplus::gpAutoGroup $widgetName [string range $item 1 end] disabled"
               }
               ^>.+ {
                  ::gridplus::gridplus set -group [string range $item 1 end] -state disabled
                  dict set widgetOptions > "::gridplus::gpAutoGroup $widgetName [string range $item 1 end] normal"
               }
               ^[#].* {
                  set style [string range $item 1 end]
               }
               default {
                  if {$widget in "b l m"} {
                     if {[llength $column] > 1} {
                        dict set widgetOptions text [mc $item]
                     } else {
                        lappend gridColumn $item
                     }
                  } else {
                     lappend gridColumn $item
                  }
               }
            }
         }

         switch -glob -- $widget {
            [cbdDelmrs] {
               #---------------#
               # Create widget #
               #---------------#
               if {$createWidget} {
                  ::gridplus::widget:$widget $widgetName $window $basename $style $width $fixed [=% $widgetName $state] $widgetOptions
               }
            }
            [=] {
               #----------------------------#
               # Create user defined widget #
               #----------------------------#
               if {$createWidget} {
                  ::gridplus::widget:=$userWidget $widgetName $window $basename $style $width $fixed [=% $widgetName $state] $widgetOptions
               }
            }
            & {
               #-------------------------------#
               # Create embedded "widget" grid #
               #-------------------------------#
               set stretch       [lindex $widgetLayout 0]
               set widgetWidget  [lindex $widgetLayout 1]
               set widgetStyle   [lindex $widgetLayout 2]
               set widgetLayout  [lrange $widgetLayout 3 end]
               if {$widgetStyle ne ""} {
                  if {$widgetStyle eq "%"} {
                     set style "{}"
                  } else {
                     set style $widgetStyle
                  }
               }
               set widgetCommand "::gridplus::gridplus widget $widgetName -basename $basename -borderwidth 0 -spacestretch [list $stretch] -pad 0 -padding {0 0 0 0} -style $style  -widget $widgetWidget [list $widgetLayout]"
               eval $widgetCommand
            }
         }
         
         if {$widgetHelp ne ""} {
            if {$widgetHelp eq "!"} {
               set widgetHelp [::gridplus::gpValidateText [= $widgetOptions !]]
            }
            gpWidgetHelpInit $widgetName $widgetHelp
         }

         lappend gridData $gridColumn
         incr columnCount
      }
      lappend gridData !!!!
      incr rowCount
   }

   regsub -all {!!!!} $gridData \n gridData 

   set gridCommand "::gridplus::gridplus grid $options(name)"

   foreach option [array names options -*] {
      set gridCommand "$gridCommand $option {$options($option)}"
   }

   set gridCommand "$gridCommand {$gridData}"

   eval $gridCommand
}

#=======================================================================#
# PROC   : ::gridplus::widget:b                                         #
# PURPOSE: Create button widget.                                        #
#=======================================================================#

proc ::gridplus::widget:b {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   variable gpInfo

   set command [= $widgetOptions ~]
   set icon    [= $widgetOptions :]
   set text    [= $widgetOptions text]
   
   set gpInfo($name:validationmode) force
   set doValidation                 $options(-validate)
   
   if {[=? $widgetOptions !]} {
      set doValidation 1
      if {[= $widgetOptions !] eq "+" } {
         set gpInfo($name:validationmode) focus
      }
   }
  
   if {$command ne ""} {
      set buttonCommand $command
   } else {
      if {[regexp -- {^([^=]*)=(.*)$} $name -> buttonCommand buttonParameter]} {
         set buttonCommand "$buttonCommand $buttonParameter"
      } else {
         set buttonCommand "$name"
      }
   }

   if {$options(-proc)} {
      set command "set gridplus::gpInfo(<gpFocus>) \[focus\];gpProc [::gridplus::gpCommandFormat $buttonCommand]"
   } else {
      set command "set gridplus::gpInfo(<gpFocus>) \[focus\];$options(-prefix)[::gridplus::gpCommandFormat $buttonCommand]"
   }

   if {$icon ne ""} {
      if {$text eq ""} {
         ::ttk::button $name -command "::gridplus::gpCommand {$command} .$window $doValidation" -image [=: $icon] -state $state -style $style -takefocus $options(-takefocus)
      } else {
         ::ttk::button $name -command "::gridplus::gpCommand {$command} .$window $doValidation" -image [=: $icon] -state $state -style $style -takefocus $options(-takefocus) -text $text -width $width -compound $options(-compound)
      }
   } else {
      ::ttk::button $name -command "::gridplus::gpCommand {$command} .$window $doValidation" -state $state -style $style -takefocus $options(-takefocus) -text $text -width $width
   }
   
   if {$state eq "disabled"} {$name configure -takefocus 0}

   if {[=? $widgetOptions +]} {focus $name}
   
   bind $name <Return> "$name invoke"
}

#=======================================================================#
# PROC   : ::gridplus::widget:c                                         #
# PURPOSE: Create checkbutton widget.                                   #
#=======================================================================#

proc ::gridplus::widget:c {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   global {}

   set command [= $widgetOptions ~]
   set ($name) [= $widgetOptions = [=@ $name 0]]

   set options(-checkbuttoncommand) [::gridplus::gpOptionAlias -checkbuttoncommand -ccmd]
   
   ::ttk::checkbutton $name -offvalue 0 -onvalue 1 -state $state -style $style -takefocus $options(-takefocus) -variable ($name)

   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }

   if {[=? $widgetOptions +]} {
      set ($name) 0
      $name invoke
   }

   if {[=? $widgetOptions ~]} {
      if {$command eq ""} {
         set command $name
      }
      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }
      $name configure -command $command
   } elseif {$options(-checkbuttoncommand) ne ""} {
      if {$options(-proc)} {
         set command "gpProc $options(-checkbuttoncommand)"
      } else {
         set command "$options(-prefix)$options(-checkbuttoncommand)"
      }
      $name configure -command $command
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:d                                         #
# PURPOSE: Create dropdown widget.                                      #
#=======================================================================#

proc ::gridplus::widget:d {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   global {}

   set command [= $widgetOptions ~]
   set values  [= $widgetOptions +]
   set ($name) [= $widgetOptions = [=@ $name [lindex [= $widgetOptions +] 0]]]

   set options(-dropdowncommand) [::gridplus::gpOptionAlias -dropdowncommand -dcmd]

   ::ttk::combobox $name -state $state -style $style -takefocus $options(-takefocus) -textvariable ($name) -values $values -width $width

   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }
 
   if {[=? $widgetOptions ~]} {
      if {$command eq ""} {
         set command $name
      }
      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }
      bind $name <<ComboboxSelected>> $command
   } elseif {$options(-dropdowncommand) ne ""} {
      if {$options(-proc)} {
         set command "gpProc $options(-dropdowncommand)"
      } else {
         set command "$options(-prefix)$options(-dropdowncommand)"
      }
      bind $name <<ComboboxSelected>> "$command"
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:D                                         #
# PURPOSE: Create dateselector widget.                                  #
#=======================================================================#

proc ::gridplus::widget:D {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   variable gpInfo

   global {}

   set command [= $widgetOptions ~]
   set ($name) [::gridplus::gpdate [= $widgetOptions = [=@ $name]]]
   
   if {$state eq "normal"} {
      set state readonly
   }

   set options(-datecommand) [::gridplus::gpOptionAlias -datecommand -Dcmd]

   if {[=< dateIcon] ne ""} {
      if {"GridplusDate.downarrow" ni [ttk::style element names]} {
         set normalIcon   [=: [=< dateIcon]]
         set disabledIcon [image create photo]
         
         ::ttk::combobox .gpComboboxHeight
         set height [winfo reqheight .gpComboboxHeight]
         destroy .gpComboboxHeight
         
         $disabledIcon copy $normalIcon
         $disabledIcon configure -palette 16 -gamma 1.5
      
         ::ttk::style element create GridplusDate.downarrow image [list $normalIcon disabled $disabledIcon] -height $height -sticky e

         ::ttk::style layout GridplusDate.TCombobox { 
            Combobox.field -sticky nswe -children { 
               GridplusDate.downarrow -side right -sticky ns 
               Combobox.padding -expand 1 -sticky nswe -children { 
                  Combobox.textarea -sticky nswe 
              } 
           } 
         } 
      }
      
      set style "GridplusDate.TCombobox"
   }

   ::ttk::combobox $name -state $state -style $style -takefocus $options(-takefocus) -textvariable ($name) -width $width

   bind $name <KeyPress-Down>   "::gridplus::gpDateSelectorKeyPress $name %W post"
   bind $name <KeyPress-Escape> "::gridplus::gpDateSelectorKeyPress $name %W unpost"
   bind $name <ButtonPress-1>   "::gridplus::gpDateSelectorToggle $name %W"
   bind $name <FocusIn>         "$name selection range 0 end"
   bind $name <Button-3>        "::gridplus::gpEntryEdit {} %X %Y"

   if {$options(-dateclear)} {
      bind $name <KeyPress-Delete> "::gridplus::gpDateSelectorClear $name %K"
   }

   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }

   set gpInfo($name:datecommand) {}

   if {[=? $widgetOptions ~]} {
      if {$command eq ""} {
         set gpInfo($name:datecommand) $name
      }
      if {$options(-proc)} {
         set gpInfo($name:datecommand) "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set gpInfo($name:datecommand) "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }
   } elseif {$options(-datecommand) ne ""} {
      if {$options(-proc)} {
         set gpInfo($name:datecommand) "gpProc $options(-datecommand)"
      } else {
         set gpInfo($name:datecommand) "$options(-prefix)$options(-datecommand)"
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:e                                         #
# PURPOSE: Create entry widget.                                         #
#=======================================================================#

proc ::gridplus::widget:e {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   variable gpInfo
   variable gpValidations

   global {}

   set autoGroupCommand [= $widgetOptions > [= $widgetOptions <]]
   set command          [= $widgetOptions ~ $name]
   set validation       [= $widgetOptions !]
   set ($name)          [= $widgetOptions = [=@ $name]]
   
   set options(-entrycommand) [::gridplus::gpOptionAlias -entrycommand -ecmd]

   if {$state eq "disabled"} {
      set state [=< entryDisabled readonly]
   }

   if {[=? $widgetOptions !]} {
      set doValidation 1
      lappend gpValidations(.$window) $name:$validation
   } else {
      set doValidation 0
   }

   if {$validation eq ""} {
      set validation "__gpFixed__"
   } else {
      ::gridplus::gpValidateErrorInit $name [::gridplus::gpValidateText $validation]
   }

   ::ttk::entry $name -invalidcommand "::gridplus::gpValidateFailed %W" -state $state -style $style -takefocus $options(-takefocus) -textvariable ($name) -validate all -validatecommand "::gridplus::gpValidate %W \"$validation\" %V %P $fixed $options(-validateauto)" -width $width

   if {$state eq "disabled"} {
      $name configure -background lightgray -takefocus 0
   }

   if {[=? $widgetOptions ~]} {
      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }
      if {[string match <*> $command]} {
         bind $name <Return> "event generate $name $command"
      } elseif {[string match "<*> *" $command]} {
         regsub -all {:} $command "." command
         bind $name <Return> "event generate [lindex $command 1] [lindex $command 0]"
      } else {
         bind $name <Return> "::gridplus::gpCommand {$command} .$window $doValidation"
      }
   } elseif {$options(-entrycommand) ne ""} {
      if {$options(-proc)} {
         set command "gpProc $options(-entrycommand)"
      } else {
         set command "$options(-prefix)$options(-entrycommand)"
      }
      if {[string match <*> $command]} {
         bind $name <Return> "event generate $name $command"
      } elseif {[string match "<*> *" $command]} {
         regsub -all {:} $command "." command
         bind $name <Return> "event generate [lindex $command 1] [lindex $command 0]"
      } else {
         bind $name <Return> "::gridplus::gpCommand {$command} .$window $doValidation"
      }
   }
   
   if {$autoGroupCommand ne ""} {
      trace add variable ($name) write $autoGroupCommand
   }
   
   if {$options(-validatepopup) && $validation ne "__gpFixed__"} {
      ::gridplus::gpValidateErrorInit $name [::gridplus::gpValidateText $validation] popup
   }
   
   if {[=? $widgetOptions *]} {$name configure -show "*"}
   if {[=? $widgetOptions +]} {focus $name}

   bind $name <Button-3> "::gridplus::gpEntryEdit {$window} %X %Y"
}

#=======================================================================#
# PROC   : ::gridplus::widget:l                                         #
# PURPOSE: Create link widget.                                          #
#=======================================================================#

proc ::gridplus::widget:l {name window basename style width fixed state widgetOptions} {
   upvar 1 options options
 
   set command [= $widgetOptions ~ $name]
   set icon    [= $widgetOptions :]
   set text    [= $widgetOptions text]
 
   foreach {normalColor overColor} [split $options(-linkcolor) /] {}
   foreach {normalStyle overStyle} [split $options(-linkstyle) /] {}

   regsub      -- {[&]} $overStyle   $normalStyle, overStyle
   regsub -all -- {,}   $normalStyle { }           normalStyle
   regsub -all -- {,}   $overStyle   { }           overStyle

   if {! [string match */* $options(-linkcolor)]} {set overColor $normalColor}

   if {$normalColor eq ""} {set normalColor "black"}
   if {$overColor   eq ""} {set overColor   "black"}
 
   if {[=? $widgetOptions !]} {
      set doValidation 1
   } else {
      set doValidation 0
   }
 
   if {[=? $widgetOptions -]} {
      set indent "   "
   } elseif {[=? $widgetOptions +]} {
      set indent "\u2022  "
   } else {
      set indent ""
   }
 
   if {$options(-proc)} {
      set linkCommand "set gridplus::gpInfo(<gpFocus>) \[focus\];gpProc [::gridplus::gpCommandFormat $command]"
   } else {
      set linkCommand "set gridplus::gpInfo(<gpFocus>) \[focus\];$options(-prefix)[::gridplus::gpCommandFormat $command]"
   }
 
   ::ttk::frame $name
   ::ttk::label $name.link -background $options(-background) -foreground $options(-foreground) -text [mc $text]
 
   set normalFont [::gridplus::gpSetFont $normalStyle]
   set overFont   [::gridplus::gpSetFont $overStyle]

   $name.link configure -font $normalFont -foreground $normalColor

   bind $name.link <Enter>           "$name.link configure -font {$overFont} -foreground $overColor -cursor $options(-linkcursor)"
   bind $name.link <Leave>           "$name.link configure -font {$normalFont} -foreground $normalColor -cursor {}"
   bind $name.link <ButtonRelease-1> "eval \"::gridplus::gpCommand {$linkCommand} .$window $doValidation\""
   
   if {[=? $widgetOptions :]} {
      if {$icon eq ""} {set icon $options(-icon)}
      ::ttk::label $name.icon -image [=: $icon]
      bind $name.icon <Enter>           "$name.icon configure -cursor $options(-linkcursor)"
      bind $name.icon <Leave>           "$name.icon configure -cursor {}"
      bind $name.icon <ButtonRelease-1> "eval \"::gridplus::gpCommand {$linkCommand} .$window $doValidation\""
      grid $name.icon $name.link
   } else {
      ::ttk::label $name.indent -background $options(-background) -foreground $options(-foreground) -text $indent
      grid $name.indent $name.link
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:m                                         #
# PURPOSE: Create menubutton widget.                                    #
#=======================================================================#

proc ::gridplus::widget:m {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   set icon [= $widgetOptions :]
   set text [= $widgetOptions text]

   set menu "$name:menu"

   if {$icon ne ""} {
      if {$text eq ""} {
         ::ttk::menubutton $name -menu $menu -image [=: $icon] -state $state -style $style -takefocus $options(-takefocus)
      } else {
         ::ttk::menubutton $name -menu $menu -image [=: $icon] -state $state -style $style -takefocus $options(-takefocus) -text $text -width $width -compound $options(-compound)
      }
   } else {
      ::ttk::menubutton $name -menu $menu -state $state -style $style -takefocus $options(-takefocus) -text $text -width $width
   }
   
   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:r                                         #
# PURPOSE: Create radiobutton widget.                                   #
#=======================================================================#

proc ::gridplus::widget:r {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   variable gpInfo

   global {}

   set command [= $widgetOptions ~]
   set group   [= $widgetOptions *]
   set value   [= $widgetOptions + [= $widgetOptions -]]

   if {[=? $widgetOptions *]} {
      set group ",$group"
   } else {
      set group {}
   }
   if {$basename eq ""} {
      set variable "$options(name)$group"
      if {$group ne ""} {set gpInfo($options(name):radiobuttonGroups) [lappend gpInfo($options(name):radiobuttonGroups) $group]}
   } else {
      set variable "$basename$group"
      if {$group ne ""} {set gpInfo($basename:radiobuttonGroups) [lappend gpInfo($basename:radiobuttonGroups) $group]}
   }

   set ($variable) {}

   set options(-radiobuttoncommand) [::gridplus::gpOptionAlias -radiobuttoncommand -rcmd]

   ::ttk::radiobutton $name -state $state -style $style -takefocus $options(-takefocus) -value $value -variable ($variable)

   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }

   if {[=? $widgetOptions +] || [=@ $variable] eq $value} {
      after idle $name invoke
   }

   if {[=? $widgetOptions ~]} {
      if {$command eq ""} {
         set command $name
      }
      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }
      $name configure -command $command
   } elseif {$options(-radiobuttoncommand) ne ""} {
      if {$options(-proc)} {
         set command "gpProc $options(-radiobuttoncommand)"
      } else {
         set command "$options(-prefix)$options(-radiobuttoncommand)"
      }
      $name configure -command $command
   }
}

#=======================================================================#
# PROC   : ::gridplus::widget:s                                         #
# PURPOSE: Create spinbox widget.                                       #
#=======================================================================#

proc ::gridplus::widget:s {name window basename style width fixed state widgetOptions} {
   upvar 1 options options

   variable gpInfo

   global {}

   set value   [= $widgetOptions +]
   set ($name) [= $widgetOptions = [=@ $name]]
   
   if {$state eq "normal"} {
      set state readonly
   }
   
   set from      {}
   set to        {}
   set increment {}
   set format    {}
                  
   if {[string match */* $value]} {
      foreach {from to increment format} [split $value /] {}
                  
      if {$from eq ""} {
         if {$options(-from) eq ""} {
            error "GRIDPLUS ERROR: 'From' value not specified for spinbox '$name'."
         } else {
            set from $options(-from)
         }
      }
      if {$to eq ""} {
         if {$options(-to) eq ""} {
            error "GRIDPLUS ERROR: 'To' value not specified for spinbox '$name'."
         } else {
            set to $options(-to)
         }
      }
      if {$increment eq ""} {
         if {$options(-increment) eq ""} {
            error "GRIDPLUS ERROR: 'Increment' value not specified for spinbox '$name'."
         } else {
            set increment $options(-increment)
         }
      }
      if {$format eq ""} {
         set format $options(-spinformat)
      }
 
      if {$($name) eq ""} {
         set ($name) $from
      }
      
      ::ttk::spinbox $name -state $state -style $style -takefocus $options(-takefocus) -textvariable ($name) -from $from -to $to -increment $increment -format $format -width $width
   } else {
      if {$($name) eq ""} {
         set ($name) [lindex $value 0]
      }
      
      ::ttk::spinbox $name -state $state -style $style -takefocus $options(-takefocus) -textvariable ($name) -values $value -width $width
   }
   
   if {$state eq "disabled"} {
      $name configure -takefocus 0
   }
   
   bind $name <Button-3> "::gridplus::gpEntryEdit {$window} %X %Y"
}

#=======================================================================#
# PROC   : ::gridplus::gpAdd                                            #
# PURPOSE: Add non-gridplus widget to group.                            #
#=======================================================================#

proc ::gridplus::gpAdd {} {
   upvar 1 options options

   variable gpInfo
   
   set gpInfo($options(name):group) $options(-group)
}

#=======================================================================#
# PROC   : ::gridplus::gpAutoGroup                                      #
# PURPOSE: Set group state when entry has been updated.                 #
#=======================================================================#

proc ::gridplus::gpAutoGroup {name group state args} {

   global {}  

   trace remove variable ($name) write "::gridplus::gpAutoGroup $name $group $state"

   ::gridplus::gridplus set -group $group -state $state
}

#=======================================================================#
# PROCS  : ::gridplus::gpWidgetHelpInit                                 #
#        : ::gridplus::gpWidgetHelpDelay                                #
#        : ::gridplus::gpWidgetHelpCancel                               #
#        : ::gridplus::gpWidgetHelpShow                                 #
# PURPOSE: Gridplus widget help.                                        #
#=======================================================================#

proc ::gridplus::gpWidgetHelpInit {item message} {
   variable gpWidgetHelp 

   if {! [winfo exists .gpWidgetHelp]} {
      toplevel .gpWidgetHelp -background black -borderwidth 1 -relief flat
      label    .gpWidgetHelp.message -background lightyellow
      pack     .gpWidgetHelp.message
      wm overrideredirect .gpWidgetHelp 1
      wm withdraw         .gpWidgetHelp
   }

   set gpWidgetHelp($item) $message
   bind $item <Enter> {::gridplus::gpWidgetHelpDelay %W}
   bind $item <Leave> {::gridplus::gpWidgetHelpCancel}
}

proc ::gridplus::gpWidgetHelpDelay {item} {
   variable gpWidgetHelp
 
   gpWidgetHelpCancel
   set gpWidgetHelp(delay) [after 300 [list ::gridplus::gpWidgetHelpShow $item]]
}

proc ::gridplus::gpWidgetHelpCancel {} {
   variable gpWidgetHelp
 
   if {[info exists gpWidgetHelp(delay)]} {
      after cancel $gpWidgetHelp(delay)
      unset gpWidgetHelp(delay)
   }

   if {[info exists gpWidgetHelp(show)]} {
      after cancel $gpWidgetHelp(show)
      unset gpWidgetHelp(show)
   }

   if {[winfo exists .gpWidgetHelp]} {
      wm withdraw .gpWidgetHelp
   }
}

proc ::gridplus::gpWidgetHelpShow {item} {
   variable gpWidgetHelp
 
   .gpWidgetHelp.message configure -text $gpWidgetHelp($item)
 
   set screenWidth [lindex [wm maxsize .] 0]
   set helpWidth   [winfo width .gpWidgetHelp]
   set helpX       [winfo pointerx $item]
   set helpY       [expr [winfo rooty $item] + [winfo height $item]]
 
   if {[expr {$helpX + $helpWidth}] > $screenWidth} {
      set helpX [expr {$screenWidth - $helpWidth - 8}]
   }
 
   wm geometry  .gpWidgetHelp +$helpX+$helpY
   wm deiconify .gpWidgetHelp
 
   raise .gpWidgetHelp
 
   unset gpWidgetHelp(delay)

   set gpWidgetHelp(show) [after [=< helpDisplayTime 2500] ::gridplus::gpWidgetHelpCancel]
}

#=======================================================================#
# PROC   : ::gridplus::gpCalendar                                       #
# PURPOSE: Create calendar.                                             #
#=======================================================================#

proc ::gridplus::gpCalendar {} {
   upvar 1 options options

   global {}

   variable gpInfo

   set columnWidth 3

   set gpInfo($options(name):fg)          [lindex [split $options(-calcolor) "/"] 0]
   set gpInfo($options(name):bg)          [lindex [split $options(-calcolor) "/"] 1]
   set gpInfo($options(name):selectfg)    [lindex [split $options(-calselectcolor) "/"] 0]
   set gpInfo($options(name):selectbg)    [lindex [split $options(-calselectcolor) "/"] 1]
   set gpInfo($options(name):command)     $options(-command)
   set gpInfo($options(name):navcommand)  $options(-navcommand)
   set gpInfo($options(name):navselect)   $options(-navselect)
   set gpInfo($options(name):variable)    $options(-variable)
   set gpInfo($options(name):selecttoday) $options(-selecttoday)
   set gpInfo($options(name):weekstart)   $options(-weekstart)

   if {$options(-date) eq ""} {
      foreach {month day year} [clock format [clock seconds] -format "%m %d %Y"] {}
   } else {
      foreach {month day year} [::gridplus::gpFormatDate $options(-date) internal] {}
      if {! [::gridplus::gpCalCheckDate $month $day $year]} {
         error "GRIDPLUS ERROR: (gridplus calendar) $options(-date) is not a valid date."
      }
   }
   
   ::gridplus::gpLabelframe

   frame $options(name).calendar        -bg $gpInfo($options(name):bg) -relief $options(-calrelief) -borderwidth 2
   frame $options(name).calendar.header -bg $gpInfo($options(name):bg)

   label $options(name).calendar.header.month -text "" -font [::gridplus::gpSetFont {+2 bold}] -bg $gpInfo($options(name):bg) -fg $gpInfo($options(name):fg) -padx 0
   label $options(name).calendar.header.year  -text "" -font [::gridplus::gpSetFont {+2 bold}] -bg $gpInfo($options(name):bg) -fg $gpInfo($options(name):fg) -padx 0

   pack  $options(name).calendar.header.month -side left  -anchor w
   pack  $options(name).calendar.header.year  -side right -anchor e

   grid $options(name).calendar.header -columnspan 7 -sticky ew

   if {$options(-navbar)} {
      frame $options(name).calendar.navbar        -bg $gpInfo($options(name):bg)
      frame $options(name).calendar.navbar.left   -bg $gpInfo($options(name):bg)
      frame $options(name).calendar.navbar.centre -bg $gpInfo($options(name):bg)
      frame $options(name).calendar.navbar.right  -bg $gpInfo($options(name):bg)

      ttk::label $options(name).calendar.navbar.left.navbackyear  -image gpcal-prev-year -background $gpInfo($options(name):bg)
      pack $options(name).calendar.navbar.left.navbackyear  -side left
      bind $options(name).calendar.navbar.left.navbackyear <ButtonRelease-1> "::gridplus::gpCalendarNav $options(name) year -1"

      ttk::label $options(name).calendar.navbar.right.navnextyear -image gpcal-next-year -background $gpInfo($options(name):bg)
      pack $options(name).calendar.navbar.right.navnextyear -side right
      bind $options(name).calendar.navbar.right.navnextyear <ButtonRelease-1> "::gridplus::gpCalendarNav $options(name) year +1"

      ttk::label $options(name).calendar.navbar.centre.current -image gpcal-today -background $gpInfo($options(name):bg)
      pack $options(name).calendar.navbar.centre.current
      bind $options(name).calendar.navbar.centre.current <ButtonRelease-1> "::gridplus::gpCalendarNav $options(name) current"

      ttk::label $options(name).calendar.navbar.left.navbackmonth  -image gpcal-prev-month -background $gpInfo($options(name):bg)
      pack $options(name).calendar.navbar.left.navbackmonth  -side left
      bind $options(name).calendar.navbar.left.navbackmonth <ButtonRelease-1> "::gridplus::gpCalendarNav $options(name) month -1"

      ttk::label $options(name).calendar.navbar.right.navnextmonth -image gpcal-next-month -background $gpInfo($options(name):bg)
      pack $options(name).calendar.navbar.right.navnextmonth -side right
      bind $options(name).calendar.navbar.right.navnextmonth <ButtonRelease-1> "::gridplus::gpCalendarNav $options(name) month +1"

      pack $options(name).calendar.navbar.left   -side left
      pack $options(name).calendar.navbar.centre -side left -expand 1 -fill x
      pack $options(name).calendar.navbar.right  -side right

      grid $options(name).calendar.navbar -columnspan 7 -sticky ew
   }

   set rowData ""

   foreach dayName [::gridplus::gpCalDayNames $options(-weekstart)] {
      label $options(name).calendar.days:$dayName -text $dayName -borderwidth 1 -width $columnWidth -font [::gridplus::gpSetFont bold] -bg $gpInfo($options(name):bg) -fg $gpInfo($options(name):fg)
      set   rowData "$rowData $options(name).calendar.days:$dayName"
   }

   grid {*}$rowData -sticky e

   for {set row 1} {$row < 7} {incr row} {
      set rowData ""
      for {set column 1} {$column < 8} {incr column} {
         label $options(name).calendar.$row:$column -text "" -borderwidth 1 -width 3 -fg $gpInfo($options(name):fg) -bg $gpInfo($options(name):bg)
         set   rowData "$rowData $options(name).calendar.$row:$column"
      }
      grid {*}$rowData -sticky e
   }

   grid columnconfigure $options(name) "all" -uniform allTheSame

   foreach child [winfo children $options(name).calendar] {
      bind $child <ButtonRelease-1> "::gridplus::gpCalendarSelect $options(name) %W"
   }

   if {$options(-variable) ne ""} {
      set ($options(-variable)) ""
   } else {
      set ($options(name)) ""
   }

   pack $options(name).calendar

   ::gridplus::gpCalendarDisplay $options(name) $day $month $year
}

#=======================================================================#
# PROC   : ::gridplus::gpCalendarDisplay                                #
# PURPOSE: Display calendar for specified month.                        #
#=======================================================================#

proc ::gridplus::gpCalendarDisplay {name day month year} {

   global {}

   variable gpConfig
   variable gpInfo

   if {[info exists gpInfo($name:selected)] && $gpInfo($name:selected) ne ""} {
      $gpInfo($name:selected) configure -bg $gpInfo($name:bg) -fg $gpInfo($name:fg)
   }

   foreach {currentDay currentMonth currentYear} [clock format [clock seconds] -format "%d %m %Y"] {}

   if {$month eq $currentMonth && $year eq $currentYear} {
      set current 1
   } else {
      set current 0
   }

   if {[info exists gpInfo($name:selectedmonth)] && $month eq $gpInfo($name:selectedmonth) && $year eq $gpInfo($name:selectedyear)} {
      set selected 1
   } else {
      set selected 0
   }

   foreach {monthName startDay} [clock format [clock scan 01/$month/$year -format %d/%m/%Y] -format "%B %u" -locale $gpConfig(locale)] {}

   if {$gpInfo($name:weekstart) == 0} {
      set startColumn [expr {$startDay + 1}]
      if {$startColumn == 8} {
         set startColumn 1
      }
   } else {
      set startColumn $startDay
   }

   $name.calendar.header.month configure -text $monthName
   $name.calendar.header.year  configure -text $year

   set output    0
   set outputDay 1

   set gpInfo($name:displaymonth) $month
   set gpInfo($name:displayyear)  $year

   for {set row 1} {$row < 7} {incr row} {
      set rowData ""
      for {set column 1} {$column < 8} {incr column} {
         if {$row == 1} {
            if {$column == $startColumn} {
               set output 1
            }
         }

         if {$outputDay > [::gridplus::gpCalMonthDays $month $year]} {
            set output 0
         }

         if {$output} {
            $name.calendar.$row:$column configure -text $outputDay -relief flat

            if {$current && [format %02d $outputDay] eq $currentDay} {
               $name.calendar.$row:$column configure -relief solid
            }

            if {$gpInfo($name:selecttoday) && [format %02d $outputDay] eq $day} {
                  ::gridplus::gpCalendarSelect $name $name.calendar.$row:$column -displayonly
            }

            if {$selected && [format %02d $outputDay] eq $gpInfo($name:selectedday)} {
               $name.calendar.$row:$column configure -bg $gpInfo($name:selectbg) -fg $gpInfo($name:selectfg)
            }
            incr outputDay
         } else {
            $name.calendar.$row:$column configure -text "" -relief flat
         }
      }
   }

   set gpInfo($name:selecttoday) 0
}

#=======================================================================#
# PROC   : ::gridplus::gpCalendarNav                                    #
# PURPOSE: Calendar navigation.                                         #
#=======================================================================#

proc ::gridplus::gpCalendarNav {name unit {increment {}}} {

   global {}

   variable gpInfo

   if {$unit eq "current"} {
      if {$increment eq ""} {
         foreach {month year} [clock format [clock seconds] -format "%m %Y"] {}
      } else {
         foreach {month year} [clock format [clock add [clock seconds] $increment month] -format "%m %Y"] {}
      }
   } else {
      set month $gpInfo($name:displaymonth)
      set year  $gpInfo($name:displayyear)
      foreach {month year} [clock format [clock add [clock scan 01/$gpInfo($name:displaymonth)/$gpInfo($name:displayyear) -format "%d/%m/%Y"] $increment $unit] -format "%m %Y"] {}
   }

   ::gridplus::gpCalendarDisplay $name {} $month $year

   if {$gpInfo($name:navselect)} {
      if {$gpInfo($name:variable) ne ""} {
         set variable $gpInfo($name:variable)
      } else {
         set variable $name
      }

      if {$($variable) ne ""} {
         foreach {varMonth varDay varYear} [::gridplus::gpFormatDate $($variable) internal] {}
         if {$month eq $varMonth && $year eq $varYear} {
            ::gridplus::gpselect $name $($variable)
         }
      }
   }

   if {$gpInfo($name:navcommand) ne ""} {
      eval "$gpInfo($name:navcommand) $name $unit $increment"
   }
}


#=======================================================================#
# PROC   : ::gridplus::gpCalendarSelect                                 #
# PURPOSE: Sets value for calendar selection.                           #
#=======================================================================#

proc ::gridplus::gpCalendarSelect {name window {mode {}}} {

   global {}

   variable gpConfig
   variable gpInfo

   if {[winfo class $window] ne "Label" || ! [string is integer -strict [$window cget -text]]} {return}

   if {$gpInfo($name:variable) ne ""} {
      set variable $gpInfo($name:variable)
   } else {
      set variable $name
   }

   if {[info exists gpInfo($name:selected)] && $gpInfo($name:selected) ne ""} {
      $gpInfo($name:selected) configure -bg $gpInfo($name:bg) -fg $gpInfo($name:fg)
   }

   $window configure -bg $gpInfo($name:selectbg) -fg $gpInfo($name:selectfg)

   set gpInfo($name:selected)      $window
   set gpInfo($name:selectedday)   [format %02d [$window cget -text]]
   set gpInfo($name:selectedmonth) $gpInfo($name:displaymonth)
   set gpInfo($name:selectedyear)  $gpInfo($name:displayyear)

   switch -- $gpConfig(dateformat) {
      eu  {set ($variable) "$gpInfo($name:selectedday).$gpInfo($name:selectedmonth).$gpInfo($name:selectedyear)"}
      iso {set ($variable) "$gpInfo($name:selectedyear)-$gpInfo($name:selectedmonth)-$gpInfo($name:selectedday)"}
      uk  {set ($variable) "$gpInfo($name:selectedday)/$gpInfo($name:selectedmonth)/$gpInfo($name:selectedyear)"}
      us  {set ($variable) "$gpInfo($name:selectedmonth)/$gpInfo($name:selectedday)/$gpInfo($name:selectedyear)"}
   }

   if {$mode ne "-displayonly" && $gpInfo($name:command) ne ""} {
      eval $gpInfo($name:command)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpClear                                          #
# PURPOSE: Clear window and unset associated variables.                 #
#=======================================================================#

proc ::gridplus::gpClear {} {
   upvar 1 options options

   global {}

   variable gpWidgetHelp   
   variable gpInfo
   variable gpTabOrder
   variable gpValidateError
   variable gpValidations

   if {$options(name) ne "."} {
      unset -nocomplain gpInfo($options(name):toplevel)
      unset -nocomplain gpInfo($options(name):modal)
   }

   if {[winfo exists $options(name).container]} {
      eval $gpInfo($options(name):wcmd)
      unset -nocomplain gpInfo($options(name):in)
      set gpInfo($options(name):wcmd) {}
      return
   }

   $options(name) configure -menu {}

   unset -nocomplain gpInfo(validation:failed)
   unset -nocomplain gpValidations($options(name))

   if {[winfo exists .gpValidateError]} {
      wm withdraw .gpValidateError
   }

   foreach item [winfo child $options(name)] {
      if {! [winfo exists $item]} {continue}

      set class [winfo class $item]

      if {[regexp -- {^[.]_} $item]} {
         continue
      }

      if {[string match *.gpEditMenu $item]} {
         continue
      }

      if {$class ne "Toplevel"} {         
         if {$options(-variables) && [info exists ($item)]} {
            if {$class eq "Entry"} {
               $item configure -textvariable {}
            }
            unset ($item)
         }
         if {$options(-variables) && [info exists gpInfo($item:radiobuttonGroups)]} {
            foreach radiobuttonGroup $gpInfo($item:radiobuttonGroups) {
              if {[info exists ($item$radiobuttonGroup)]} {
                 unset ($item$radiobuttonGroup)
              }
            }
            unset gpInfo($item:radiobuttonGroups)
         }
         if {[info exists gpWidgetHelp($item)]} {
            unset gpWidgetHelp($item)
         }
         if {[info exists gpInfo($item:wcmd)]} {
            eval $gpInfo($item:wcmd)
         }
         foreach infoItem [array names gpInfo $item:*] {
            unset gpInfo($infoItem)
         }
         foreach tabOrderItem [array names gpTabOrder $item:*] {
            unset gpTabOrder($tabOrderItem)
         }
         foreach validateErrorItem [array names gpValidateError $item:*] {
            unset gpValidateError($validateErrorItem)
         }
         if {$gpInfo(<gpTextFindItem>) eq "$item.text"} {
            if {[winfo exists .gpTextFind]} {
               ::gridplus::gpTextFind:action,cancel
            }
         }
         if {$class eq "Menu"} {
            foreach infoItem [array names gpInfo $item.*:group] {
               unset gpInfo($infoItem)
            }
         }

         destroy $item
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpCommand                                        #
# PURPOSE: Evals command, performing validations if required.           #
#=======================================================================#

proc ::gridplus::gpCommand {command window validate} {

   global {}

   variable gpValidations
   variable gpInfo

   if {$window eq "."} {
      set containers [array names gpInfo -regexp {^[.][^.]+:in$}]
   } else {
      set containers [array names gpInfo -regexp "^$window\[.\]\[^.\]+:in$"]
   }

   set containedWindows {}

   foreach container $containers {
      set containedWindows "$containedWindows $gpInfo($container)"
   }

   if {[info exists gpValidations($window)]} {
      set validations $gpValidations($window)
   } else {
      set validations {}
   }

   foreach containedWindow $containedWindows {
      if {[info exists gpValidations($containedWindow)]} {
         set validations "$validations $gpValidations($containedWindow)"
      }
   }

   if {$validate && $validations ne ""} {
      foreach validationInfo $validations {
         set entry [lindex [split $validationInfo :] 0]
         regexp -- {:(.+)$} $validationInfo -> validation
         if {! [::gridplus::gpValidate $entry $validation focusout - - 1]} {
            ::gridplus::gpValidateFailed $entry
            return
         }
      }
   }

   eval $command
}

#=======================================================================#
# PROC   : ::gridplus::gpCommandFormat                                  #
# PURPOSE: Makes sure "command" is in the correct format.               #
#=======================================================================#

proc ::gridplus::gpCommandFormat {command} {

   set commandProc       [lindex $command 0]
   set commandParameters [lrange $command 1 end]

   regsub -all {[.]} $commandProc ":" commandProc
   regsub      {;:}  $commandProc ";" commandProc
   regsub      {^:}  $commandProc {}  commandProc

   if {[llength $command] eq 1} {
      return $commandProc
   } else {
      return [list $commandProc {*}$commandParameters]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpContainer                                      #
# PURPOSE: Create container for toplevel windows.                       #
#=======================================================================#

proc ::gridplus::gpContainer {} {
   upvar 1 options options

   variable gpInfo

   if {[regexp -- {(^[.][^.]+)[.]} $options(name) -> window]} {
      if {! $gpInfo($window:toplevel)} {
         error "GRIDPLUS ERROR: (gridplus container) $window is a contained toplevel."
      }
   }

   if {$options(-relief) eq "theme"} {
      if {$options(-title) eq ""} {
         ::ttk::labelframe $options(name)  -height $options(-height) -width $options(-width) -padding $options(-padding) 
         ::ttk::separator  $options(name).separator -orient horizontal
         $options(name) configure -labelwidget $options(name).separator -labelanchor s
      } else {
         if {$options(-labelanchor) eq ""} {
            ::ttk::labelframe $options(name) -height $options(-height) -width $options(-width) -padding $options(-padding) -text [mc $options(-title)]
         } else {
            ::ttk::labelframe $options(name) -height $options(-height) -width $options(-width) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
         }
      }  
   } else {
      ::ttk::frame $options(name) -height $options(-height) -width $options(-width) -padding $options(-padding) -relief $options(-relief)
   }

   grid propagate $options(name) 0
   pack propagate $options(name) 0

   set gpInfo($options(name):sticky)    $options(-sticky)
   set gpInfo($options(name):wcmd)      {}

}

#=======================================================================#
# PROC   : ::gridplus::gpCreateIcons                                    #
# PURPOSE: Creates default icons for GRIDPLUS Tree.                     #
#=======================================================================#

proc ::gridplus::gpCreateIcons {} {

   image create photo ::icon::file -data {
      R0lGODlhEAAQAIIAAPwCBFxaXISChPz+/MTCxKSipAAAAAAAACH5BAEAAAAA
      LAAAAAAQABAAAANCCLrcGzBC4UAYOE8XiCdYF1BMJ5ye1HTfNxTBSpy0QMBy
      ++HlXNu8h24X6/2AReHwllRcMtCgs0CtVpsWiRZbqfgTACH+aENyZWF0ZWQg
      YnkgQk1QVG9HSUYgUHJvIHZlcnNpb24gMi41DQqpIERldmVsQ29yIDE5OTcs
      MTk5OC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCmh0dHA6Ly93d3cuZGV2ZWxj
      b3IuY29tADs=
   }

   image create photo ::icon::folder -data {
      R0lGODlhEAAQAIIAAPwCBFxaXMTCxPz+/KSipAAAAAAAAAAAACH5BAEAAAAA
      LAAAAAAQABAAAAM3CLrc/i/IAFcQWFAos56TNYxkOWhKcHossals+64x5qZ0
      fQNwbc++Hy4o2F0IyKTSCGqCKhB/AgAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lG
      IFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCBy
      aWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7
   }

   image create photo gpcal-prev-year -data {
      R0lGODlhCgAFAHcAACH5BAEAAAEALAAAAAAKAAUAhwAAAP//8AAAEQAAEf//9QAAAAAAAAAA
      AAACvAAAAAEbhAzQICcB0AoanwTx9Akz2QTx9Akz5wEbhATyEAkz/gzQIATyjAk/ogAAAAAA
      AQTyZNUOlwEbhATyECNGkAEbhAAAAAAAEgAADgAABAAABQAAAAAABgAAEAACvAAAAAkfDf3w
      xP3gAAAAAAk4tQk4lATzTEB/LAAAAAQNAQANAQk6/gQNAQAAGgTzWATzCCNGmgTy2NhvHgUK
      PgAABxQIQAAAAAAAAQk+Qwk+ggggwQAABAT1fAlRCwggwQAABAk+Qwk+ggggwQAABAT1nAlR
      CwggwQAABAT1nAAAAAggwQUKPgAABxQIQAAAAEB/LLqrzQAAAATzTEB/LATzbNbM1P3gAATz
      bNbM9ATzONbMmgAAB0B/LAT1kAAAAAAAAAAAAQAAFAAAAQAAAAAAAAAAEAAAAAAAUgAAAI0k
      kAAAANjWENQkAP///9bMmtRc1gAAAEB/LAUKPgAABxQIQAAAAAAAAAAAAAAAB1bhsATzvNRc
      9UB/LAUKPgAABxQIQAAAAAT0uEB/LAAAAAT1kFvsVlvsXgT2FAk67Qk2DwEgwYUADwAAAFa0
      WAEgwQAAAQAAAAAAUgAAAI0bkAAAAEL8iAT0EAADAAAAAAAAUgAAAI0bkAAAAAAAAAAAAAAA
      ALwCAAAAAIQbASDQDNABJ58aCvTxBNkzCfTxBOczCYQbARDyBP4zCSDQDIzyBKI/CQAAAAEA
      AGTyBJcO1YQbARDyBJBGI4QbAQAAABIAAA4AAAQAAAUAAAAAAAYAABAAALwCAAAAAA0fCcTw
      /QDg/QAAALU4CZQ4CUzzBCx/QAAAAAENBAENAP46CQENBBoAAFjzBAjzBJpGI9jyBB5v2D4K
      BQcAAEAIFAAAAAEAAD1G1DnJ1nxa2V9G1FFG1EzzBCx/QAAAAAAAACx/QAEAAAlNzwlaxAgg
      wQAAAAABAAT1hAAAAgla9AlNzwlaxAggwQAAAAABAAT1pAAAAgla9Ala5QgXAAMIBABgYEGD
      CBMSFMhwYQCHDQ8uDAgAOw==
   }

   image create photo gpcal-prev-month -data {
      R0lGODlhCgAFAHcAACH5BAEAAAEALAAAAAAKAAUAhwAAAP//8AAAEQAAEf//9QAAAAAAAAAA
      AAACvAAAAAEbhAzQIB4MsAoanwTx9Akz2QTx9Akz5wEbhATyEAkz/gzQIATyjAk/ogAAAAAA
      AQTyZNUOlwEbhATyECNGkAEbhAAAAAAAEgAADgAABAAABQAAAAAABgAAEAACvAAAAAkfDf3w
      xP3gAAAAAAk4tQk4lATzTEB/LAAAAAQfowAfowk6/gQfowAAGgTzWATzCCNGmgTy2NhvHgUK
      PgAABxQIQAAAAAAAAQk+Qwk+gggdPQAABAT1fAlRCwgdPQAABAk+Qwk+gggdPQAABAT1nAlR
      CwgdPQAABAT1nAAAAAgdPQUKPgAABxQIQAAAAEB/LLqrzQAAAATzTEB/LATzbNbM1P3gAATz
      bNbM9ATzONbMmgAAB0B/LAT1kAAAAAAAAAAAAQAAFAAAAQAAAAAAAAAAEAAAAAAAUgAAAI0k
      kAAAANjWENQkAP///9bMmtRc1gAAAEB/LAUKPgAABxQIQAAAAAAAAAAAAAAAB1bhsATzvNRc
      9UB/LAUKPgAABxQIQAAAAAT0uEB/LAAAAAT1kFvsVlvsXgT2FAk67Qk2DwEdPYUADwAAAFa0
      WAEdPQAAAQAAAAAAUgAAAI0bkAAAAEL8iAT0EAADAAAAAAAAUgAAAI0bkAAAAAAAAAAAAAAA
      ALwCAAAAAIQbASDQDLAMHp8aCvTxBNkzCfTxBOczCYQbARDyBP4zCSDQDIzyBKI/CQAAAAEA
      AGTyBJcO1YQbARDyBJBGI4QbAQAAABIAAA4AAAQAAAUAAAAAAAYAABAAALwCAAAAAA0fCcTw
      /QDg/QAAALU4CZQ4CUzzBCx/QAAAAKMfBKMfAP46CaMfBBoAAFjzBAjzBJpGI9jyBB5v2D4K
      BQcAAEAIFAAAAAEAAD1G1DnJ1nxa2V9G1FFG1EzzBCx/QAAAAAAAACx/QAEAAAlNzwlaxAgd
      PQAAAAABAAT1hAAAAgla9AlNzwlaxAgdPQAAAAABAAT1pAAAAgla9Ala5QgXAAMIFAgAwMCD
      BQ8OTKhwocGGBB8GCAgAOw==
   }

   image create photo gpcal-today -data {
      R0lGODlhZAAFAHcAACH5BAEAAAEALAAAAABkAAUAhwAAAP//8AAAAATzyPqI8PU4cP////lE
      qPV9cPWKOgv/6AAAI/WKPpgu3dSYsgTxvNZvbTcLzgTyGNZvjgAAAQABEQAABgYLNjcLznPZ
      uAAAgjcLziMlONRNoHPQAATx+ATx+DcLznPZuATyiNa44jcLzgAAggAAAAAAAAAAANcbETcL
      zgAAggAAAAAAAATznAT5yAAAADcLzgAAggAAAAAAAAAABAAEsNa4nATzSAAAAPlEyww46PWL
      zQUHePWQNww5EAw48Ak+Qwk+gggSoQAABAT1fAlRCwgSoQAABAk+Qwk+gggSoQAABAT1nAlR
      CwgSoQAABAT1nAAAAAgSodQa2P///9TFCdRHqjcLzgAAggAAAAAAAATzKNgFm9gDDAAAggAA
      ACMBeHPZuHP9gHP9iCMBeAHzVAUAAATyjAAAggTzdHPZsAAAAAAAAAAAAPaUVgAAUgAAAI0k
      kAAAAAw48HPeAP3gAAHzXCMAAATy0PqI8ATzxPqI8AAAAgcJiP///wAARwcJiCMlONRNoNTL
      oATzlACpGAT0dNjWEAT0JNhvHgcJiAAARwAAAAT4kAAAAdcbEQk67Qk2DwESoYUADwAAAFa3
      oAESoQAAAQAAAAAAUgAAAI0bkAAAAEL8iAT0EAADAAAAAAAAUgAAAI0bkAAAAHA49f///6hE
      +XB99TqK9ej/CyMAAD6K9d0umLKY1LzxBG1v1s4LNxjyBI5v1gEAABEBAAYAADYLBs4LN7jZ
      c4IAAM4LNzglI6BN1ADQc/jxBPjxBM4LN7jZc4jyBOK41s4LN4IAAAAAAAAAAAAAABEb184L
      N4IAAAAAAAAAAJzzBMj5BAAAAM4LN4IAAAAAAAAAAAQAALAEAJy41kjzBAAAAMtE+eg4DM2L
      9XgHBTeQ9RA5DPA4DADec7DZc7jyBOU6+LABADDecwAAI7DZcwAAAIzzBMqM9QlNzwlaxAgS
      oQAAAAABAAT1hAAAAgla9AlNzwlaxAgSoQAAAAABAAT1pAAAAgla9Ala5Qg/AAMIHEiwoMGD
      CBMOBMAQgMKHECNKnEiRIEOBFytqfNiwo8ePIEOK/GhxpMmTKB1uXHkwY0aWMGPKXNhwZsyA
      ADs=
   }

   image create photo gpcal-next-year -data {
      R0lGODlhCgAFAHcAACH5BAEAAAEALAAAAAAKAAUAhwAAAP//8AAAEQAAEf//9QAAAAAAAAAA
      AAACvAAAAAEbhAzQICcB0AoanwTx9Akz2QTx9Akz5wEbhATyEAkz/gzQIATyjAk/ogAAAAAA
      AQTyZNUOlwEbhATyECNGkAEbhAAAAAAAEgAADgAABAAABQAAAAAABgAAEAACvAAAAAkfDf3w
      xP3gAAAAAAk4tQk4lATzTEB/LAAAAAQQGgAQGgk6/gQQGgAAGgTzWATzCCNGmgTy2NhvHgUK
      PgAABxQIQAAAAAAAAQk+Qwk+gggb1gAABAT1fAlRCwgb1gAABAk+Qwk+gggb1gAABAT1nAlR
      Cwgb1gAABAT1nAAAAAgb1gUKPgAABxQIQAAAAEB/LLqrzQAAAATzTEB/LATzbNbM1P3gAATz
      bNbM9ATzONbMmgAAB0B/LAT1kAAAAAAAAAAAAQAAFAAAAQAAAAAAAAAAEAAAAAAAUgAAAI0k
      kAAAANjWENQkAP///9bMmtRc1gAAAEB/LAUKPgAABxQIQAAAAAAAAAAAAAAAB1bhsATzvNRc
      9UB/LAUKPgAABxQIQAAAAAT0uEB/LAAAAAT1kFvsVlvsXgT2FAk67Qk2DwEb1oUADwAAAFa0
      WAEb1gAAAQAAAAAAUgAAAI0bkAAAAEL8iAT0EAADAAAAAAAAUgAAAI0bkAAAAAAAAAAAAAAA
      ALwCAAAAAIQbASDQDNABJ58aCvTxBNkzCfTxBOczCYQbARDyBP4zCSDQDIzyBKI/CQAAAAEA
      AGTyBJcO1YQbARDyBJBGI4QbAQAAABIAAA4AAAQAAAUAAAAAAAYAABAAALwCAAAAAA0fCcTw
      /QDg/QAAALU4CZQ4CUzzBCx/QAAAABoQBBoQAP46CRoQBBoAAFjzBAjzBJpGI9jyBB5v2D4K
      BQcAAEAIFAAAAAEAAD1G1DnJ1nxa2V9G1FFG1EzzBCx/QAAAAAAAACx/QAEAAAlNzwlaxAgb
      1gAAAAABAAT1hAAAAgla9AlNzwlaxAgb1gAAAAABAAT1pAAAAgla9Ala5QgZAAMAABBAIMGC
      BQcmPIhQocGGBx0+nBggIAA7
   }

   image create photo gpcal-next-month -data {
      R0lGODlhCgAFAHcAACH5BAEAAAEALAAAAAAKAAUAhwAAAP//8AAAEQAAEf//9QAAAAAAAAAA
      AAACvAAAAAEP/gzQIAcAAAoanwTx9Akz2QTx9Akz5wEP/gTyEAkz/gzQIATyjAk/ogAAAAAA
      AQTyZNUOlwEP/gTyECNGkAEP/gAAAAAAEgAADgAABAAABQAAAAAABgAAEAACvAAAAAkfDf3w
      xP3gAAAAAAk4tQk4lATzTEB/LAAAAAQa7AAa7Ak6/gQa7AAAGgTzWATzCCNGmgTy2NhvHgUK
      PgAABxQIQAAAAAAAAQk+Qwk+gggKNgAABAT1fAlRCwgKNgAABAk+Qwk+gggKNgAABAT1nAlR
      CwgKNgAABAT1nAAAAAgKNgUKPgAABxQIQAAAAEB/LLqrzQAAAATzTEB/LATzbNbM1P3gAATz
      bNbM9ATzONbMmgAAB0B/LAT1kAAAAAAAAAAAAQAAFAAAAQAAAAAAAAAAEAAAAAAAUgAAAI0k
      kAAAANjWENQkAP///9bMmtRc1gAAAEB/LAUKPgAABxQIQAAAAAAAAAAAAAAAB1bhsATzvNRc
      9UB/LAUKPgAABxQIQAAAAAT0uEB/LAAAAAT1kFvsVlvsXgT2FAk67Qk2DwEKNoUADwAAAFa0
      WAEKNgAAAQAAAAAAUgAAAI0bkAAAAEL8iAT0EAADAAAAAAAAUgAAAI0bkAAAAAAAAAAAAAAA
      ALwCAAAAAP4PASDQDAAAB58aCvTxBNkzCfTxBOczCf4PARDyBP4zCSDQDIzyBKI/CQAAAAEA
      AGTyBJcO1f4PARDyBJBGI/4PAQAAABIAAA4AAAQAAAUAAAAAAAYAABAAALwCAAAAAA0fCcTw
      /QDg/QAAALU4CZQ4CUzzBCx/QAAAAOwaBOwaAP46CewaBBoAAFjzBAjzBJpGI9jyBB5v2D4K
      BQcAAEAIFAAAAAEAAD1G1DnJ1nxa2V9G1FFG1EzzBCx/QAAAAAAAACx/QAEAAAlNzwlaxAgK
      NgAAAAABAAT1hAAAAgla9AlNzwlaxAgKNgAAAAABAAT1pAAAAgla9Ala5QgWAAMIBABAoMGD
      BA8qTKgwAMOFBQ8GBAA7
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpDateSelectorClear                              #
# PURPOSE: Clear Date Selector field for "Delete" key.                  #
#=======================================================================#

proc ::gridplus::gpDateSelectorClear {name key} {

   if {$key eq "Delete"} {
      gpset $name {}
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDateSelectorKeyPress                           #
# PURPOSE: Date Selector key press post/unpost                          #
#=======================================================================#

proc ::gridplus::gpDateSelectorKeyPress {name widget action} {

   if {$action eq "post" && ! [$name instate pressed]} {
      ::gridplus::gpDateSelectorPost $name
      return -code break
   } elseif {$action eq "unpost" && [$name instate pressed]} {
      if {! [string match .gpDateSelector.calendar.* $widget]} {
         ::gridplus::gpDateSelectorUnpost
      }
   } else {
      return -code break
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDateSelectorPost                               #
# PURPOSE: Post Date Selector dropdown/popup.                           #
#=======================================================================#

proc ::gridplus::gpDateSelectorPost {name} {

   global {}

   variable gpInfo

   $name instate disabled {return}

   $name state pressed

   set widgetX      [winfo rootx  $name]
   set widgetY      [winfo rooty  $name]
   set widgetWidth  [winfo width  $name]
   set widgetHeight [winfo height $name]

   gridplus window .gpDateSelector -overrideredirect 1 -topmost 1

   wm transient .gpDateSelector [winfo toplevel $name]

   bind .gpDateSelector <ButtonPress-1> "::gridplus::gpDateSelectorToggle $name %W"

   gridplus calendar .gpDateSelector.calendar                                    \
      -command     "::gridplus::gpDateSelectorUnpost;$gpInfo($name:datecommand)" \
      -date        $($name)                                                      \
      -padding     2                                                             \
      -relief      solid                                                         \
      -selecttoday 1                                                             \
      -variable    $name

   pack .gpDateSelector.calendar

   update idletasks

   set calendarWidth [winfo reqwidth .gpDateSelector]

   if {[tk windowingsystem] eq "aqua"} {
      # Adjust for platform-specific bordering to ensure the box is
      # directly under actual 'entry square'
      set  xOffset 3
      set  yOffset 2
      incr widgetX $xOffset
      set widgetWidth [expr {$widgetWidth - $xOffset*2}]
   } else {
      set yOffset 0
   }

   set calendarHeight [winfo reqheight .gpDateSelector]

   # Added "+ 40" to take into account windows task bar.
   if {$widgetY + $widgetHeight + $calendarHeight + 40 > [winfo screenheight .gpDateSelector]} {
      set Y [expr {$widgetY - $calendarHeight - $yOffset}]
   } else {
      set Y [expr {$widgetY + $widgetHeight - $yOffset}]
   }

   set X [expr {$widgetX - ($calendarWidth - $widgetWidth)}]

   if {$X < 0} {
      set X $widgetX
   }

   wm geometry  .gpDateSelector +${X}+${Y}
   wm deiconify .gpDateSelector
   raise        .gpDateSelector

   ttk::globalGrab .gpDateSelector

   focus $name
}

#=======================================================================#
# PROC   : ::gridplus::gpDateSelectorToggle                             #
# PURPOSE: Toggle Date Selector dropdown/popup.                         #
#=======================================================================#

proc ::gridplus::gpDateSelectorToggle {name widget} {

   if {[$name instate pressed]} {
      if {! [string match .gpDateSelector.calendar.* $widget]} {
         ::gridplus::gpDateSelectorUnpost
      }
   } else {
      ::gridplus::gpDateSelectorPost $name
      return -code break
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDateSelectorUnpost                             #
# PURPOSE: Unpost Date Selector dropdown/popup.                         #
#=======================================================================#

proc ::gridplus::gpDateSelectorUnpost {{testWindow {}}} {

   variable gpInfo

   if {[winfo exists .gpDateSelector.calendar] && $testWindow ne ".gpDateSelector"} {
      foreach dateSelector [array names gpInfo *:datecommand] {
         set name [lindex [split $dateSelector :] 0]
         if {[$name instate pressed]} {
            $name state !pressed

            ttk::releaseGrab .gpDateSelector

            gridplus clear .gpDateSelector
            destroy .gpDateSelector

            update idletasks
            ttk::combobox::Unpost $name

            focus $name
         }
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDefine                                         #
# PURPOSE: Creates GRIDPLUS widget definitions.                         #
#=======================================================================#

proc ::gridplus::gpDefine {} {
   upvar 1 options options

   variable gpInfo

   foreach {id widget} $options(layout) {
      set gpInfo(<gpDefine>:$id) $widget
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpDefineWidget                                   #
# PURPOSE: Process "defined" widget.                                    #
#=======================================================================#

proc ::gridplus::gpDefineWidget {column} {

   variable gpInfo

   if {[string match @* $column]} {
      if {[winfo exists .[string range [lindex $column 0] 1 end]]} {
         return $column
      }
      set defineID [string range [lindex $column 0] 1 end]
      if {[info exists gpInfo(<gpDefine>:$defineID)]} {
         set defineWidget $gpInfo(<gpDefine>:$defineID)
         set replacementID 1

         foreach replacement [lrange $column 1 end] {
            regsub -- "%$replacementID" $defineWidget $replacement defineWidget
            incr replacementID 
         }
      }
      return [::gridplus::gpDefineWidget $defineWidget]
   } else {
      return $column
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpEditMenu                                       #
# PURPOSE: Pop-up menu for entry widgets.                               #
#=======================================================================#

proc ::gridplus::gpEditMenu {mode} {

   set widget [focus]

   switch -- $mode {
      cut   {
         clipboard clear
         clipboard append [selection get]
         $widget delete sel.first sel.last
      }
      copy  {
         clipboard clear
         clipboard append [selection get]
      }
      paste {
         $widget selection clear
         $widget insert insert [clipboard get]
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpEditMenuCreate                                 #
# PURPOSE: Create pop-up menu for entry widgets.                        #
#=======================================================================#

proc ::gridplus::gpEditMenuCreate {window} {

      menu $window.gpEditMenu

      $window.gpEditMenu configure -tearoff 0

      $window.gpEditMenu add command -label [mc "Cut"]   -command "::gridplus::gpEditMenu cut"
      $window.gpEditMenu add command -label [mc "Copy"]  -command "::gridplus::gpEditMenu copy"
      $window.gpEditMenu add command -label [mc "Paste"] -command "::gridplus::gpEditMenu paste"
}

#=======================================================================#
# PROC   : ::gridplus::gpEntryEdit                                      #
# PURPOSE: Pop-up menu for entry widgets.                               #
#=======================================================================#

proc ::gridplus::gpEntryEdit {editWindow X Y {variable {}}} {

   global {}

   set widget [winfo containing $X $Y]

   focus $widget

   if {$variable eq ""} {
      set variable $widget
   }

   if {$editWindow eq ""} {
      set window {}
   } else {
      set window .$editWindow
   }

   if {! [$widget selection present]} {
      $widget selection range 0 end
   }

   if {[$widget cget -state] ne "normal"} {
      $window.gpEditMenu entryconfigure 0 -state disabled
      $window.gpEditMenu entryconfigure 1 -state normal
      $window.gpEditMenu entryconfigure 2 -state disabled
   } else {
      $window.gpEditMenu entryconfigure 0 -state normal
      $window.gpEditMenu entryconfigure 1 -state normal
      $window.gpEditMenu entryconfigure 2 -state normal
   }

   if {$($variable) eq ""} {
      $window.gpEditMenu entryconfigure 0 -state disabled
      $window.gpEditMenu entryconfigure 1 -state disabled
   }

   if {[$widget cget -state] ne "disabled"} {
      $window.gpEditMenu post $X $Y
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpGetFontOption                                  #
# PURPOSE: Get font option for specified font.                          #
#=======================================================================#

proc ::gridplus::gpGetFontOption {font option} {

   foreach {fontOption value} [font configure $font] {
      if {$fontOption eq $option} {
         return $value
      }
   }

   return {}
}

#=======================================================================#
# PROC   : ::gridplus::gpGetFontSize                                    #
# PURPOSE: Get font size for specified font.                            #
#=======================================================================#

proc ::gridplus::gpGetFontSize {font} {

   if {[llength $font] == 1} {
      return [::gridplus::gpGetFontOption $font -size]
   } else {
      return [lindex $font 1]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpGoto                                           #
# PURPOSE: Move text widget display to specified label.                 #
#=======================================================================#

proc ::gridplus::gpGoto {} {
   upvar 1 options options

   global {}

   $options(name).text yview $options(layout)

   set ($options(name)) $options(layout)
}

#=======================================================================#
# PROC   : ::gridplus::gpGrid                                           #
# PURPOSE: Create grid.                                                 #
#=======================================================================#

proc ::gridplus::gpGrid {} {
   upvar 1 options options

   global {}

   variable gpInfo
   variable gpTabOrder

   set options(-columnformat) [::gridplus::gpOptionAlias -columnformat -cfmt]

   set labelColor(1) [lindex [split $options(-labelcolor) /] 0]
   set labelColor(2) [lindex [split $options(-labelcolor) /] 1]
   set labelStyle(1) [lindex [split $options(-labelstyle) /] 0]
   set labelStyle(2) [lindex [split $options(-labelstyle) /] 1]

   regsub -all -- {,} $labelStyle(1) { } labelStyle(1)
   regsub -all -- {,} $labelStyle(2) { } labelStyle(2)

   if {[string match *w* $options(-attach)]} {
      set leftStretch    0
      set rightStretch   1
      set defaultStretch 0
   } else {
      set leftStretch    0
      set rightStretch   0
      set defaultStretch 1
   }

   if {[llength $options(-spacestretch)] == 1} {
      set options(-spacestretch) [lrepeat 100 $options(-spacestretch)]
   }

   if {[string match *n* $options(-attach)]} {
      set weightY 0
   } else {
      set weightY 1
   }

   ::gridplus::gpLabelframe

   grid anchor $options(name) $options(-anchor)

   set rowID    0
   set rowTotal [llength [split $options(layout) "\n"]]
   set rowCount 1

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   if {$options(-subst)} {
      if {[=< substCommandGrid [=< substCommand 0]]} {
         set options(layout) [subst -nobackslashes $options(layout)]   
      } else {
         set options(layout) [subst -nobackslashes -nocommands $options(layout)]
      }
   }

   foreach row [split $options(layout) "\n"] {
      set columnID    0
      set columnTotal [llength $row]
      set columnCount 1

      if {$options(-spacestretch) eq ""} {
         if {$columnTotal > 1} {
            set stretch "$leftStretch [lrepeat [expr {$columnTotal - 1}] $defaultStretch] $rightStretch"
         } else {
            set stretch "$leftStretch $rightStretch"
         }
      } else {
         set stretch $options(-spacestretch)
      }

      ::ttk::frame $options(name).space:$rowID:$columnID -width 0
      grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
      grid columnconfigure $options(name) $columnID -weight [lindex $stretch 0]
      incr columnID

      foreach column $row {
         switch -- [llength $column] {
            0 {
               set columnSpan 2
               set column "{}"
            }
            1 {
               set columnSpan 2
            }
            2 {
               set columnSpan 1
            }
            default {
               error "GRIDPLUS ERROR: Too many items in column"
            }
         }

         set columnItem     1
         set formatWidth(1) 0
         set formatWidth(2) 0

         if {[set columnFormat [lindex $options(-columnformat) [expr {$columnCount - 1}]]] ne ""} {
            if {[lindex [split $columnFormat "/"] 0] ne ""} {
               set formatWidth(1) [lindex [split $columnFormat "/"] 0]
               set formatWidth(2) [lindex [split $columnFormat "/"] 1]
            }
            if {$formatWidth(1) eq ""} {set formatWidth(1) 0}
            if {$formatWidth(2) eq ""} {set formatWidth(2) 0}
         }

         foreach item $column {
            set bold       0
            set command    {}
            set labelFont  $labelStyle($columnItem)
            set labelIcon  {}
            set labelWidth 0
            set sticky     {}
            set validate   0

            if {! [string match "*: " $item]} {
                regexp {(^[^:]+)(:(([nsewc]+)?([0-9]+)?$)?)} $item -> item - - sticky labelWidth
            }

            if {$labelWidth eq ""} {set labelWidth 0}

            switch -- $sticky {
               c  {set sticky {}}
               "" {set sticky w}
            }
            switch -glob -- $item {
               .* {
                  set itemName $item
                  ::ttk::frame $options(name).widget:$rowID:$columnID
                  ::ttk::frame $options(name).widget:$rowID:$columnID.width -height 0 -width [expr {$formatWidth($columnItem) * $gpInfo(<gpWidthFactor>)}]

                  if {! [winfo exists $item]} {
                     set itemName $options(name),[string range $item 1 end]

                     if {$options(-basename) ne ""} {
                        set textVariable $options(-basename),[string range $item 1 end]
                     } else {
                        set textVariable $itemName
                     }
                     ::ttk::label $itemName -foreground $labelColor($columnItem) -justify $options(-justify) -wraplength $options(-wraplength) -textvariable ($textVariable)
                     if {$labelFont ne ""} {
                        $itemName configure -font [::gridplus::gpSetFont $labelFont]
                     }
                  }

                  grid $options(name).widget:$rowID:$columnID.width         -row 0 -column 0
                  grid $itemName -in $options(name).widget:$rowID:$columnID -row 1 -column 0 -sticky $sticky
                  grid configure $options(name).widget:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  grid columnconfigure $options(name).widget:$rowID:$columnID 0 -weight 1

                  if {$options(-taborder) eq "column"} {
                     set gpTabOrder([format "%s:%03d%03d%03d" $options(name) $columnCount $rowCount $columnItem]) $itemName
                  } else {
                     set gpTabOrder([format "%s:%03d%03d%03d" $options(name) $rowCount $columnCount $columnItem]) $itemName
                  }
               }
               | {
                  ::ttk::separator $options(name).separator:$rowID:$columnID -orient vertical   
                  grid configure $options(name).separator:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky ns
               }
               = {
                  ::ttk::separator $options(name).separator:$rowID:$columnID -orient horizontal
                  grid configure $options(name).separator:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky ew
               }
               :* {
                  if {! [regexp -- {^:([^:]*):([^:]*):([^:]*)$} $item -> labelIcon command validate]} {
                     set labelIcon [string range $item 1 end]
                     regsub -- {%%$} $labelIcon {} labelIcon
                  }
                  if {$labelIcon eq ""} {
                     set labelIcon $options(-icon)
                  }
                  ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $labelIcon
                  ::ttk::label $options(name).label:$rowID:$columnID -image ::icon::$labelIcon
                  grid configure $options(name).label:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  if {$command ne ""} {
                     if {$options(-proc)} {
                        set command "set gridplus::gpInfo(<gpFocus>) \[focus\];gpProc $command"
                     } else {
                        set command "set gridplus::gpInfo(<gpFocus>) \[focus\];$options(-prefix)$command"
                        regsub -all {[.]} $command ":" command
                        regsub      {;:}  $command ";" command
                     }

                     bind $options(name).label:$rowID:$columnID <ButtonRelease-1> "eval \"::gridplus::gpCommand {$command} .$window $validate\""
                  }
               }
               default {
                  if {[string match ^* $item]} {
                     set labelFont "$labelFont bold"
                     set item [string range $item 1 end]
                  }
                  regsub -all -- " +\n +" $item "\n" item
                  regsub -all -- "<n>"    $item "\n" item

                  if {$labelWidth == 0} {
                     set labelWidth $formatWidth($columnItem)
                  }

                  ::ttk::frame $options(name).label:$rowID:$columnID
                  ::ttk::frame $options(name).label:$rowID:$columnID.width -height 0 -width [expr {$labelWidth * $gpInfo(<gpWidthFactor>)}]
                  ::ttk::label $options(name).label:$rowID:$columnID.text -foreground $labelColor($columnItem) -style $options(-style) -justify $options(-justify) -wraplength $options(-wraplength) -text [mc $item]
                  if {$labelFont ne ""} {
                     $options(name).label:$rowID:$columnID.text configure -font [::gridplus::gpSetFont $labelFont]
                  }
                  grid $options(name).label:$rowID:$columnID.width -row 0 -column 0
                  grid $options(name).label:$rowID:$columnID.text -in $options(name).label:$rowID:$columnID -row 1 -column 0 -sticky $sticky
                  grid configure $options(name).label:$rowID:$columnID -in $options(name) -column $columnID -row $rowID -columnspan $columnSpan -sticky $sticky
                  grid columnconfigure $options(name).label:$rowID:$columnID 0 -weight 1
               }
            }
            incr columnID $columnSpan
            incr columnItem
         }

         if {$columnCount != $columnTotal} {
            ::ttk::frame $options(name).space:$rowID:$columnID -width $options(-space)
            grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
            grid columnconfigure $options(name) $columnID -weight [lindex $stretch $columnCount]
            incr columnID
         } else {
            ::ttk::frame $options(name).space:$rowID:$columnID -width 0
            grid $options(name).space:$rowID:$columnID -column $columnID -row $rowID -sticky ew
            grid columnconfigure $options(name) $columnID -weight [lindex $stretch $columnCount]
         }

         incr columnCount
      }

      incr rowID

      if {$rowCount != $rowTotal} {
         ::ttk::frame $options(name).space:$rowID:$columnID -height 4 -width 4
         grid $options(name).space:$rowID:$columnID -row $rowID -column 0 -sticky ns -columnspan 3
         grid rowconfigure $options(name) $rowID -weight $weightY
         incr rowID
      } elseif {! $weightY} {
         ::ttk::frame $options(name).space:$rowID:$columnID -height 4 -width 4
         grid $options(name).space:$rowID:$columnID -row $rowID -column 0 -sticky ns -columnspan 3
         grid rowconfigure $options(name) $rowID -weight 1
      }

      incr rowCount
   }

   foreach stretch $options(-stretch) {
      grid columnconfigure $options(name) [expr {(($stretch + 1) * 3) - 1}] -weight 1
   }

   gpSetTabOrder $options(name)

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpInit                                           #
# PURPOSE: Gridplus initailise.                                         #
#=======================================================================#

proc ::gridplus::gpInit {} {
   variable gpConfig
   variable gpInfo
   variable gpOptionSets
   variable gpValidation

   wm resizable . 0 0

   set gpInfo(.:toplevel)       1
   set gpInfo(.:modal)          0
   set gpInfo(<gpTextFindItem>) {}

   ttk::label .gpWidthFactor -width 1
   set gpInfo(<gpWidthFactor>) [winfo reqwidth .gpWidthFactor]
   destroy .gpWidthFactor

   if {[namespace exists "::starkit"]} {
      set iconPath [file join $::starkit::topdir lib]
   } else {
      set iconPath [file join [info library]]
   }

   array set gpConfig [list                \
      dateformat   [=< dateFormat us]      \
      errormessage [=< errorMessage %]     \
      iconfile     [=< iconFile tkIcons]   \
      iconpath     [=< iconPath $iconPath] \
      locale       [=< locale]             \
      prefix       [=< prefix]             \
      proc         [=< proc 0]             \
   ]

   switch -- $gpConfig(dateformat) {
      eu {
         set gpConfig(date:day)       0
         set gpConfig(date:month)     1
         set gpConfig(date:year)      2
         set gpConfig(date:separator) .
      }
      iso {
         set gpConfig(date:day)       2
         set gpConfig(date:month)     1
         set gpConfig(date:year)      0
         set gpConfig(date:separator) -
      }
      uk {
         set gpConfig(date:day)       0
         set gpConfig(date:month)     1
         set gpConfig(date:year)      2
         set gpConfig(date:separator) /
      }
      us {
         set gpConfig(date:day)       1
         set gpConfig(date:month)     0
         set gpConfig(date:year)      2
         set gpConfig(date:separator) /
      }
   }

   set gpConfig(date:century) [=< century 50]

   array set gpValidation {
      alpha          {^[a-zA-Z]+$}
      alphanum       {^[a-zA-Z0-9]+$}
      date           {proc:gpValidateDate}
      decimal        {trim:^[0-9]+[.][0-9]+$}
      -decimal       {trim:^(-)?[0-9]+[.][0-9]+$}
      money          {trim:^[0-9]+[.][0-9][0-9]$}
      -money         {trim:^(-)?[0-9]+[.][0-9][0-9]$}
      num            {trim:^[0-9]+([.][0-9]+)?$}
      -num           {trim:^(-)?[0-9]+([.][0-9]+)?$}
      int            {trim:^[0-9]+$}
      -int           {trim:^(-)?[0-9]+$}
      notnull        {[^\000]}
      !              {[^\000]}
      alpha:text     {Alpha}
      alphanum:text  {Alphanumeric}
      date:text      {Date}
      decimal:text   {Decimal}
      -decimal:text  {Decimal}
      money:text     {Money Format}
      -money:text    {Money Format}
      num:text       {Numeric}
      -num:text      {Numeric}
      int:text       {Integer}
      -int:text      {Integer}
      notnull:text   {Not Null}
      !:text         {Non Blank}
   }

   set gpOptionSets(.) {
      -space 0
      -style {}
   }

   ::gridplus::gpCreateIcons

   ::gridplus::gpEditMenuCreate {}

   bind . <Configure> "::gridplus::gpWindowBindings . %W 1"
   bind . <Unmap>     "::gridplus::gpWindowBindings . %W 1"
}

#=======================================================================#
# PROC   : ::gridplus::gpInsertText                                     #
# PURPOSE: Inserts "tagged" data into text widget.                      #
#=======================================================================#

proc ::gridplus::gpInsertText {name tag end parameter position text} {
   upvar 1 options options

   global {}

   variable gpInfo

   if {! [regexp -- {^[.]([^.]+)[.]} $name -> window]} {
      set window {}
   }

   set command        false
   set imageCommand   {}
   set imageInfo      {}
   set imageLink      {}
   set imageParameter {}
   set link           false
   set bgColor        $gpInfo($name:bgcolor)
   set fgColor        $gpInfo($name:fgcolor)
   set linkColor      $gpInfo($name:link)
   set setCommand     0
   set validate       0

   switch -- $end$tag {
      init     {set gpInfo($name:font)       $gpInfo($name:defaultfont)
                set gpInfo($name:size)       10
                set gpInfo($name:weight)     normal
                set gpInfo($name:slant)      roman
                set gpInfo($name:underline)  false}
      b        {set gpInfo($name:weight)     bold}
      /b       {set gpInfo($name:weight)     normal}
      bgcolor  {set bgColor                  [lindex [split $parameter :] 0]
                set bgParameter              [lindex [split $parameter :] 1]
                if {$bgParameter eq "default"} {set gpInfo($name:defaultbg) $bgColor}
                set gpInfo($name:bgcolor)    $bgColor}
      /bgcolor {set bgColor                  $gpInfo($name:defaultbg)
                set gpInfo($name:bgcolor)    $gpInfo($name:defaultbg)}
      color    {set fgColor                  [lindex [split $parameter :] 0]
                set fgParameter              [lindex [split $parameter :] 1]
                if {$fgParameter eq "default"} {set gpInfo($name:defaultfg) $fgColor}
                set gpInfo($name:fgcolor)    $fgColor}
      /color   {set fgColor                  $gpInfo($name:defaultfg)
                set gpInfo($name:fgcolor)    $gpInfo($name:defaultfg)}
      command  {set fgColor                  $gpInfo($name:normalcolor)
                set gpInfo($name:underline)  $gpInfo($name:normalstyle)
                set command                  [lindex [split $parameter :] 0]
                set commandParameter         [lindex [split $parameter :] 1]
                if {$commandParameter eq ""} {set commandParameter $text}}
      font     {set font                     [lindex [split $parameter :] 0]
                set fontParameter            [lindex [split $parameter :] 1]
                if {$fontParameter eq "default"} {set gpInfo($name:defaultfont) $font}
                set gpInfo($name:font)       $font}
      /font    {set gpInfo($name:font)       $gpInfo($name:defaultfont)}
      i        {set gpInfo($name:slant)      italic}
      /i       {set gpInfo($name:slant)      roman}
      image    {set imageInfo                $parameter}
      indent   {set gpInfo($name:indent)     $parameter
                set tabs [string repeat "\t" $parameter]
                set text "$tabs$text"}
      /indent  {set gpInfo($name:indent)     0}
      label    {set label                    [lindex [split $parameter :] 0]
                set labelParameter           [lindex [split $parameter :] 1]
                if {$labelParameter eq "default"} {set ($name) $label} 
                $name.text mark set $label "insert wordstart"
                $name.text mark gravity $label left}
      link     {set fgColor                  $gpInfo($name:normalcolor)
                set gpInfo($name:underline)  $gpInfo($name:normalstyle)
                set link                     $parameter}
      size     {set size                     [lindex [split $parameter :] 0]
                set sizeParameter            [lindex [split $parameter :] 1]
                if {$sizeParameter eq "default"} {set gpInfo($name:defaultsize) $size}
                set gpInfo($name:size)       [gridplus::gpSetFontSize $gpInfo($name:defaultsize) $size]}
      /size    {set gpInfo($name:size)       $gpInfo($name:defaultsize)}
      tab      {if {$parameter eq ""} {set parameter 1}
                set tabs [string repeat "\t" $parameter]
                set text "$tabs$text"}
      u        {set gpInfo($name:underline)  true}
      /u       {set gpInfo($name:underline)  false}
   }

   set tagName "tag[incr gpInfo($name:tagid)]"
   set font    "-family $gpInfo($name:font) -size $gpInfo($name:size) -slant $gpInfo($name:slant) -underline $gpInfo($name:underline) -weight $gpInfo($name:weight)"
   set indent  "[expr {$gpInfo($name:indent) * 0.5}]c"

   $name.text tag configure $tagName -lmargin1 $indent -lmargin2 $indent -background $bgColor -foreground $fgColor -font "$font"

   if {$imageInfo ne ""} {
      if {[string match *@* $imageInfo]} {
         set image          [lindex [split $imageInfo @] 0]
         set imageLink      [lindex [split $imageInfo @] 1]
      } else {
         set image          [lindex [split $imageInfo ~] 0]
         set imageCommand   [lindex [split [lindex [split $imageInfo ~] 1] :] 0]
         set imageParameter [lindex [split [lindex [split $imageInfo ~] 1] :] 1]

         if {$imageCommand ne ""} {
            set setCommand   1
            set imageCommand "$name,$imageCommand"

            if {$gpInfo($name:proc)} {
               set imageCommand "set gridplus::gpInfo(<gpFocus>) \[focus\];gpProc $imageCommand"
            } else {
               set imageCommand "set gridplus::gpInfo(<gpFocus>) \[focus\];$gpInfo($name:prefix)$imageCommand"
               regsub -all {[.]} $imageCommand ":" imageCommand
               regsub      {;:}  $imageCommand ";" imageCommand
            }
         }
      }

      if {[string match :* $image]} {
         set icon  [string range $image 1 end]
         set image "::icon::$icon"
         ::icons::icons create -file $gpInfo($name:iconlibrary) $icon
      }

      set imageName [$name.text image create end -image $image]

      $name.text tag add $imageName $imageName
      $name.text tag configure $imageName -background $bgColor

      if {$imageLink ne ""} {
         $name.text tag bind $imageName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor)"
         $name.text tag bind $imageName <Leave> "$name.text configure -cursor {}"
         $name.text tag bind $imageName <ButtonPress-1> "set ($name) $imageLink; $name.text yview $imageLink"
      } elseif {$setCommand} {
         $name.text tag bind $imageName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor)"
         $name.text tag bind $imageName <Leave> "$name.text configure -cursor {}"
         $name.text tag bind $imageName <ButtonPress-1> "set ($name) \"$imageParameter\"; ::gridplus::gpCommand {$imageCommand} .$window $validate"
      }
   }

   if {$command ne "false"} {

      set command "$name,$command"

      if {$gpInfo($name:proc)} {
         set command "set gridplus::gpInfo(<gpFocus>) \[focus\];gpProc $command"
      } else {
         set command "set gridplus::gpInfo(<gpFocus>) \[focus\];$gpInfo($name:prefix)$command"
         regsub -all {[.]} $command ":" command
         regsub      {;:}  $command ";" command
      }

      $name.text tag bind $tagName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor); $name.text tag configure $tagName -foreground $gpInfo($name:overcolor) -underline $gpInfo($name:overstyle)"
      $name.text tag bind $tagName <Leave> "$name.text configure -cursor {}; $name.text tag configure $tagName -foreground $gpInfo($name:normalcolor) -underline $gpInfo($name:normalstyle)"
      $name.text tag bind $tagName <ButtonPress-1> "set ($name) \"$commandParameter\"; ::gridplus::gpCommand {$command} .$window $validate"

      set gpInfo($name:underline) false
   }

   if {$link ne "false"} {
      $name.text tag bind $tagName <Enter> "$name.text configure -cursor $gpInfo($name:linkcursor); $name.text tag configure $tagName -foreground $gpInfo($name:overcolor) -underline $gpInfo($name:overstyle)"
      $name.text tag bind $tagName <Leave> "$name.text configure -cursor {}; $name.text tag configure $tagName -foreground $gpInfo($name:normalcolor) -underline $gpInfo($name:normalstyle)"
      $name.text tag bind $tagName <ButtonPress-1> "set ($name) $link; $name.text yview $link"
      set gpInfo($name:underline) false
   }

   if {$text ne ""} {
      regsub -all {!b:}  $text "\u2022" text
      regsub -all {!ob:} $text \{       text
      regsub -all {!cb:} $text \}       text
      regsub -all {!bs:} $text {\\}     text
      regsub -all {!lt:} $text {<}      text
      regsub -all {!gt:} $text {>}      text
      $name.text insert $position $text $tagName 
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpLabelframe                                     #
# PURPOSE: Implements work-around to deal with ttk::labelframe bug.     #
#=======================================================================#

proc ::gridplus::gpLabelframe {} {
   upvar 1 options options
   
   if {$options(-relief) eq "theme"} {
      if {$options(-title) eq ""} {
         ::ttk::labelframe $options(name) -padding $options(-padding)
         ::ttk::separator  $options(name).separator -orient horizontal
         $options(name) configure -labelwidget $options(name).separator -labelanchor s
      } else {
         if {$options(-labelanchor) eq ""} {
            ::ttk::labelframe $options(name) -padding $options(-padding) -text [mc $options(-title)]
         } else {
            ::ttk::labelframe $options(name) -labelanchor $options(-labelanchor) -padding $options(-padding) -text [mc $options(-title)]
         }
      }  
   } else {
      ::ttk::frame $options(name) -padding $options(-padding) -relief $options(-relief)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpLayout                                         #
# PURPOSE: Create layout.                                               #
#=======================================================================#

proc ::gridplus::gpLayout {} {
   upvar 1 options options

   global {}

   variable gpTabOrder

   set rowCount      0
   set layout(items) {}
   set toplevel      {}

   if {$options(-subst)} {
      if {[=< substCommandLayout [=< substCommand 0]]} {
         set options(layout) [subst -nobackslashes $options(layout)]   
      } else {
         set options(layout) [subst -nobackslashes -nocommands $options(layout)]
      }
   }

   foreach row [split $options(layout) "\n"] {
      set columnCount 0
      foreach column $row {
         set setXweight 0
         set setYweight 0
         set sticky  {}

         if {$column eq "="} {set column ".="}
         if {$column eq "|"} {set column ".|"}

         regexp -- {(^[^:]+)(:([nsewc]+$)?)} $column -> column -> sticky

         if {[regexp -- {(^[.][^|]+)([|]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setXweight 1
         }
         if {[regexp -- {(^[.][^=]+)([=]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setYweight 1
         }
         if {[regexp -- {(^[.][^+]+)([+]([nsewc]+$)?)} $column -> column -> sticky]} {
            set setXweight 1
            set setYweight 1
         }

         set layout($column:xweight) 1
         set layout($column:yweight) 1

         if {$setXweight} {set layout($column:xweight) 0}
         if {$setYweight} {set layout($column:yweight) 0}

         switch -- $sticky {
            c  {set sticky {}}
            "" {set sticky w}
         }
         switch -glob -- $column {
            .* {
               if {$column eq ".="} {
                  ::ttk::separator $options(name):line:$columnCount:$rowCount -orient horizontal
                  set sticky "nsew"
                  set column $options(name):line:$columnCount:$rowCount
                  set layout($column:yweight) 0
               }
               if {$column eq ".|"} {
                  ::ttk::separator $options(name):line:$columnCount:$rowCount -orient vertical
                  set sticky "nsew"
                  set column $options(name):line:$columnCount:$rowCount
                  set layout($column:xweight) 0
               }
               set column [regsub -all -- {%} $column [string range $options(name) 1 end]]
               lappend layout(items) $column
               set layout(cell:$columnCount,$rowCount) $column
               set layout($column:x)      $columnCount
               set layout($column:y)      $rowCount
               set layout($column:xspan)  1
               set layout($column:yspan)  1
               set layout($column:sticky) $sticky
               if {$options(-taborder) eq "column"} {
                  set gpTabOrder([format "%s:%03d%03d001" $options(name) $columnCount $rowCount]) $column
               } else {
                  set gpTabOrder([format "%s:%03d%03d001" $options(name) $rowCount $columnCount]) $column
               }
            }
            - {
               if {$columnCount == 0} {error "GRIDPLUS ERROR (layout): Column span not valid in first column"}
               set previousColumn [expr {$columnCount - 1}]
               set cell $layout(cell:$previousColumn,$rowCount)
               set layout(cell:$columnCount,$rowCount) $layout(cell:$previousColumn,$rowCount)
               incr layout($cell:xspan)
            }
            ^ {
               if {$rowCount == 0} {error "GRIDPLUS ERROR (layout): Row span not valid in first row"}
               set previousRow  [expr {$rowCount - 1}]
               set previousCell [expr {$columnCount - 1}]
               set cell $layout(cell:$columnCount,$previousRow)
               set layout(cell:$columnCount,$rowCount) $layout(cell:$columnCount,$previousRow)
               if {! ([info exists layout(cell:$previousCell,$rowCount)] && $layout(cell:$previousCell,$rowCount) eq $cell)} {
                  incr layout($cell:yspan)
               }
            }
            x {
            }
            default {
               error "GRIDPLUS ERROR (layout): Invalid item/option ($column)"
            }
         }
         incr columnCount
      }
      incr rowCount
   }

   if {$options(-wtitle) ne "" && [regexp {([.][^.]*)[.].+$} $options(name) -> window]} {
      wm title $window [mc $options(-wtitle)]
   }

   ::gridplus::gpLabelframe

   foreach item $layout(items) {
      set padxLeft  $options(-padx)
      set padxRight $options(-padx)

      if {$layout($item:x) == 0} {
         set padxLeft 0
      }
      if {[expr {$layout($item:x) + $layout($item:xspan)}] == $columnCount} {
         set padxRight 0
      }

      set padyTop    $options(-pady)
      set padyBottom $options(-pady)

      if {$layout($item:y) == 0} {
         set padyTop 0
      }
      if {[expr {$layout($item:y) + $layout($item:yspan)}] == $rowCount} {
         set padyBottom 0
      }

      set padx [list $padxLeft $padxRight]
      set pady [list $padyTop  $padyBottom]

      grid configure $item -in $options(name) -column $layout($item:x) -row $layout($item:y) -columnspan $layout($item:xspan) -rowspan $layout($item:yspan) -sticky $layout($item:sticky) -padx $padx -pady $pady

      if {[info exists layout($item:xweight)]} {
         set xweight $layout($item:xweight)
      } else {
         set xweight 1
      }
      if {[info exists layout($item:yweight)]} {
         set yweight $layout($item:yweight)
      } else {
         set yweight 1
      }

      grid columnconfigure $options(name) $layout($item:x) -weight $xweight
      grid rowconfigure    $options(name) $layout($item:y) -weight $yweight
      gpSetTabOrder $options(name)
   }

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpLine                                           #
# PURPOSE: Gridplus create line.                                        #
#=======================================================================#

proc ::gridplus::gpLine {} {
   upvar 1 options options

   if {$options(-background) eq ""} {
      set background [. cget -background] 
   } else {
      set background $options(-background)
   }

   if {$options(-title) ne ""} {
      frame $options(name) -background $background -padx $options(-padx) -pady $options(-pady)
      frame $options(name).left  -background $background -borderwidth 2 -height 2 -relief sunken -width 5
      frame $options(name).right -background $background -borderwidth 2 -height 2 -relief sunken
      label $options(name).label -background $background -text [mc $options(-title)] -borderwidth 1
      grid configure $options(name).left  -column 0 -row 0 -sticky ew
      grid configure $options(name).label -column 1 -row 0
      grid configure $options(name).right -column 2 -row 0 -sticky ew
      grid columnconfigure $options(name) 2 -weight 1
   } else {
     frame $options(name) -background $background -borderwidth $options(-borderwidth) -height $options(-linewidth) -padx $options(-padx) -pady $options(-pady) -relief $options(-linerelief) -width $options(-linewidth)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpMenu                                           #
# PURPOSE: Create menu(bar).                                            #
#=======================================================================#

proc ::gridplus::gpMenu {} {
   upvar 1 options options

   if {$options(name) eq "."} {
      set rootMenu .menubar
      $options(name) configure -menu $rootMenu
   } elseif {[winfo exists $options(name)] && [winfo class $options(name)] eq "Toplevel"} {
      set rootMenu $options(name).menubar
      $options(name) configure -menu $rootMenu
   } else {
      set rootMenu $options(name)
   }

   menu $rootMenu

   $rootMenu configure -tearoff 0

   set rootMenuIndex 0

   foreach {menuLabel menuEntries} $options(layout) {
      set underline [string first "_" $menuLabel]
      regsub -all -- {_} $menuLabel {} menuLabel

      if {$menuLabel eq "~"} {
         ::gridplus::gpMenuOption $rootMenu {} $rootMenuIndex $menuEntries
         incr rootMenuIndex
         continue  
      }

      if {[string match @* $menuEntries]} {
         set cascade ".[string range $menuEntries 1 end]"
         $rootMenu add cascade -label [mc $menuLabel] -menu $cascade -underline $underline
         continue
      }

      set menu [string tolower $menuLabel]

      $rootMenu add cascade -label [mc $menuLabel] -menu $rootMenu.$menu -underline $underline
      menu $rootMenu.$menu
      $rootMenu.$menu configure -tearoff 0

      set menuIndex 0

      foreach menuEntryData $menuEntries {
         ::gridplus::gpMenuOption $rootMenu $menu $menuIndex $menuEntryData  
         incr menuIndex
      }

      incr rootMenuIndex
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpMenuOption                                     #
# PURPOSE: Create menu(bar) option.                                     #
#=======================================================================#

proc ::gridplus::gpMenuOption {rootMenu menu menuIndex menuEntryData} {
   upvar 1 options options

   variable gpInfo

   set menuEntryLabel   [lindex $menuEntryData 0]
   set menuEntryOptions [lrange $menuEntryData 1 end]
   set underline        [string first "_" $menuEntryLabel]

   regsub -all -- {_} $menuEntryLabel {} menuEntryLabel

   set menuEntry        [string tolower $menuEntryLabel]

   regsub -all -- { } $menuEntry {_} menuEntry

   if {$menuEntry eq "-" || $menuEntry eq "="} {
      if {$menu eq ""} {
         $rootMenu add separator
      } else {
         $rootMenu.$menu add separator     
      }
   } else {
      if {$menu eq ""} {
         set command     $rootMenu,$menuEntry
         set menuEntryID $rootMenu@$menuIndex
         set menuName    {}
      } else {
         set command     $rootMenu:$menu,$menuEntry
         set menuEntryID $rootMenu.$menu@$menuIndex
         set menuName    .$menu
      }
      set cascade     {}
      set compound    none
      set menuIcon    {}
      set state       $options(-state)
      set validate    0

      foreach item $menuEntryOptions {
         switch -regexp -- $item {
            ^% {
               set gpInfo($menuEntryID:group) [string range $item 1 end]
            }
            ^<$ {
               set state disabled
            }
            ^>$ {
               set state normal
            }
            ^!$ {
               set validate 1
            }
            ^@ {
               set cascade ".[string range $item 1 end]"
            }
            ^[.~].+ {
               set command [string range $item 1 end]
            }
            ^: {
               set menuIcon "::icon::[::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] [string range $item 1 end]]"
               set compound left
            }
         }
      }

      if {$options(-proc)} {
         set command "gpProc [::gridplus::gpCommandFormat $command]"
      } else {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $command]"
      }

      set state [=% $menuEntryID $state]

      if {$cascade ne ""} {
         $rootMenu$menuName add cascade -label [mc $menuEntryLabel] -menu $cascade -state $state -compound $compound -image $menuIcon -underline $underline
      } else {
         $rootMenu$menuName add command  -label [mc $menuEntryLabel] -command "::gridplus::gpCommand {$command} $options(name) $validate" -state $state -compound $compound -image $menuIcon -underline $underline
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpNotebook                                       #
#        : ::gridplus::gpNotebookSet                                    #
# PURPOSE: Create notebook.                                             #
#=======================================================================#

proc ::gridplus::gpNotebook {} {
   upvar 1 options options

   global {}

   variable gpTabOrder

   if {$options(-subst)} {
      if {[=< substCommandNotebook [=< substCommand 0]]} {
         set options(layout) [subst -nobackslashes $options(layout)]   
      } else {
         set options(layout) [subst -nobackslashes -nocommands $options(layout)]
      }
   }

   ::ttk::notebook $options(name)

   if {$options(-command) ne ""} {
      set command "$options(-command) \[$options(name) index current\] \[$options(name) tab \[$options(name) index current\] -text\];"
   } else {
      set command ""
   }

   bind $options(name) <<NotebookTabChanged>> "${command}::gridplus::gpNotebookSet $options(name)"

   foreach {button item} $options(layout) {
      set pane [winfo name $item]

      $options(name) add [::ttk::frame $options(name).$pane] -text [mc $button]

      pack $item -in $options(name).$pane -expand 1 -fill both
   }

   ::gridplus::gpNotebookSet $options(name)

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }
}

proc ::gridplus::gpNotebookSet {name} {
   global {}

   variable gpInfo
   variable gpValidations

   if {[info exists gpInfo(validation:failed)]} {
      foreach windowValidations [array names ::gridplus::gpValidations] {
         foreach windowValidation $windowValidations {
            foreach validationInfo $::gridplus::gpValidations($windowValidation) {
               foreach {entry validation} [split $validationInfo :] {}
               if {[info exists gpInfo(validation:failed)] && $gpInfo(validation:failed) eq $entry} {
                  if {! [::gridplus::gpValidate $entry $validation focusout - - 1]} {
                     ::gridplus::gpValidateFailed $entry
                  }
               }
            }
         }
      }

      if {[info exists gpInfo(validation:failed)]} {
         ::gridplus::gpNotebookIn $gpInfo(validation:failed)
         return
      }
   }

   variable gpTabOrder

   set pane  [$name index current]
   set panes [$name tabs]
   regsub -all .[winfo name $name] [lindex $panes $pane] {} item

   set gpTabOrder($name:000000) $item

   gpSetTabOrder $name
}

#=======================================================================#
# PROC   : ::gridplus::gpOptionAlias                                    #
# PURPOSE: Set value for option with "alias".                           #
#=======================================================================#

proc ::gridplus::gpOptionAlias {option alias} {
   upvar 1 options options

   if {$options($option) ne ""} {return $options($option)}
   if {$options($alias)  ne ""} {return $options($alias)}

   return {}
}

#=======================================================================#
# PROC   : ::gridplus::gpOptionset                                      #
# PURPOSE: Create optionset.                                            #
#=======================================================================#

proc ::gridplus::gpOptionset {} {
   upvar 1 options options

   variable gpOptionSets

   set gpOptionSets($options(name)) $options(layout)
   
   if {[lsearch $gpOptionSets($options(name)) -style] < 0 && [=< optionsetDefaultStyle 0]} {
         lappend gpOptionSets($options(name)) -style {}
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpPack                                           #
# PURPOSE: Pack specified layout where resizing is required.            #
#=======================================================================#

proc ::gridplus::gpPack {} {
   upvar 1 options options

   if {$options(-resize) eq ""} {
      pack $options(name)
      return
   }

   if {! [regexp -- {(^[.][^.]+)[.]} $options(name) -> window]} {
      set window "."
   }

   set resizeX 0
   set resizeY 0

   switch -- $options(-resize) {
      x  {set resizeX 1}
      y  {set resizeY 1}
      xy {set resizeX 1; set resizeY 1}
   }

   wm minsize $window 1 1

   update idletasks

   pack $options(name) -expand 1 -fill both

   update idletasks

   regexp -- {^([0-9]+)x([0-9]+)} [wm geometry $window] -> width height

   set width  [expr {int(($width  / 100.0) * $options(-minx))}]
   set height [expr {int(($height / 100.0) * $options(-miny))}]

   wm minsize   $window $width   $height
   wm resizable $window $resizeX $resizeY
}

#=======================================================================#
# PROC   : ::gridplus::gpPane                                           #
# PURPOSE: Create paned window.                                         #
#=======================================================================#

proc ::gridplus::gpPane {} {
   upvar 1 options options

   variable gpInfo
   variable gpTabOrder

   ::gridplus::gpLabelframe

   if {[llength [lindex [split $options(layout) "\n"] 0]] > 1} {
      set orient horizontal
   } else {
      set orient vertical
   }

   set paneCount 1

   ::ttk::panedwindow $options(name).pane -height $options(-height) -width $options(-width) -orient $orient
   
   foreach row [split $options(layout) "\n"] {
      set columnCount 0
      
      foreach column $row {
         if {[regexp -- {(^[^:+|=]+)[:+|=]} $column -> column]} {
            set weight 1
         } else {
            set weight 0
         }

         $options(name).pane insert end $column
         
         $options(name).pane pane $column -weight $weight
         
         set gpTabOrder([format "%s:000000%03d" $options(name) $paneCount]) $column
         incr paneCount
      }
   }
   
   pack $options(name).pane -expand 1 -fill both
   
   gpSetTabOrder $options(name)
}

#=======================================================================#
# PROC   : ::gridplus::gpParseEmbeddedGrid                              #
# PURPOSE: If column contains embedded grid, parse it.                  #
#=======================================================================#

proc ::gridplus::gpParseEmbeddedGrid {column} {

   if {! [regexp -- {[|][|:>&<=]} $column]} {return $column}

   set left  {}
   set right {}

   regsub -- {[|]:[|]} $column {|: __gpBar__ |:} column
   regsub -- {[|]>[|]} $column {|> __gpBar__ |:} column
   regsub -- {[|]<[|]} $column {|: __gpBar__ |>} column
   regsub -- {[|]=[|]} $column {|> __gpBar__ |>} column

   if {"||" in $column} {
      regexp -- {^(.*)\|\|(.*)$} $column -> left right 

      if {[regexp -- {[|][:>&]} $left]} {
         set grid [gpEmbeddedGridParse $left]
         set side left
      } else {
         set label $left
      }

      if {[regexp -- {[|][:>&]} $right]} {
         set grid [gpEmbeddedGridParse $right]
         set side right
      } else {
         set label $right
      }
   } else {
      set grid [gpEmbeddedGridParse $column]
      set side both
   }

   switch -- $side {
      left  {return "$grid .:ew $label"}
      right {return "$grid $label .:ew"}
      both  {return "$grid .:ew"}
   }
}

proc ::gridplus::gpEmbeddedGridParse {grid} {

   set columns       {}
   set stretch       {}
   set defaultWidget grid
   set leftStretch   0
   set rightStretch  1
   set style         {}

   if {[regexp -- {^(.+) [|][:]$} $grid -> left]} {
      set grid $left
      set leftStretch  1
      set rightStretch 0
   }

   if {[regexp -- {[|][#]([^ ]*)} $grid -> style]} {
      regsub -- {[|][#]([^ ]*)} $grid {} grid
      if {$style eq ""} {set style %}
   }

   if {[regexp -- {[|][&]([^ ]*)} $grid -> defaultWidget]} {
      regsub -- {[|][&]([^ ]*)} $grid {} grid
      if {$defaultWidget eq ""} {set defaultWidget "grid"}
   }

   while {[regexp -- {^([^|]*)([|][:>])(.*)$} $grid -> left op right]} {
      lappend columns $left
      switch -- $op {
         |: {lappend stretch 0}
         |> {lappend stretch 1;set rightStretch 0}
      }

      set grid $right
   }

   lappend columns $grid

   regsub -- {__gpBar__} $columns {|} columns

   set stretch "$leftStretch $stretch $rightStretch"

   return "{&& {$stretch} {$defaultWidget} {$style} $columns}"
}

#=======================================================================#
# PROC   : ::gridplus::gpParseTags                                      #
# PURPOSE: Parse tags for text widget.                                  #
#=======================================================================#

proc ::gridplus::gpParseTags {name tagText position} {

   regsub -all \{   $tagText {!ob:} tagText
   regsub -all \}   $tagText {!cb:} tagText
   regsub -all {\\} $tagText {!bs:} tagText

   set whitespace " \t\r\n"
   set pattern <(/?)(\[^$whitespace>]+)\[$whitespace]*(\[^>]*)>

   set substitute "\}\n::gridplus::gpInsertText $name {\\2} {\\1} {\\3} $position \{"
   regsub -all $pattern $tagText $substitute tagText

   eval "::gridplus::gpInsertText $name {init} {} {} $position {$tagText}"
}

#=======================================================================#
# PROC   : ::gridplus::gpSet                                            #
# PURPOSE: Gridplus Set values.                                         #
#=======================================================================#

proc ::gridplus::gpSet {} {
   upvar 1 options options

   variable gpConfig
   variable gpInfo
   variable gpValidation

   foreach option [array names options -*] {
      switch -- $option {
         -century {
            set gpConfig(date:century) $options(-century)
         }
         -dateformat {
            switch -- $options(-dateformat) {
               eu {
                  set gpConfig(date:day)       0
                  set gpConfig(date:month)     1
                  set gpConfig(date:year)      2
                  set gpConfig(date:separator) .
               }
               iso {
                  set gpConfig(date:day)       2
                  set gpConfig(date:month)     1
                  set gpConfig(date:year)      0
                  set gpConfig(date:separator) -
               }
               uk {
                  set gpConfig(date:day)       0
                  set gpConfig(date:month)     1
                  set gpConfig(date:year)      2
                  set gpConfig(date:separator) /
               }
               us {
                  set gpConfig(date:day)       1
                  set gpConfig(date:month)     0
                  set gpConfig(date:year)      2
                  set gpConfig(date:separator) /
               }
               default {
                  error "GRIDPLUS ERROR: Invalid date format ($options(-dateformat))"
                  return
               }
            }
            set gpConfig(dateformat) $options(-dateformat)
         }
         -errormessage {
            set gpConfig(errormessage) $options(-errormessage)
         }
         -group {
            set gpInfo(<gpGroupState>$options(-group)) $options(-state)
            ::gridplus::gpSetGroup
         }
         -locale {
            set gpConfig(locale) $options(-locale)
         }
         -prefix {
            set gpConfig(prefix) $options(-prefix)
         }
         -proc {
            set gpConfig(proc) $options(-proc)
         }
         -validation {
            if {$options(-pattern) ne ""} {
               set gpValidation($options(-validation)) $options(-pattern)
               if {$options(-text) ne ""} {
                  set gpValidation($options(-validation):text) $options(-text)
               } else {
                  set gpValidation($options(-validation):text) $options(-validation)
               }
            }

         }
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetFont                                        #
# PURPOSE: Gridplus Set font attributes.                                #
#=======================================================================#

proc ::gridplus::gpSetFont {attributes} {

   set font [dict create {*}[font configure TkDefaultFont]]

   if {[dict get $font -size] < 0} {
      set sign "-"
   } else {
      set sign ""
   }

   foreach attribute $attributes {
      switch -regexp -- $attribute {
         {^[0-9]+$} {
            set font [dict replace $font -size $attribute]
         }
         {^[+][0-9]+$} {
            set font [dict replace $font -size $sign[expr {abs([dict get $font -size]) + $attribute}]]
         }
         {^[-][0-9]+$} {
            set font [dict replace $font -size $sign[expr {abs([dict get $font -size]) - $attribute}]]
         }
         {^bold$} {
            set font [dict replace $font -weight bold]
         }
         {^underline$} {
            set font [dict replace $font -underline 1]
         }
         {^italic$} {
            set font [dict replace $font -slant italic]
         }
      }
   }

   return "[lrange $font 2 end] [lrange $font 0 1]"
}

#=======================================================================#
# PROC   : ::gridplus::gpSetFontSize                                    #
# PURPOSE: Gridplus Set font size for "tagged" text widget.             #
#=======================================================================#

proc ::gridplus::gpSetFontSize {defaultSize newSize} {

   switch -regexp -- $newSize {
      {^[0-9]+$} {
         set fontSize $newSize
      } 
      {^[+][0-9]+$} {
         set value [string range $newSize 1 end]
         set fontSize [expr {$defaultSize + $value}]
      }
      {^[-][0-9]+$} {
         set value [string range $newSize 1 end]
         set fontSize [expr {$defaultSize - $value}]
      }
      default {
         set fontSize $defaultSize
      }
   }

   return $fontSize
}

#=======================================================================#
# PROC   : ::gridplus::gpSetGroup                                       #
# PURPOSE: Gridplus Set widgets state to "group" state.                 #
#=======================================================================#

proc ::gridplus::gpSetGroup {} {
   variable gpInfo

   foreach groupItem [array names gpInfo *:group] {
      set item [string map {:group {}} $groupItem]
      if {[info exists gpInfo(<gpGroupState>$gpInfo($item:group))]} {
         if {[regexp {^([^@]+)@(.+)$} $item -> configureItem index]} {
            $configureItem entryconfigure $index -state $gpInfo(<gpGroupState>$gpInfo($item:group))
         } else {
            if {[string match *Entry [winfo class $item]] && $gpInfo(<gpGroupState>$gpInfo($item:group)) eq "disabled"} {
               $item configure -state [=< entryDisabled readonly]
            } elseif {[winfo class $item] in "TSpinbox TCombobox" && $gpInfo(<gpGroupState>$gpInfo($item:group)) eq "normal"} {
               $item configure -state readonly
            } else {
               $item configure -state $gpInfo(<gpGroupState>$gpInfo($item:group))
            }
         }
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetOptionset                                   #
# PURPOSE: Set optionset options.                                       #
#=======================================================================#

proc ::gridplus::gpSetOptionset {} {
   upvar 1 options options

   variable gpOptionSets

   if {$options(-optionset) eq ""} {
      if {$options(-style) ne "" && [info exists gpOptionSets($options(-style))] && [=< optionSetStyle 1]} {
         set options(-optionset) $options(-style)
      } else {
         return
      }
   }

   if {[info exists gpOptionSets($options(-optionset))]} {
      foreach {option value} $gpOptionSets($options(-optionset)) {
         if {$option eq "-pad"} {
            set options(-padx) $value
            set options(-pady) $value
         } else {
            set options($option) $value
         }
      }
   } else {
      error "GRIDPLUS ERROR: Invalid optionset ($options(-optionset))"
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpSetTabOrder                                    #
# PURPOSE: Gridplus Set widgets to correct "tab" order.                 #
#=======================================================================#

proc ::gridplus::gpSetTabOrder {name} {
   variable gpTabOrder

   foreach item [lsort [array names gpTabOrder $name:*]] {
      raise $gpTabOrder($item)
      ::gridplus::gpSetTabOrder $gpTabOrder($item)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelist                                      #
# PURPOSE: Create tablelist.                                            #
#=======================================================================#

proc ::gridplus::gpTablelist {} {
   upvar 1 options options

   global {}
   
   variable gpInfo

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   set gpInfo($options(name):action)        $options(-action)
   set gpInfo($options(name):columnsort)    $options(-columnsort)
   set gpInfo($options(name):iconlibrary)   [file join $options(-iconpath) $options(-iconfile)]
   set gpInfo($options(name):insertexpr)    $options(-insertexpr)
   set gpInfo($options(name):insertoptions) $options(-insertoptions)
   set gpInfo($options(name):selectfirst)   $options(-selectfirst)
   set gpInfo($options(name):selectmode)    $options(-selectmode)
   set gpInfo($options(name):selectpage)    $options(-selectpage)
   set gpInfo($options(name):sortorder)     $options(-sortorder)
   set gpInfo($options(name):validate)      $options(-validate)
   set gpInfo($options(name):window)        .$window

   set state $options(-state)

   if {$options(-group) ne ""} {
      set gpInfo($options(name).tablelist:group) $options(-group)
   }

   set state [=% $options(name).tablelist $state]

#-------------------------------------#
# Deal with "hide" columns in layout. #
#-------------------------------------#

   set column      -1
   set columnNames {}
   set count        0
   set first        0
   set hide        {}
   set index        0
   set sortInteger {}
   set sortReal    {}

   foreach item $options(layout) {

      if {[string is integer $item]} {
         set  count 0
         incr column
      }
      
      if {$item in {hide integer real} && $count > 1} {
         switch -- $item {
             hide    {lappend hide $column}
             integer {lappend sortInteger $column}
             real    {lappend sortReal $column}
         }
         set options(layout) [lreplace $options(layout) $index $index]
         incr index -1
         if {$item eq "hide" && $column == $first} {
            incr first
         } 
      }
      
      if {[string match =* $item]} {
         lappend columnNames [list $column [string range $item 1 end]]
         set options(layout) [lreplace $options(layout) $index $index]
         incr index -1
      }
      
      incr count
      incr index
   }

   if {$options(-sortfirst)} {
      set gpInfo($options(name):firstcolumn) 0
   } else {
      set gpInfo($options(name):firstcolumn) $first
   }
   
   set gpInfo($options(name):seeinsert) $options(-seeinsert)

   ::gridplus::gpLabelframe

   tablelist::tablelist $options(name).tablelist                        \
                        -columns         $options(layout)               \
                        -exportselection 0                              \
                        -height          $options(-height)              \
                        -listvariable    $options(-listvariable)        \
                        -selectmode      $options(-selectmode)          \
                        -state           $state                         \
                        -stretch         all                            \
                        -width           $options(-width)               \
                        -xscrollcommand  [list $options(name).xbar set] \
                        -yscrollcommand  [list $options(name).ybar set] \
                        -takefocus       $options(-takefocus)           \

   if {$options(-columnsort)} {
      $options(name).tablelist configure -labelcommand ::tablelist::sortByColumn
   }

   ::ttk::scrollbar $options(name).xbar -orient horizontal -command [list $options(name).tablelist xview]
   ::ttk::scrollbar $options(name).ybar -orient vertical   -command [list $options(name).tablelist yview]

   foreach item $hide {
      $options(name).tablelist columnconfigure $item -hide 1
   }

   foreach item $sortInteger {
      $options(name).tablelist columnconfigure $item -sortmode "integer"
   }
   
   foreach item $sortReal {
      $options(name).tablelist columnconfigure $item -sortmode "real"
   }

   foreach item $columnNames {
      $options(name).tablelist columnconfigure [lindex $item 0] -name [lindex $item 1]
   }
   
   if {$options(-names) ne ""} {
      ::gridplus::gpTablelistSetColumns $options(name) -name $options(-names)
   }
   
   grid $options(name).tablelist -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   foreach item $options(-tableoptions) {
      switch -- $item {
         stripe {
            $options(name).tablelist configure -stripebackground #e0e8f0
         }
         separator {
            $options(name).tablelist configure -showseparators yes
         }
      } 
   }

   foreach unknownItem [array names gpInfo <gpUnknown>*] {
      set unknownOption [string map {<gpUnknown> {}} $unknownItem]
      $options(name).tablelist configure $unknownOption $gpInfo($unknownItem)
   }

   if {$options(-proc)} {
      set command "gpProc [::gridplus::gpCommandFormat $options(name)]"
   } else {
      if {$options(-command) eq ""} {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $options(name)]"
      } else {
         set command $options(-command)
      }
   }

   set gpInfo($options(name):command) $command
   
   switch -- $options(-action) {
      double {
         bind [$options(name).tablelist bodypath] <Button-1>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window 0]"
         bind [$options(name).tablelist bodypath] <Double-1>  "after 1 [list ::gridplus::gpCommand [list $command] .$window $options(-validate)]"
         bind [$options(name).tablelist bodypath] <Key-Up>    "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window 0]"
         bind [$options(name).tablelist bodypath] <Key-Down>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window 0]"
         bind [$options(name).tablelist bodypath] <Key-Prior> "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window 0]"
         bind [$options(name).tablelist bodypath] <Key-Next>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window 0]"
 
      }
      single {
         bind [$options(name).tablelist bodypath] <Button-1>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate) [list $command]]"
         bind [$options(name).tablelist bodypath] <Key-Up>    "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate) [list $command]]"
         bind [$options(name).tablelist bodypath] <Key-Down>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate) [list $command]]"
         bind [$options(name).tablelist bodypath] <Key-Prior> "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window $options(-validate) [list $command]]"
         bind [$options(name).tablelist bodypath] <Key-Next>  "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window $options(-validate) [list $command]]"   
      }
      default {
         bind [$options(name).tablelist bodypath] <Button-1> "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate)]"
         bind [$options(name).tablelist bodypath] <Key-Up>   "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate)]"
         bind [$options(name).tablelist bodypath] <Key-Down> "after 1 [list ::gridplus::gpTablelistSelect $options(name) \[$options(name).tablelist curselection\] .$window $options(-validate)]"
         bind [$options(name).tablelist bodypath] <Key-Up>   "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window $options(-validate)]"
         bind [$options(name).tablelist bodypath] <Key-Down> "after 1 [list ::gridplus::gpTablelistSelect $options(name) - .$window $options(-validate)]"
      }
   }

   if {$options(-menu) ne ""} {
      bind [$options(name).tablelist bodypath] <Button-3> "after 1 {::gridplus::gpTablelistMenu $options(-menu) %x %y %X %Y %W $options(name)}"
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsert                                #
# PURPOSE: Inserts line into tablelist.                                 #
#=======================================================================#

proc ::gridplus::gpTablelistInsert {item position line {gpset 0}} {
   variable gpInfo

   set   column    0
   set   tableLine {}

   unset -nocomplain tableIcon

   foreach tableColumn $line {
      if {[regexp -- {^:([^ ]+) ?} $tableColumn -> tableIcon($column)]} {
         regsub -- {^:([^ ]+) ?} $tableColumn {} tableColumn
      }
      lappend tableLine $tableColumn
      incr column
   }

   $item.tablelist insert $position $tableLine

   if {[info exists tableIcon]} {
      foreach iconColumn [array names tableIcon] {
         set icon  $tableIcon($iconColumn)
         set image "::icon::$icon"
         if {$image ni [image names]} {::icons::icons create -file $gpInfo($item:iconlibrary) $icon}
         $item.tablelist cellconfigure $position,$iconColumn -image $image
      }
   }

   gpTablelistInsertExpr $item $line
   
   if {$gpInfo($item:seeinsert) && ! $gpset} {
      update idletasks   
      $item.tablelist see $position
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsertExpr                            #
# PURPOSE: Expand tablelist insert expression.                          #
#=======================================================================#

proc ::gridplus::gpTablelistInsertExpr {name line} {
   upvar 1 options options

   variable gpInfo

   if {$gpInfo($name:insertexpr) eq ""} {
      return
   }

   regsub -all -- {%([0-9][0-9]*)} $gpInfo($name:insertexpr) {[lindex $line \1]} insertExpr

   eval "if {$insertExpr} {set result 1} else {set result 0}"

   if {$result} {
      ::gridplus::gpTablelistInsertOptions $name
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistInsertOptions                         #
# PURPOSE: Process tablelist insert options.                            #
#=======================================================================#

proc ::gridplus::gpTablelistInsertOptions {name} {
   upvar 1 options options

   variable gpInfo

   foreach insertOption $gpInfo($name:insertoptions) {
      if {[lindex $insertOption 0] eq "*"} {
         regsub -- {[*]} $insertOption {end} insertOption
         eval "$name.tablelist rowconfigure $insertOption"
      } else {
         eval "$name.tablelist cellconfigure end,$insertOption"
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistMenu                                  #
# PURPOSE: Right-click pop-up menu for tablelist.                       #
#=======================================================================#

proc ::gridplus::gpTablelistMenu {menu x y X Y W name} {
   global {}

   foreach {Widget xPosition yPosition} [tablelist::convEventFields $W $x $y] {}
   set row [$name.tablelist nearest $yPosition]

   $name.tablelist selection clear 0 end
   $name.tablelist selection set   $row

   set ($name) [$name.tablelist get $row]

   $menu post $X $Y
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistSelect                                #
# PURPOSE: Sets value for tablelist selections.                         #
#=======================================================================#

proc ::gridplus::gpTablelistSelect {name selection window validate {command {}}} {
   upvar 1 options options

   global {}

   variable gpInfo

   if {$selection eq "-"} {
      if {$gpInfo($name:selectpage) && $gpInfo($name:selectmode) eq "browse"} {
         $name.tablelist selection clear 0 end
         $name.tablelist selection set [$name.tablelist index active]
         set selection [$name.tablelist curselection]
      } else {
         return
      }
   }

   set count [llength $selection]
   set value [$name.tablelist get $selection]

   if {$gpInfo($name:selectmode) eq "multiple" || $gpInfo($name:selectmode) eq "extended"} {
      if {$count == 1} {
         set ($name) [list $value]
      } else {
         set ($name) $value
      }
   } else {
      set ($name) $value
   }

   if {$command ne ""} {{*}[list ::gridplus::gpCommand $command $window $validate]}
}

#=======================================================================#
# PROC   : ::gridplus::gpTablelistSetColumns                            #
# PURPOSE: Set tablelist column titles/names.                           #
#=======================================================================#

proc ::gridplus::gpTablelistSetColumns {name option values} {
   
   set column 0
   
   foreach value $values {
      $name.tablelist columnconfigure $column $option $value
      incr column
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpText                                           #
# PURPOSE: Create text.                                                 #
#=======================================================================#

proc ::gridplus::gpText {} {
   upvar 1 options options

   global {}
   
   variable gpInfo

   set state $options(-state)

   if {$options(-group) ne ""} {
      set gpInfo($options(name).text:group) $options(-group)
   }

   set state [=% $options(name).text $state]

   ::gridplus::gpLabelframe

   text $options(name).text                                                                           \
        -background     white                                                                         \
        -height         $options(-height)                                                             \
        -font           TkTextFont                                                                    \
        -state          $state                                                                        \
        -tabs           {0.5c 1c 1.5c 2c 2.5c 3.0c 3.5c 4.0c 4.5c 5.0c 5.5c 6.0c 6.5c 7.0c 7.5c 8.0c} \
        -takefocus      $options(-takefocus)                                                          \
        -width          $options(-width)                                                              \
        -wrap           $options(-wrap)                                                               \
        -xscrollcommand [list $options(name).xbar set]                                                \
        -yscrollcommand [list $options(name).ybar set]                                                \

   ::ttk::scrollbar $options(name).xbar -orient horizontal -command [list $options(name).text xview]
   ::ttk::scrollbar $options(name).ybar -orient vertical   -command [list $options(name).text yview]

   grid $options(name).text -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   set gpInfo($options(name):seeinsert) $options(-seeinsert)
   
   if {$options(-tags)} {
      set normalColor [lindex [split $options(-linkcolor) /] 0]
      set overColor   [lindex [split $options(-linkcolor) /] 1]
      set normalStyle [lindex [split $options(-linkstyle) /] 0]
      set overStyle   [lindex [split $options(-linkstyle) /] 1]

      regsub -- {[&]} $overStyle $normalStyle, overStyle

      if {! [string match */* $options(-linkcolor)]} {set overColor $normalColor}
      if {! [string match */* $options(-linkstyle)]} {set overStyle $normalStyle}

      if {$normalColor eq ""} {set normalColor "blue"}
      if {$overColor   eq ""} {set overColor "blue"}

      if {$normalStyle eq "underline"} {
         set normalStyle "true"
      } else {
         set normalStyle "false"
      }
      if {$overStyle eq "underline"} {
         set overStyle "true"
      } else {
         set overStyle "false"
      }

      set gpInfo($options(name):bgcolor)     white
      set gpInfo($options(name):defaultbg)   white
      set gpInfo($options(name):defaultfg)   black
      set gpInfo($options(name):defaultfont) helvetica
      set gpInfo($options(name):defaultsize) [::gridplus::gpGetFontSize [$options(name).text cget -font]]
      set gpInfo($options(name):fgcolor)     black
      set gpInfo($options(name):font)        [lindex [$options(name).text cget -font] 0]
      set gpInfo($options(name):iconlibrary) [file join $options(-iconpath) $options(-iconfile)]
      set gpInfo($options(name):indent)      0
      set gpInfo($options(name):link)        blue
      set gpInfo($options(name):linkcursor)  $options(-linkcursor)
      set gpInfo($options(name):normalcolor) $normalColor
      set gpInfo($options(name):normalstyle) $normalStyle
      set gpInfo($options(name):overcolor)   $overColor
      set gpInfo($options(name):overstyle)   $overStyle
      set gpInfo($options(name):prefix)      $options(-prefix)
      set gpInfo($options(name):proc)        $options(-proc)
      set gpInfo($options(name):size)        [::gridplus::gpGetFontSize [$options(name).text cget -font]]
      set gpInfo($options(name):tagid)       0
      set gpInfo($options(name):tags)        1

      $options(name).text configure -cursor {} -state disabled
   } else {
      if {$options(-font) ne ""} {
         $options(name).text configure -font $options(-font)
      }

      set gpInfo($options(name):tags)        0
   }

   if {$options(-menu) eq ""} {
      set menuName $options(name).text.edit
      
      menu $menuName -tearoff 0

      if {$options(-tags) || $options(-state) eq "disabled"} {
         $options(name).text.edit add command -label [mc "Copy"]  -command "tk_textCopy $options(name).text"
         $options(name).text.edit add separator
         $options(name).text.edit add command -label [mc "Find"]  -command "::gridplus::gpTextFind $options(name).text"
      } else {
         $options(name).text.edit add command -label [mc "Cut"]   -command "tk_textCut $options(name).text;$options(name).text edit modified 1"
         $options(name).text.edit add command -label [mc "Copy"]  -command "tk_textCopy $options(name).text"
         $options(name).text.edit add command -label [mc "Paste"] -command "tk_textPaste $options(name).text;$options(name).text edit modified 1"
         $options(name).text.edit add separator
         $options(name).text.edit add command -label [mc "Find"]  -command "::gridplus::gpTextFind $options(name).text"
      }
   } else {
      set menuName $options(-menu)
   }

   if {$options(-command) ne ""} {
      bind $options(name).text <<Modified>> "::gridplus::gpTextSet $options(name) ; eval $options(-command)"
   } else {
      bind $options(name).text <<Modified>> "::gridplus::gpTextSet $options(name)"
   }
 
   bind $options(name).text <ButtonPress-3> "tk_popup $menuName %X %Y"
   bind $options(name).text <Tab>           "[bind all <Tab>];break"
   bind $options(name).text <Shift-Tab>     "[bind all <<PrevWindow>>]; break"

   set ($options(name)) {}

   if {$options(-autogroup) ne ""} {
      set autoGroupCommand "::gridplus::gpAutoGroup $options(name) $options(-autogroup) normal"
      trace add variable ($options(name)) write $autoGroupCommand
   }

}

#=======================================================================#
# PROC   : ::gridplus::gpTextSet                                        #
# PURPOSE: Set contents of GRIDPLUS Text.                               #
#=======================================================================#

proc ::gridplus::gpTextSet {item} {
   global {}

   if {[$item.text edit modified]} {
      set ($item) {}

      foreach {key text index} [$item.text dump -text 1.0 end] {
         set ($item) "$($item)$text"
      }

      $item.text edit modified 0
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTextInsert                                     #
# PURPOSE: Inserts line into text.                                      #
#=======================================================================#

proc ::gridplus::gpTextInsert {item position line} {
   variable gpInfo

   set textState [$item.text cget -state]

   $item.text configure -state normal

   if {$position eq "end"} {
      set insertPosition end
   } else {
      set insertPosition $position.0
   }

   if {$gpInfo($item:tags)} {
      if {$position eq "end"} {
         ::gridplus::gpParseTags $item $line $insertPosition
         $item.text insert $insertPosition "\n"
      } else {
         $item.text insert $position.0 "\n"
         ::gridplus::gpParseTags $item $line $position.end
      }
      $item.text tag raise sel
   } else {
      $item.text insert $insertPosition "$line\n"
      $item.text edit modified 0
      set ($item) {}
      foreach {key text index} [$item.text dump -text 1.0 end] {
         set ($item) "$($item)$text"
      }
   }

   $item.text configure -state $textState
   
   if {$gpInfo($item:seeinsert)} {
      update idletasks   
      $item.text see $insertPosition
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind                                       #
# PURPOSE: Find string in GRIDPLUS Text.                                #
#=======================================================================#

proc ::gridplus::gpTextFind {item} {
   variable gpInfo

   if {[winfo exists .gpTextFind]} {
      ::gridplus::gpTextFind:action,cancel
   }

   if {[string match *?.text $item]} {
      set gpInfo(<gpTextFindItem>) $item
   } else {
      set gpInfo(<gpTextFindItem>) $item.text
   }

   gridplus window .gpTextFind -topmost 1 -wcmd ::gridplus::gpTextFind:action,cancel -wtitle Find

   gridplus checkbutton .gpTextFind.match -padding 0 {
      {.word "Match whole word only"}
      {.case "Match case"}
   }

   gridplus radiobutton .gpTextFind.direction -title Direction {
      {. Up -backwards} {. Down +forwards}
   }

   gridplus button .gpTextFind.action -prefix gridplus:: {
      {&e "Find What: " .string 38 + >next ~gpTextFind.action,next} {"Find Next" .next < %next}
      {@gpTextFind.match |> @gpTextFind.direction}                  {"Cancel" .cancel}
   }

   pack .gpTextFind.action
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind:action,next                           #
# PURPOSE: Find next/previous occurance of string in GRIDPLUS Text.     #
#=======================================================================#

proc ::gridplus::gpTextFind:action,next {} {
   global {}

   variable gpInfo

   if {$(.gpTextFind.direction) eq "forwards"} {
      set searchIndex "insert+1char"
   } else {
      set searchIndex "insert"
   }

   if {$(.gpTextFind.match,word)} {
      set matchWord "-regexp"
      set pattern "\[\[:<:\]\]$(.gpTextFind.action,string)\[\[:>:\]\]"
   } else {
      set matchWord "-exact"
      set pattern "$(.gpTextFind.action,string)"
   }

   if {$(.gpTextFind.match,case)} {
      set matchCase "--"
   } else {
      set matchCase "-nocase"
   }

   set position [$gpInfo(<gpTextFindItem>) search -$(.gpTextFind.direction) $matchWord $matchCase $pattern $searchIndex]

   if {$position ne ""} {
      catch "$gpInfo(<gpTextFindItem>) tag remove sel sel.first sel.last"
      $gpInfo(<gpTextFindItem>) tag add sel $position $position+[string length $(.gpTextFind.action,string)]chars
      $gpInfo(<gpTextFindItem>) configure -inactiveselectbackground [$gpInfo(<gpTextFindItem>) cget -selectbackground]
      $gpInfo(<gpTextFindItem>) mark set insert $position
      $gpInfo(<gpTextFindItem>) see $position
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpTextFind:action,cancel                         #
# PURPOSE: Cancel/close Find dialog.                                    #
#=======================================================================#

proc ::gridplus::gpTextFind:action,cancel {} {
   global {}

   variable gpInfo

   set gpInfo(<gpTextFindItem>) {}

   gridplus clear .gpTextFind
   destroy .gpTextFind
}

#=======================================================================#
# PROC   : ::gridplus::gpTree                                           #
# PURPOSE: Create tree.                                                 #
#=======================================================================#

proc ::gridplus::gpTree {} {
   upvar 1 options options

   global {}

   variable gpInfo

   if {! [regexp -- {^[.]([^.]+)[.]} $options(name) -> window]} {
      set window {}
   }

   set gpInfo($options(name):action)       $options(-action)
   set gpInfo($options(name):fileicon)     $options(-fileicon)
   set gpInfo($options(name):foldericon)   $options(-foldericon)
   set gpInfo($options(name):iconlibrary)  [file join $options(-iconpath) $options(-iconfile)]
   set gpInfo($options(name):icons)        $options(-icons)
   set gpInfo($options(name):open)         $options(-open)
   set gpInfo($options(name):validate)     $options(-validate)
   set gpInfo($options(name):window)       .$window

   ::gridplus::gpLabelframe

   ::ttk::treeview $options(name).tree                 \
        -cursor         left_ptr                       \
        -height         $options(-height)              \
        -show           $options(-show)                \
        -xscrollcommand [list $options(name).xbar set] \
        -yscrollcommand [list $options(name).ybar set]

   $options(name).tree column #0 -width $options(-width)

   ::ttk::scrollbar $options(name).xbar -orient horizontal -command [list $options(name).tree xview]
   ::ttk::scrollbar $options(name).ybar -orient vertical   -command [list $options(name).tree yview]

   grid $options(name).tree -row 0 -column 0 -sticky news

   switch -- $options(-scroll) {
      x {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
      }
      y {
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
      xy {
         grid $options(name).xbar -row 1 -column 0 -sticky ew
         grid $options(name).ybar -row 0 -column 1 -sticky ns
      }
   }

   grid rowconfigure    $options(name) 0 -weight 1
   grid columnconfigure $options(name) 0 -weight 1

   if {$options(-proc)} {
      set command "gpProc [::gridplus::gpCommandFormat $options(name)]"
   } else {
      if {$options(-command) eq ""} {
         set command "$options(-prefix)[::gridplus::gpCommandFormat $options(name)]"
      } else {
         set command $options(-command)
      }
   }

   set gpInfo($options(name):command) $command

   switch -- $options(-action) {
      double {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window 0]"
         bind $options(name).tree <Double-1> "after 1 [list ::gridplus::gpCommand [list $command] .$window $options(-validate)]"
      }
      single {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate) [list $command]]"
      }
      single/space {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate) [list $command]]"
         bind $options(name).tree <space>    "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate) [list $command]]"
      }
      default {
         bind $options(name).tree <Button-1> "after 1 [list ::gridplus::gpTreeSelect $options(name) .$window $options(-validate)]"
      }
   }

   if {$options(-menu) ne ""} {
      bind $options(name).tree <Button-3> "after 1 {::gridplus::gpTreeMenu $options(-menu) %x %y %X %Y %W $options(name)}"
   }

   if {[lsearch [image names] ::icon::$options(-fileicon)] < 0} {
      ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $options(-fileicon)
   }
   if {[lsearch [image names] ::icon::$options(-foldericon)] < 0} {
      ::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $options(-foldericon)
   }

   set ($options(name)) {}
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeMenu                                       #
# PURPOSE: Right-click pop-up menu for tree.                            #
#=======================================================================#

proc ::gridplus::gpTreeMenu {menu x y X Y W name} {
   global {}

   $name.tree selection remove $($name)

   set item [lindex [$name.tree identify $x $y] 1]

   $name.tree selection set $item

   set ($name) [$name.tree selection]

   $menu post $X $Y
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeSelect                                     #
# PURPOSE: Sets value for tree selections.                              #
#=======================================================================#

proc ::gridplus::gpTreeSelect {name window validate {command {}}} {
   global {}

   set ($name) [regsub -all "\034" [$name.tree selection] { }]

   if {$command ne ""} {{*}[list ::gridplus::gpCommand $command $window $validate]}
}

#=======================================================================#
# PROC   : ::gridplus::gpTreeSet                                        #
# PURPOSE: Set contents of GRIDPLUS Tree.                               #
#=======================================================================#

proc ::gridplus::gpTreeSet {name nodes} {
   variable gpInfo

   $name.tree delete [$name.tree children {}]

   foreach node $nodes {
      set icon     {}
      set nodeText {}
      set nodeType file

      foreach item $node {
         switch -regexp -- $item {
            ^: {
               set icon [string range $item 1 end]
            }
            ^[+]$ {
               set nodeType folder
            }
            ^[/] {
               regsub -all { } $item "\034" nodeFullName
            }
            default {
               set nodeText $item
            }
         }
      }

      if {! [regexp {^(.*/)([^/]+)$} $nodeFullName -> path nodeName]} {
         set path     $nodeFullName
         set nodeName $nodeFullName
         set indent   ""
      }

      if {$nodeText ne ""} {
         set nodeName $nodeText
      } else {
         regsub -all "\034" $nodeName { } nodeName
      }

      set nodeName [mc $nodeName]

      if {$icon eq ""} {
         set icon $gpInfo($name:${nodeType}icon)
      } else {
         if {[lsearch [image names] ::icon::$icon] < 0} {
            ::icons::icons create -file $gpInfo($name:iconlibrary) $icon
         }
      }

      if {$path eq "/"} {
         set parent {}
      } else {
         regsub -- {/$} $path {} parent
      }

      if {$gpInfo($name:icons)} {
         $name.tree insert $parent end -id $nodeFullName -image ::icon::$icon -open $gpInfo($name:open) -text $nodeName
      } else {
         $name.tree insert $parent end -id $nodeFullName -open $gpInfo($name:open) -text $nodeName
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidate                                       #
# PURPOSE: Validates contents of entry.                                 #
#=======================================================================#

proc ::gridplus::gpValidate {item validation condition prevalue fixed auto} {
   global {}

   variable gpConfig
   variable gpInfo
   variable gpValidateError
   variable gpValidation

   set focus [focus]

   if {$focus ne ""} {
      set focusClass         [winfo class $focus]
      set focusToplevel      [winfo toplevel $focus]
      # Set toplevel to modal if unknown (for Tk dialogs?)
      if {[info exists gpInfo($focusToplevel:modal)]} {
         set focusToplevelModal $gpInfo($focusToplevel:modal)
      } else {
         set focusToplevelModal 1
      }
   } else {
      set focusClass         ""
      set focusToplevel      ""
      set focusToplevelModal 0
   }

   if {[info exists gpInfo(validation:failed)]} {
      set failedItem              $gpInfo(validation:failed)
      set failedItemToplevel      [winfo toplevel $failedItem]
      set failedItemToplevelModal $gpInfo($failedItemToplevel:modal)
   } else {
      set failedItem              ""
      set failedItemToplevel      ""
      set failedItemToplevelModal 0
   }

   set itemToplevel      [winfo toplevel $item]
   set itemToplevelModal $gpInfo($itemToplevel:modal)

   if {[info exists gpInfo($focus:validationmode)]} {
      set validationMode $gpInfo($focus:validationmode)
   } else {
      set validationMode ""
   }

   switch -- $condition {
      focusout {
         if {$focusToplevel ne $itemToplevel && $focusToplevelModal} {
            return 1
         }
         if {$failedItem ne "" && $failedItem ne $item} {
            if {$failedItemToplevel ne $itemToplevel && $itemToplevelModal} {
               unset -nocomplain gpInfo(validation:failed)
            }

            return 1
         }
      }

      focusin {
         if {$failedItem ne ""} {
            if {$itemToplevelModal && ! $failedItemToplevelModal} {
               $failedItem configure -foreground black

               if {[set window $failedItemToplevel] eq "."} {
                  set window {}
               }

               if {[winfo exists $window.errormessage]} {
                  $window.errormessage configure -text {}
               }

               unset -nocomplain gpInfo(validation:failed)

               ::gridplus::gpValidateErrorCancel - - 0

               return 1
            }

            if {$failedItemToplevel ne $itemToplevel} {
               focus $failedItem
               return 1
            }
         }
      }

      key {
         if {[string length $prevalue] > $fixed} {
            return 0
         }
         return 1
      }
   }

   if {$validation eq "__gpFixed__" || $condition ne "focusout" || ! $auto} {
      return 1
   }

   if {$focusClass in "Button TButton" && $validationMode ne "focus" && $prevalue ne "-"} {
      return 1
   }

   if {! [regexp {^([.][^.,]+)} $item -> window]} {
      set window {}
   } else {
      if {[winfo class $window] ne "Toplevel"} {
         set window {}
      }
   }

   set validationOK 0

   regexp -- {@?([^:?]+)(:([^?]*))*([?](.*))*} $validation -> validationName -> parameter -> errorText

   if {[string match @* $validation] && $($item) eq ""} {
      set validationOK 1
   } else {
      switch -glob -- $gpValidation($validationName) {
         proc:* {
            set validateProc [string range $gpValidation($validationName) 5 end]
            if {[$validateProc $item $parameter]} {
               set validationOK 1
            }
         }
         trim:* {
            set ($item) [string trim $($item)]
            if {[regexp [string range $gpValidation($validationName) 5 end] $($item)]} {
               set validationOK 1
            }
         }
         default {
            if {[regexp $gpValidation($validationName) $($item)]} {
               set validationOK 1
            }
         }
      }
   }

   if $validationOK {
      $item configure -foreground black

      if {[winfo exists $window.errormessage]} {
         $window.errormessage configure -text {}
      }

      unset -nocomplain gpInfo(validation:failed)

      ::gridplus::gpValidateErrorCancel - - 0

      return 1
   } else {
      if {$focus ne ""} {
         ::gridplus::gpNotebookIn $item
      }

      update idletasks

      set gpInfo(validation:failed) $item

      return 0
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateFailed                                 #
# PURPOSE: Sets focus to failed validation entry.                       #
#=======================================================================#

proc ::gridplus::gpValidateFailed {item} {

   variable gpInfo

   if {! [winfo exists $item]} {
      return
   }

   set focus [focus]

   if {[string compare {} $focus] && [winfo class $focus] eq "Entry"} {
      $focus selection clear

      if {[regexp {^(focus(out)?|all)} [set validate [$focus cget -validate]]]} {
         $focus configure -validate none
         after idle [list $focus configure -validate $validate]
      }
   }

   if {[info exists gpInfo(validation:failed)]} {
      after 1 "[list focus $item]; ::gridplus::gpValidateErrorDisplay $item"
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateErrorDisplay                           #
# PURPOSE: Display validation error messages.                           #
#=======================================================================#

proc ::gridplus::gpValidateErrorDisplay {item} {
   variable gpValidateError

   if {! [regexp {^([.][^.,]+)} $item -> window]} {
      set window {}
   } else {
      if {[winfo class $window] ne "Toplevel"} {
         set window {}
      }
   }

   if {[winfo exists $window.errormessage]} {
      $window.errormessage configure -text $gpValidateError($item:text)
   }

   if {$gpValidateError($item:popup)} {
      ::gridplus::gpValidateErrorShow $item
   }

   $item configure -foreground red
}

#=======================================================================#
# PROCS  : ::gridplus::gpValidateErrorInit                              #
#        : ::gridplus::gpValidateErrorCancel                            #
#        : ::gridplus::gpValidateErrorShow                              #
# PURPOSE: Gridplus widget validation "pop-up" error message.           #
#=======================================================================#

proc ::gridplus::gpValidateErrorInit {item message {mode label}} {
   variable gpValidateError

   if {! [winfo exists .gpValidateError]} {
      toplevel .gpValidateError -background black -borderwidth 1 -relief flat
      label    .gpValidateError.message -background red -foreground white
      pack     .gpValidateError.message
      wm overrideredirect .gpValidateError 1
      wm withdraw         .gpValidateError
   }

   if {$mode eq "popup"} {
      set gpValidateError($item:popup) 1
   } else {
      set gpValidateError($item:popup) 0
   }

   set gpValidateError($item:text) $message
}

proc ::gridplus::gpValidateErrorCancel {testWindow eventWindow binding} {
   variable gpInfo
   variable gpValidateError

   if {! $binding && [info exists gpInfo(validation:failed)]} {
      return 1
   }

   if {$testWindow eq $eventWindow} {
      if {[winfo exists .gpValidateError]} {
         wm withdraw .gpValidateError
      }
   }
}

proc ::gridplus::gpValidateErrorShow {item} {
   variable gpValidateError

   .gpValidateError.message configure -text $gpValidateError($item:text)
 
   set helpX [expr [winfo rootx $item] + 10]
   set helpY [expr [winfo rooty $item] + [expr {[winfo height $item] - 1}]]
 
   wm geometry  .gpValidateError +$helpX+$helpY
   wm deiconify .gpValidateError

   raise .gpValidateError
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateText                                   #
# PURPOSE: Returns formatted validation message text.                   #
#=======================================================================#

proc ::gridplus::gpValidateText {validation} {
   variable gpConfig
   variable gpValidation

   regexp -- {@?([^:?]+)(:([^?]*))*([?](.*))*} $validation -> validationName -> parameter -> errorText

   if {$errorText eq ""} {
      set errorText    [mc $gpValidation($validationName:text)]
      set errorMessage [mc $gpConfig(errormessage)]
      regsub {%} $errorText    $parameter errorText
      regsub {%} $errorMessage $errorText errorMessage
      return $errorMessage
   } else {
      return $errorText
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpValidateDate                                   #
# PURPOSE: Validates for valid date.                                    #
#=======================================================================#

proc ::gridplus::gpValidateDate {entry parameter} {
   global {}

   foreach {month day year} [::gridplus::gpFormatDate $($entry) internal] {}

   set day    [scan $day   "%d"]
   set month  [scan $month "%d"]
   set result 0

   if {$month < 1 || $month > 12} {
      return 0
   } else {
      if {$day < 1 || $day > [::gridplus::gpCalMonthDays $month $year]} {
         return 0
      } else {
         set ($entry) [::gridplus::gpFormatDate $($entry) application]
         $entry configure -validate focusout
         return 1
      }
   }
}

#=======================================================================#
# PROCS  : ::gridplus::gpGridIn                                         #
#        : ::gridplus::gpPackIn                                         #
#        : ::gridplus::gpNotebokIn                                      #
# PURPOSE: If validated entry in notebook select pane containing entry. #
#=======================================================================#

proc ::gridplus::gpGridIn {name} {

   array set info [grid info $name]

   if {[info exists info(-in)]} {
      return $info(-in)
   } else {
      return {}
   }
}

proc ::gridplus::gpPackIn {name} {
   
   if {! [catch "pack info $name"]} {
      array set info [pack info $name]
      return $info(-in)
   } else {
      return {}
   }
}

proc ::gridplus::gpNotebookIn {name} {
   global {}

   variable gpTabOrder

   set in $name

   while {[set in [gpGridIn $in]] ne ""} {
      set lastIn $in
   }

   set in $lastIn

   while {[set in [gpPackIn $in]] ne ""} {
      set lastIn $in
   }

   set toplevelLastIn {}

   if {[winfo class $lastIn] eq "Toplevel"} {
      foreach item [array names ::gridplus::gpInfo *:in] {
         if {$::gridplus::gpInfo($item) eq $lastIn} {
            set in [lindex [split $item :] 0]
            set toplevelLastIn $in
            while {[set in [gpPackIn $in]] ne ""} {
               set lastIn $in
            }
         }
      }
   }

   if {[regexp -- {(.*)[.]([^.]+$)} $lastIn -> containedIn]} {

      if {$containedIn eq "" && $toplevelLastIn ne ""} {
         gpNotebookIn $toplevelLastIn
      } elseif {[winfo exists $containedIn] && [winfo class $containedIn] eq "TNotebook"} {
         $containedIn select $lastIn

         set pane  [$containedIn index current]
         set panes [$containedIn tabs]

         regsub -all .[winfo name $containedIn] [lindex $panes $pane] {} item

         set gpTabOrder($containedIn:000000) $item

         gpSetTabOrder $containedIn
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpFormatDate                                     #
# PURPOSE: Converts date format for validation and display.             #
#=======================================================================#

proc ::gridplus::gpFormatDate {date mode} {
   variable gpConfig

   if {$gpConfig(dateformat) eq "iso"} {
      switch -regexp -- $date {
            {^[0-9]{8}$} {
            set part(0) [string range $date 0 3]
            set part(1) [string range $date 4 5]
            set part(2) [string range $date 6 7]
         }
         {^[0-9]{4}-[0-9]{2}-[0-9]{2}$}  {
            set part(0) [string range $date 0 3]
            set part(1) [string range $date 5 6]
            set part(2) [string range $date 8 9]
         }
         default  {
            set part(0) 0
            set part(1) 0
            set part(2) 0
         }
      }  
   } else {
      switch -regexp -- $date {
         {^[0-9]{6}$} {
            set part(0) [string range $date 0 1]
            set part(1) [string range $date 2 3]
            set part(2) [string range $date 4 5]
            if {$part(2) <= $gpConfig(date:century)} {
               set part(2) "20$part(2)"
            } else {
               set part(2) "19$part(2)"
            }
         }
         {^[0-9]{8}$} {
            set part(0) [string range $date 0 1]
            set part(1) [string range $date 2 3]
            set part(2) [string range $date 4 7]
         }
         {^[0-9]{2}.[0-9]{2}.[0-9]{4}$}  {
            set part(0) [string range $date 0 1]
            set part(1) [string range $date 3 4]
            set part(2) [string range $date 6 9]
         }
         default  {
            set part(0) 0
            set part(1) 0
            set part(2) 0
         }
      }
   }

   set separator $gpConfig(date:separator)

   if {[string equal $mode internal]} {
      return "$part($gpConfig(date:month)) $part($gpConfig(date:day)) $part($gpConfig(date:year))"
   } else {
      return $part(0)$separator$part(1)$separator$part(2)
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpCalCheckDate                                   #
# PURPOSE: Checks for valid date.                                       #
#=======================================================================#

proc ::gridplus::gpCalCheckDate {month day year} {

   set result 0

   if {[scan $month %d] < 1 || [scan $month %d] > 12} {
      return 0
   } else {
      if {[scan $day %d] < 1 || [scan $day %d] > [::gridplus::gpCalMonthDays $month $year]} {
         return 0
      } else {
         return 1
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpCalDayNames                                    #
# PURPOSE: Returns day name header information.                         #
#=======================================================================#

proc ::gridplus::gpCalDayNames {weekstart} {
   variable gpConfig

   set basetime 1220223600
   set daynames {}

   for {set day [expr {$weekstart - 1}]} {$day < [expr {$weekstart + 6}]} {incr day} {
      lappend daynames [string range [clock format [clock add $basetime $day day] -format %a -locale $gpConfig(locale)] 0 1]
   }
   
   return $daynames
}

#=======================================================================#
# PROC   : ::gridplus::gpCalMonthDays                                   #
# PURPOSE: Returns number of days for specified month/year.             #
#=======================================================================#

proc ::gridplus::gpCalMonthDays {month year} {
   array set days {
       1 31
       2 28
       3 31
       4 30
       5 31
       6 30
       7 31
       8 31
       9 30
      10 31
      11 30
      12 31
   }

   if {[clock format [clock add [clock scan 28/02/${year} -format "%d/%m/%Y"] 1 day] -format %d] eq "29"} {
      set days(2) 29
   }

   return $days([scan $month "%d"])
}

#=======================================================================#
# PROC   : ::gridplus::gpWindow                                         #
# PURPOSE: Create toplevel window with "modal" option.                  #
#=======================================================================#

proc ::gridplus::gpWindow {} {
   upvar 1 options options

   variable gpInfo

   set options(-windowcommand) [::gridplus::gpOptionAlias -windowcommand -wcmd]

   if {[winfo exists $options(name)] && $options(-in) eq ""} {
      if {! $gpInfo($options(name):toplevel)} {
         return 0
      }

      if {$options(-windowcommand) ne ""} {
         wm protocol $options(name) WM_DELETE_WINDOW "after 1 {$options(-windowcommand)}"
      }
      if {$options(-wtitle) ne ""} {
         wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
      }
      return 0
   }

   regsub -- {%c} $options(-windowcommand) "::gridplus::gridplus clear $options(name)"
   regsub -- {%d} $options(-windowcommand) "destroy $options(name)"

   set gpInfo($options(name):modal) 0

   if {$options(-in) ne ""} {
      if {[info exists gpInfo($options(-in):wcmd)]} {
         eval $gpInfo($options(-in):wcmd)
      }

      if {[winfo exists $options(-in).container]} {
         destroy $options(-in).container
      }

      frame $options(-in).container -container 1

      set gpInfo($options(-in):container) [winfo id $options(-in).container]

      grid $options(-in).container -sticky  $gpInfo($options(-in):sticky)
      grid rowconfigure    $options(-in) $options(-in).container -weight 1
      grid columnconfigure $options(-in) $options(-in).container -weight 1

      toplevel $options(name) -use $gpInfo($options(-in):container)

      set gpInfo($options(name):toplevel) 0

      if {$gpInfo([winfo toplevel $options(-in)]:modal)} {
         set gpInfo($options(name):modal) 1
      } else {
         set gpInfo($options(name):modal) 0
      }

      ::gridplus::gpEditMenuCreate $options(name)

      if {$options(-windowcommand) ne ""} {
         set gpInfo($options(-in):wcmd) "$options(-windowcommand)"
      } else {
         set gpInfo($options(-in):wcmd) "::gridplus::gridplus clear $options(name);destroy $options(name)"
      }

      set gpInfo($options(-in):in) $options(name)

      return 1
   } else {
      set gpInfo($options(name):toplevel) 1

      if {$options(-modal)} {
         set gpInfo($options(name):modal) 1
      }

      toplevel $options(name)
      wm overrideredirect $options(name) $options(-overrideredirect)

      bind $options(name) <Configure> "::gridplus::gpWindowBindings $options(name) %W 1"
      bind $options(name) <Destroy>   "::gridplus::gpWindowBindings $options(name) %W 1"
      bind $options(name) <Unmap>     "::gridplus::gpWindowBindings $options(name) %W 1"
   }

   wm attributes $options(name) -topmost $options(-topmost)

   bind $options(name) <Destroy> "::gridplus::gpWidgetHelpCancel;::gridplus::gpValidateErrorCancel $options(name) %W 1"

   ::gridplus::gpEditMenuCreate $options(name)

   wm resizable $options(name) 0 0

   if {$options(-windowcommand) ne ""} {
      wm protocol $options(name) WM_DELETE_WINDOW "after 1 {$options(-windowcommand)}"
   } else {
      wm protocol $options(name) WM_DELETE_WINDOW "after 1 {::gridplus::gridplus clear $options(name);destroy $options(name)}"
   }

   if {$options(-wtitle) ne ""} {
      wm title [winfo toplevel $options(name)] [mc $options(-wtitle)]
   }

   if {$options(-modal)} {
      bind modalWindow <ButtonPress> {wm deiconify %W;raise %W}
      bindtags $options(name) [linsert [bindtags $options(name)] 0 modalWindow]
      wm deiconify $options(name)
      tkwait visibility $options(name)
      grab set $options(name)
   }

   return 1
}

#=======================================================================#
# PROC   : ::gridplus::gpWindowBindings                                 #
# PURPOSE: Process window bindings.                                     #
#=======================================================================#

proc ::gridplus::gpWindowBindings {testWindow eventWindow binding} {

   ::gridplus::gpWidgetHelpCancel
   ::gridplus::gpValidateErrorCancel $testWindow $eventWindow $binding
   ::gridplus::gpDateSelectorUnpost  $testWindow
}

#=======================================================================#
# PROC   : ::gridplus::gpclear                                          #
# PURPOSE: Clear selected text for item.                                #
#=======================================================================#

proc ::gridplus::gpclear {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      event generate $textItem <<Clear>>
      $textItem edit modified 1
   } else {
      event generate $item <<Clear>>
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpcopy                                           #
# PURPOSE: Perform clipboard copy for item.                             #
#=======================================================================#

proc ::gridplus::gpcopy {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textCopy $textItem
   } else {
      clipboard clear
      catch {clipboard append [selection get]}
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpcut                                            #
# PURPOSE: Perform clipboard cut for item.                              #
#=======================================================================#

proc ::gridplus::gpcut {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textCut $textItem
      $textItem edit modified 1
   } else {
      clipboard clear
      catch {clipboard append [selection get]}
      catch {$item delete sel.first sel.last}
   }
}


#=======================================================================#
# PROC   : ::gridplus::gpdate                                           #
# PURPOSE: Returns (calculated) date in "-dateformat".                  #
#=======================================================================#

proc ::gridplus::gpdate {{action {@}} {date {}}} {
   variable gpConfig

   # Run initialisation if neccessary.
   if {! [info exists gpConfig]} {
      gpInit
   }

   set unitCode  [string index $action 0]
   set increment [string range $action 1 end]

   switch -- $gpConfig(dateformat) {
      eu  {set dateFormat "%d.%m.%Y"}
      iso {set dateFormat "%Y-%m-%d"}
      uk  {set dateFormat "%d/%m/%Y"}
      us  {set dateFormat "%m/%d/%Y"}
   }

   if {$date eq ""} {
      set clockSeconds [clock seconds]
   } else {
      set clockSeconds [clock scan $date -format $dateFormat]
   }

   switch -- $unitCode {
      @       {return [clock format $clockSeconds -format $dateFormat]}
      +       {set unit "day"}
      -       {set unit "day";set increment "-$increment"}
      >       {set unit "month"}
      <       {set unit "month";set increment "-$increment"}
      default {return $action}
   }
   
   return [clock format [clock add $clockSeconds $increment $unit] -format $dateFormat]
}

#=======================================================================#
# PROC   : ::gridplus::gpdefault                                        #
# PURPOSE: Set default values for Gridplus "variable(s)".               #
#=======================================================================#

proc ::gridplus::gpdefault {args} {

   variable gpInfo

   switch -- [llength $args] {
      1 {
         if {[expr [llength [lindex $args 0]] % 2] != 0} {
            error "GRIDPLUS ERROR: (gpdefault) Unmatched item/value."
         }
         foreach {item value} [lindex $args 0] {
            set gpInfo(default:$item) $value
         }
      }
      2 {
         set item  [lindex $args 0]
         set value [lindex $args 1]
         set gpInfo(default:$item) $value
      }
      default {
         error "GRIDPLUS ERROR: (gpdefault) Wrong number of Args."
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpfind                                           #
# PURPOSE: Find next/previous occurance of string in GRIDPLUS Text.     #
#=======================================================================#

proc ::gridplus::gpfind {item pattern {direction forwards}} {
   global {}

   if {$direction eq "forwards"} {
      set searchIndex "insert+1char"
   } else {
      set searchIndex "insert"
   }

   set position [$item.text search -$direction -exact -nocase -- $pattern $searchIndex]

   if {$position ne ""} {
      catch "$item.text tag remove sel sel.first sel.last"
      $item.text tag add sel $position $position+[string length $pattern]chars
      $item.text configure -inactiveselectbackground [$item.text cget -selectbackground]
      $item.text mark set insert $position
      $item.text see $position
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpfind_dialog                                    #
# PURPOSE: Display find dialog for specified GRIDPLUS text item.        #
#=======================================================================#

proc ::gridplus::gpfind_dialog {item} {

   ::gridplus::gpTextFind $item
}

#=======================================================================#
# PROC   : ::gridplus::gpinsert                                         #
# PURPOSE: Inserts line into tablelist/text.                            #
#=======================================================================#

proc ::gridplus::gpinsert {name position line} {
   global {}

   variable gpInfo

   if {[winfo exists $name.tablelist]} {
      ::gridplus::gpTablelistInsert $name $position $line
   } elseif {[winfo exists $name.text]} {
      ::gridplus::gpTextInsert $name $position $line
   } else {
      error "GRIDPLUS ERROR: (gpinsert) Widget \"$name\" is not tablelist or text."
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpmap                                            #
# PURPOSE: Map Gridplus "variable(s)" to a list of values or array.     #
#=======================================================================#

proc ::gridplus::gpmap {map values {arg __direct}} {

   if {$arg ni "__direct __left __right"} {
      upvar #0 $arg variable
   
      set position 0
   
      if {[array exists variable]} {
         foreach item $map {
            if {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
               gpset [list $item $variable([lindex $values $position])]
            } else {
               gpset $item $variable([lindex $values $position])
            }
            incr position
         }
      } elseif {! [catch {dict size $variable}]} {
         foreach item $map {
            if {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
               #gpset [list $item $variable([lindex $values $position])]
               gpset [list $item [dict get $variable [lindex $values $position]]]
            } else {
               #gpset $item $variable([lindex $values $position])
               gpset $item [dict get $variable [lindex $values $position]]
            }
            incr position
         }
      } else {
         error "GRIDPLUS ERROR: (gpmap) Array/Dict \"$arg\" does not exist."
      }
   } else {
      switch -- $arg {
         __direct {set start 0; set increment 1}
         __left   {set start 0; set increment 2}
         __right  {set start 1; set increment 2}
         default  {set start 0; set increment 1}
      }

      set position $start

      foreach item $map {
         if {[winfo exists $item] && [winfo class $item] eq "TCombobox"} {
            gpset [list $item [lindex $values $position]]
         } else {
            gpset $item [lindex $values $position]
         }
         incr position $increment
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpnav                                            #
# PURPOSE: Navigate to text label or calendar month.                    #
#=======================================================================#

proc ::gridplus::gpnav {name target {increment {}}} {

   global {}

   if {[winfo exists $name.text]} {
      $name.text yview $target
      set ($name) $target
   } elseif {[winfo exists $name.calendar]} {
      if {$target in "current month year"} {
         ::gridplus::gpCalendarNav $name $target $increment
      } else {
         if {[llength $target] == 1} {
            foreach {month day year} [::gridplus::gpFormatDate $target internal] {}
            if {! [::gridplus::gpCalCheckDate $month $day $year]} {
               error "GRIDPLUS ERROR: (gpnav) $target is not a valid date."
            }
         } elseif {[llength $target] == 2} {
            set day   {}
            set month [lindex $target 0]
            set year  [lindex $target 1]
            if {[scan $month %d] < 1 || [scan $month %d] > 12} {
               error "GRIDPLUS ERROR: (gpnav) $month is not a valid month."
            }
            if {! [string is integer $year]} {
               error "GRIDPLUS ERROR: (gpnav) $year is not a valid year."
            }
         }
         ::gridplus::gpCalendarDisplay $name $day $month $year
         if {$increment ne ""} {
            ::gridplus::gpCalendarNav $name month $increment
         }
      }
   } else {
      error "GRIDPLUS ERROR: (gpnav) Widget \"$name\" is not text or calendar."
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpoptions                                        #
# PURPOSE: Set Gridplus option database options.                        #
#=======================================================================#

proc ::gridplus::gpoptions {args} {

   variable gpInfo

   switch -- [llength $args] {
      1 {
         if {[expr [llength [lindex $args 0]] % 2] != 0} {
            error "GRIDPLUS ERROR: (gpoption) Unmatched option/value."
         }
         foreach {option value} [lindex $args 0] {
            option add *Gridplus.$option $value
         }
      }
      2 {
         foreach {option value} $args {}
         option add *Gridplus.$option $value
      }
      default {
         error "GRIDPLUS ERROR: (gpoption) Wrong number of Args."
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gppaste                                          #
# PURPOSE: Perform clipboard paste for item.                            #
#=======================================================================#

proc ::gridplus::gppaste {{item {}}} {

   if {$item eq ""} {
      set item [focus]
   }

   if {[string match *.text $item] && [winfo class $item] eq "Text"} {
      set textItem $item
   } else {
      set textItem $item.text
   }

   if {[winfo exists $textItem]} {
      tk_textPaste $textItem
      $textItem edit modified 1
   } else {
      if {! [catch {$item selection clear}]} {
         $item insert insert [clipboard get]
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpselect                                         #
# PURPOSE: Selects specified item in a tablelist/tree/calendar.         #
#=======================================================================#

proc ::gridplus::gpselect {args} {
   global {}

   variable gpInfo

   set focus      0
   set index      0
   set column     0
   set selectonly 0

   set count  1
   set option 1

   foreach arg $args {
      switch -glob -- $arg {
         -focus      {if {$option} {set focus 1}}
         -index      {if {$option} {set index 1}}
         -selectonly {if {$option} {set selectonly 1}}
         --          {set option 0}
         -*          {if {$option} {
                        error "GRIDPLUS ERROR: (gpselect) Tablelist Invalid option \"$arg\""
                      } else {
                        set match $arg
                        incr count
                      }
                     }
         default     {
            switch -- $count {
               1 {set name   $arg; incr count}
               2 {set match  $arg; incr count}
               3 {set column $arg}
            }
         }
      }
   }
   
   if {[winfo exists $name.tablelist]} {
      $name.tablelist selection clear 0 end

      if {$index} {
         set row $match
         if {$row >= [$name.tablelist size]} {
            set row "end"
         }
      } else {
         set row [lsearch -exact [$name.tablelist getcolumn $column] $match]
         if {$row == -1} {
            error "GRIDPLUS ERROR: (gpselect) Tablelist line with match \"$match\" not found."
         }
      }

      $name.tablelist selection set $row
      $name.tablelist activate $row
      $name.tablelist see $row
      
      if {$gpInfo($name:action) eq "single"} {
         ::gridplus::gpTablelistSelect $name $row $gpInfo($name:window) $gpInfo($name:validate) $gpInfo($name:command)
      } else {
         ::gridplus::gpTablelistSelect $name $row $gpInfo($name:window) $gpInfo($name:validate) {}
      }

      if {$focus} {
         after idle focus [$name.tablelist bodypath]
         $name.tablelist see $row
      }

   } elseif {[winfo exists $name.tree]} {
      if {! [catch {$name.tree selection set $match}]} {
            if {$gpInfo($name:action) eq "single"} {
               ::gridplus::gpTreeSelect $name $gpInfo($name:window) $gpInfo($name:validate) $gpInfo($name:command)
            } else {
               ::gridplus::gpTreeSelect $name $gpInfo($name:window) $gpInfo($name:validate) {}
            }
      } else {
         error "GRIDPLUS ERROR: (gpselect) Tree node \"$match\" not found."
      }
   } elseif {[winfo exists $name.calendar]} {
      if {$match ne ""} {
         foreach {month day year} [::gridplus::gpFormatDate $match internal] {}
         if {! [::gridplus::gpCalCheckDate $month $day $year]} {
            error "GRIDPLUS ERROR: (gpselect) $match is not a valid date."
         }
         set gpInfo($name:selecttoday) 1
         ::gridplus::gpCalendarDisplay $name $day $month $year
      } else {
         if {$gpInfo($name:variable) ne ""} {
            set variable $gpInfo($name:variable)
         } else {
            set variable $name
         }

         if {! $selectonly} {
            set ($variable) {}
         }

         if {[info exists gpInfo($name:selected)] && $gpInfo($name:selected) ne ""} {
            $gpInfo($name:selected) configure -bg $gpInfo($name:bg) -fg $gpInfo($name:fg)
            unset gpInfo($name:selected)
            unset gpInfo($name:selectedday)
            unset gpInfo($name:selectedmonth)
            unset gpInfo($name:selectedyear)
         }
      }
   } else {
      error "GRIDPLUS ERROR: (gpselect) Widget \"$name\" is not calendar, tablelist or tree."
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpset                                            #
# PURPOSE: Set Gridplus "variable(s)".                                  #
#=======================================================================#

proc ::gridplus::gpset {args} {
   global {}

   variable gpInfo

   update idletasks

   switch -- [llength $args] {
      1 {
         if {[expr [llength [lindex $args 0]] % 2] != 0} {
            error "GRIDPLUS ERROR: (gpset) Unmatched item/value."
         }
         foreach {item value} [lindex $args 0] {
            if {[winfo exists $item.text]} {
               $item.text delete 1.0 end
               $item.text insert end $value
               set ($item) $value
            } elseif {[winfo exists $item.calendar]} {
               ::gridplus::gpset -calendar $item $value
            } else {
               set ($item) $value
            }
         }
      }
      2 {
         set item  [lindex $args 0]
         set value [lindex $args 1]
         if {[winfo exists $item.tablelist]} {
            unset -nocomplain ($item)
            $item.tablelist delete 0 end
            foreach line $value {
               ::gridplus::gpTablelistInsert $item end $line 1
            }
            if {$gpInfo($item:columnsort)} {
               $item.tablelist sortbycolumn $gpInfo($item:firstcolumn) -$gpInfo($item:sortorder)
            }
            if {$gpInfo($item:selectfirst)} {
               $item.tablelist selection set 0
               $item.tablelist activate 0
               set ($item) [$item.tablelist get 0]
            }
         } elseif {[winfo exists $item.text]} {
            set textState [$item.text cget -state]
            $item.text configure -state normal
            if {$gpInfo($item:tags)} {
               $item.text delete 1.0 end
               ::gridplus::gpParseTags $item $value end
               $item.text tag raise sel
            } else {
               $item.text delete 1.0 end
               $item.text insert end $value
               $item.text edit modified 0
               set ($item) $value
            }
            $item.text configure -state $textState
         } elseif {[winfo exists $item.tree]} {
            ::gridplus::gpTreeSet $item $value
         } elseif {[winfo exists $item.calendar]} {
            ::gridplus::gpselect $item $value
         } elseif {[winfo exists $item] && [winfo class $item] eq "TCombobox" && ! [info exists gpInfo($item:datecommand)]} {
            $item configure -value $value
         } else {
            set ($item) $value
         }
      }
      3 {
         set option [lindex $args 0] 
         set item   [lindex $args 1]
         set value  [lindex $args 2]
         switch -- $option {
            -names  {::gridplus::gpTablelistSetColumns $item -name $value}
            -titles {::gridplus::gpTablelistSetColumns $item -title $value}
            default {::gridplus::gpselect $item $value $option}
         }
      }
      default {
         error "GRIDPLUS ERROR: (gpset) Wrong number of Args."
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::gpunset                                          #
# PURPOSE: Unset Gridplus "variable(s)".                                #
#=======================================================================#

proc ::gridplus::gpunset {args} {
   global {}

   foreach arg $args {
      if {[info exists ($arg)]} {
         unset ($arg)
      }
      if {[winfo exists $arg.tablelist]} {
         $arg.tablelist delete 0 end
      } elseif {[winfo exists $arg.text]} {
         $arg.text delete 1.0 end
      } elseif {[winfo exists $arg.tree]} {
         $arg.tree configure -state normal
         $arg.tree delete 1.0 end
         $arg.tree configure -state disabled
      }
   }
}

#=======================================================================#
# PROC   : ::gridplus::=                                                #
# PURPOSE: Return specified (widget) option.                            #
#=======================================================================#

proc ::gridplus::= {value key {default {}}} {

   if {[dict exists $value $key]} {
      return [dict get $value $key]
   } else {
      return $default
   }
}

#=======================================================================#
# PROC   : ::gridplus::=%                                               #
# PURPOSE: Return state for widget group.                               #
#=======================================================================#

proc ::gridplus::=% {name state {flag {}}} {
   
   variable gpInfo

   if {[info exists gpInfo($name:group)] && [info exists gpInfo(<gpGroupState>$gpInfo($name:group))]} {

      set state $gpInfo(<gpGroupState>$gpInfo($name:group))

      if {$flag eq "!" &&  $state eq "disabled"} {
         return "readonly"
      } else {
         return $state
      }
   }

   return $state
}

#=======================================================================#
# PROC   : ::gridplus::=:                                               #
# PURPOSE: Create icon and return image name.                           #
#=======================================================================#

proc ::gridplus::=: {icon} {
   upvar 1 options options

   if {[lsearch [image names] ::icon::$icon] < 0} {
      return "::icon::[::icons::icons create -file [file join $options(-iconpath) $options(-iconfile)] $icon]"
   } else {
      return "::icon::$icon"
   }
}

#=======================================================================#
# PROC   : ::gridplus::=?                                               #
# PURPOSE: Check if widget option has been set.                         #
#=======================================================================#

proc ::gridplus::=? {value key} {
   return [dict exists $value $key]
}

#=======================================================================#
# PROC   : ::gridplus::=@                                               #
# PURPOSE: Return default for widget.                                   #
#=======================================================================#

proc ::gridplus::=@ {name {default {}}} {
   
   variable gpInfo
   
   if {[info exists gpInfo(default:$name)]} {
      return $gpInfo(default:$name)
   } else {
      return $default
   } 
}

#=======================================================================#
# PROC   : ::gridplus::=<                                               #
# PURPOSE: Return specified widget option -or- default.                 #
#=======================================================================#

proc ::gridplus::=< {option {default {}}} {

   set value [option get . "Gridplus.$option" -]

   if {$value eq ""} {
      return $default
   } else {
      return $value
   }
}

#=======================================================================#
# End of Script: gridplus.tcl                                           #
#=======================================================================#
