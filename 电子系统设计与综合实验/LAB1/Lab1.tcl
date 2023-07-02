
########## Tcl recorder starts at 04/12/16 00:46:25 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/LAB1"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" demo.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 00:46:25 ###########


########## Tcl recorder starts at 04/12/16 00:58:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" demo.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 00:58:47 ###########


########## Tcl recorder starts at 04/12/16 01:04:29 ##########

# Commands to make the Process: 
# Compile Schematic
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup demo.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"demo.bls\" -o \"demo.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:04:29 ###########


########## Tcl recorder starts at 04/12/16 01:04:44 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" demo.abv -vec -ovec demo.tmv -sim Lab1 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:04:44 ###########


########## Tcl recorder starts at 04/12/16 01:05:50 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" demo.abv -vec -ovec demo.tmv -sim Lab1 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:05:50 ###########


########## Tcl recorder starts at 04/12/16 01:06:07 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/mblifopt\" -i demo.bl0 -o demo.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"demo.bl1\" -o \"lab1.bl2\" -omod \"lab1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab1 -lci lab1.lct -log lab1.imp -err automake.err -tti lab1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -blifopt lab1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab1.bl2 -sweep -mergefb -err automake.err -o lab1.bl3 @lab1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -dev lc4k -diofft lab1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab1.bl3 -family AMDMACH -idev van -o lab1.bl4 -oxrf lab1.xrf -err automake.err @lab1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -dev lc4k -prefit lab1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab1.bl4 -out lab1.bl5 -err automake.err -log lab1.log -mod demo @lab1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk demo.lts -map demo.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:06:07 ###########


########## Tcl recorder starts at 04/12/16 01:08:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:08:54 ###########


########## Tcl recorder starts at 04/12/16 01:12:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:12:10 ###########


########## Tcl recorder starts at 04/12/16 01:16:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:16:44 ###########


########## Tcl recorder starts at 04/12/16 01:16:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:16:45 ###########


########## Tcl recorder starts at 04/12/16 01:16:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:16:46 ###########


########## Tcl recorder starts at 04/12/16 01:17:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" abeltop.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:17:54 ###########


########## Tcl recorder starts at 04/12/16 01:19:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/ahdl2blf\" abeltop.abl -ojhd only -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:19:01 ###########


########## Tcl recorder starts at 04/12/16 01:19:19 ##########

# Commands to make the Process: 
# Compile Logic
if [runCmd "\"$cpld_bin/ahdl2blf\" abeltop.abl -mod abeltop -ojhd compile -ret -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:19:19 ###########


########## Tcl recorder starts at 04/12/16 01:20:46 ##########

# Commands to make the Process: 
# Compile Test Vectors
if [runCmd "\"$cpld_bin/ahdl2blf\" demo.abv -vec -ovec demo.tmv -sim Lab1 -def _AMDMACH_ _MACH_ _LSI5K_ _LATTICE_ _PLSI_ _MACH4ZE_  -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:20:46 ###########


########## Tcl recorder starts at 04/12/16 01:20:48 ##########

# Commands to make the Process: 
# Functional Simulation
if [runCmd "\"$cpld_bin/sch2blf\" -dev Lattice -sup top.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bls\" -o \"top.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i top.bl0 -o top.bl1 -collapse none -reduce none  -err automake.err -keepwires -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" abeltop.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"top.bl1\" -o \"lab1.bl2\" -omod \"lab1\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab1 -lci lab1.lct -log lab1.imp -err automake.err -tti lab1.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -blifopt lab1.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab1.bl2 -sweep -mergefb -err automake.err -o lab1.bl3 @lab1.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -dev lc4k -diofft lab1.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab1.bl3 -family AMDMACH -idev van -o lab1.bl4 -oxrf lab1.xrf -err automake.err @lab1.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab1.lct -dev lc4k -prefit lab1.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab1.bl4 -out lab1.bl5 -err automake.err -log lab1.log -mod top @lab1.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Functional Simulation
if [catch {open simcp._sp w} rspFile] {
	puts stderr "Cannot create response file simcp._sp: $rspFile"
} else {
	puts $rspFile "simcp.pre7 -ini simcpls.ini -unit simcp.pre7
-cfg machgen.fdk demo.lts -map top.lsi
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/simcp\" @simcp._sp"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:20:48 ###########


########## Tcl recorder starts at 04/12/16 01:22:53 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab1.bl5 -o lab1.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src lab1.bl5 -type BLIF -presrc lab1.bl3 -crf lab1.crf -sif lab1.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4z_256_64.dev\" -lci lab1.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/12/16 01:22:53 ###########

