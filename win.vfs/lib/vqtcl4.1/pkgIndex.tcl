package ifneeded vlerq 4.1 \
  [list load [file join $dir libvqtcl4.1[info sharedlibext]] vlerq]

package ifneeded ratcl 4.1 \
  [list source [file join $dir ratcl.tcl]]

package ifneeded mklite    0.5 [list source [file join $dir mklite.tcl]]
package ifneeded vfs::m2m  1.8 [list source [file join $dir m2mvfs.tcl]]
package ifneeded vfs::mkcl 1.5 [list source [file join $dir mkclvfs.tcl]]
package ifneeded vlerq 4.1 {load {} vlerq}
