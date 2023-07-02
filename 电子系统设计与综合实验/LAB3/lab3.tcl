
########## Tcl recorder starts at 04/11/16 21:50:46 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/LAB3"
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
if [runCmd "\"$cpld_bin/sch2jhd\" top.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:50:46 ###########


########## Tcl recorder starts at 04/11/16 21:54:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:54:29 ###########


########## Tcl recorder starts at 04/11/16 21:56:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:56:07 ###########


########## Tcl recorder starts at 04/11/16 21:56:08 ##########

# Commands to make the Process: 
# Compile Schematic
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

########## Tcl recorder end at 04/11/16 21:56:08 ###########


########## Tcl recorder starts at 04/11/16 21:59:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:19 ###########


########## Tcl recorder starts at 04/11/16 21:59:19 ##########

# Commands to make the Process: 
# Compiled Equations
if [runCmd "\"$cpld_bin/blif2eqn\" top.bl0 -o top.eq0  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:19 ###########


########## Tcl recorder starts at 04/11/16 21:59:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:24 ###########


########## Tcl recorder starts at 04/11/16 21:59:24 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" top"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:24 ###########


########## Tcl recorder starts at 04/11/16 21:59:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:51 ###########


########## Tcl recorder starts at 04/11/16 21:59:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:51 ###########


########## Tcl recorder starts at 04/11/16 21:59:52 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/naf2sym\" adder"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:59:52 ###########


########## Tcl recorder starts at 04/11/16 22:01:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:15 ###########


########## Tcl recorder starts at 04/11/16 22:01:15 ##########

# Commands to make the Process: 
# Bus Signal Cross Reference
if [runCmd "\"$cpld_bin/vhdl\" -s -lib=lat_vhd top.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/exfgen\" -vhd top.vhd -out top.exf"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:15 ###########


########## Tcl recorder starts at 04/11/16 22:01:28 ##########

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
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:28 ###########


########## Tcl recorder starts at 04/11/16 22:01:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:35 ###########


########## Tcl recorder starts at 04/11/16 22:01:36 ##########

# Commands to make the Process: 
# Bus Signal Cross Reference
if [runCmd "\"$cpld_bin/vhdl\" -s -lib=lat_vhd top.sch"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/exfgen\" -vhd top.vhd -out top.exf"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:36 ###########


########## Tcl recorder starts at 04/11/16 22:01:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:43 ###########


########## Tcl recorder starts at 04/11/16 22:01:43 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/naf2sym\" top"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:43 ###########


########## Tcl recorder starts at 04/11/16 22:01:57 ##########

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
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:57 ###########


########## Tcl recorder starts at 04/11/16 22:01:58 ##########

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
if [runCmd "\"$cpld_bin/vlog2jhd\" ../testverilog/adder.v -p \"$install_dir/ispcpld/generic\" -predefine lab3.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:01:58 ###########

