
########## Tcl recorder starts at 04/11/16 20:18:40 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/testVerilog"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 20:18:40 ###########


########## Tcl recorder starts at 04/11/16 20:56:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 20:56:07 ###########


########## Tcl recorder starts at 04/11/16 20:57:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 20:57:06 ###########


########## Tcl recorder starts at 04/11/16 20:58:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 20:58:51 ###########


########## Tcl recorder starts at 04/11/16 21:00:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:00:06 ###########


########## Tcl recorder starts at 04/11/16 21:02:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:02:53 ###########


########## Tcl recorder starts at 04/11/16 21:03:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:03:22 ###########


########## Tcl recorder starts at 04/11/16 21:05:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:05:09 ###########


########## Tcl recorder starts at 04/11/16 21:17:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:17:16 ###########


########## Tcl recorder starts at 04/11/16 21:24:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:24:28 ###########


########## Tcl recorder starts at 04/11/16 21:24:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:24:29 ###########


########## Tcl recorder starts at 04/11/16 21:24:29 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open key.cmd w} rspFile] {
	puts stderr "Cannot create response file key.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: key
WORKING_PATH: \"$proj_dir\"
MODULE: key
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h counter_n.v key.v
OUTPUT_FILE_NAME: key
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e key -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete key.cmd

########## Tcl recorder end at 04/11/16 21:24:29 ###########


########## Tcl recorder starts at 04/11/16 21:37:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 21:37:22 ###########


########## Tcl recorder starts at 04/11/16 22:08:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:08:46 ###########


########## Tcl recorder starts at 04/11/16 22:08:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:08:47 ###########


########## Tcl recorder starts at 04/11/16 22:08:48 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open random.cmd w} rspFile] {
	puts stderr "Cannot create response file random.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: random
WORKING_PATH: \"$proj_dir\"
MODULE: random
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h random.v
OUTPUT_FILE_NAME: random
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e random -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete random.cmd

########## Tcl recorder end at 04/11/16 22:08:48 ###########


########## Tcl recorder starts at 04/11/16 22:16:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 22:16:13 ###########


########## Tcl recorder starts at 04/11/16 23:08:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" to4decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:08:26 ###########


########## Tcl recorder starts at 04/11/16 23:08:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mix.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" to4decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:08:51 ###########


########## Tcl recorder starts at 04/11/16 23:09:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" to4decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:09:12 ###########


########## Tcl recorder starts at 04/11/16 23:15:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decode.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:15:03 ###########


########## Tcl recorder starts at 04/11/16 23:15:04 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open decode.cmd w} rspFile] {
	puts stderr "Cannot create response file decode.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: decode
WORKING_PATH: \"$proj_dir\"
MODULE: decode
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h decode.v
OUTPUT_FILE_NAME: decode
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e decode -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete decode.cmd

########## Tcl recorder end at 04/11/16 23:15:04 ###########


########## Tcl recorder starts at 04/11/16 23:16:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:11 ###########


########## Tcl recorder starts at 04/11/16 23:16:12 ##########

# Commands to make the Process: 
# ABEL Test Vector Template
if [runCmd "\"$cpld_bin/vlog2jhd\" -tfi -proj testverilog -mod decode -out decode -predefine testverilog.h -tpl \"$install_dir/ispcpld/plsi/abel/plsiabt.tft\" -ext abt -p \"$install_dir/ispcpld/generic\" decode.v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:12 ###########


########## Tcl recorder starts at 04/11/16 23:16:26 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:26 ###########


########## Tcl recorder starts at 04/11/16 23:16:26 ##########

# Commands to make the Process: 
# Verilog Test Fixture Declarations
if [runCmd "\"$cpld_bin/vlog2jhd\" -tfi -proj testverilog -mod decode -out decode -predefine testverilog.h -tpl \"$install_dir/ispcpld/generic/verilog/tfi.tft\" decode.v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:26 ###########


########## Tcl recorder starts at 04/11/16 23:16:37 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:37 ###########


########## Tcl recorder starts at 04/11/16 23:16:37 ##########

# Commands to make the Process: 
# Verilog Test Fixture Template
if [runCmd "\"$cpld_bin/vlog2jhd\" -tfi -proj testverilog -ext .tft -mod decode -out decode -predefine testverilog.h -tpl \"$install_dir/ispcpld/generic/verilog/tft.tft\" decode.v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:37 ###########


########## Tcl recorder starts at 04/11/16 23:16:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:16:57 ###########


########## Tcl recorder starts at 04/11/16 23:16:58 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top.cmd w} rspFile] {
	puts stderr "Cannot create response file top.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: top
WORKING_PATH: \"$proj_dir\"
MODULE: top
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h to4decode.v decode.v mux.v counter_n.v adder.v random.v key.v top.v
OUTPUT_FILE_NAME: top
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top.cmd

########## Tcl recorder end at 04/11/16 23:16:58 ###########


########## Tcl recorder starts at 04/11/16 23:18:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" key.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:18:28 ###########


########## Tcl recorder starts at 04/11/16 23:18:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:18:36 ###########


########## Tcl recorder starts at 04/11/16 23:18:36 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open key.cmd w} rspFile] {
	puts stderr "Cannot create response file key.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: key
WORKING_PATH: \"$proj_dir\"
MODULE: key
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h counter_n.v key.v
OUTPUT_FILE_NAME: key
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e key -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete key.cmd

########## Tcl recorder end at 04/11/16 23:18:36 ###########


########## Tcl recorder starts at 04/11/16 23:20:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:20:10 ###########


########## Tcl recorder starts at 04/11/16 23:20:10 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top.cmd w} rspFile] {
	puts stderr "Cannot create response file top.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: top
WORKING_PATH: \"$proj_dir\"
MODULE: top
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h to4decode.v decode.v mux.v counter_n.v adder.v random.v key.v top.v
OUTPUT_FILE_NAME: top
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top.cmd

########## Tcl recorder end at 04/11/16 23:20:10 ###########


########## Tcl recorder starts at 04/11/16 23:21:02 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:21:02 ###########


########## Tcl recorder starts at 04/11/16 23:21:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:21:07 ###########


########## Tcl recorder starts at 04/11/16 23:21:07 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top.cmd w} rspFile] {
	puts stderr "Cannot create response file top.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: top
WORKING_PATH: \"$proj_dir\"
MODULE: top
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h to4decode.v decode.v mux.v counter_n.v adder.v random.v key.v top.v
OUTPUT_FILE_NAME: top
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top.cmd

########## Tcl recorder end at 04/11/16 23:21:07 ###########


########## Tcl recorder starts at 04/11/16 23:25:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" random.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" top.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" adder.v -p \"$install_dir/ispcpld/generic\" -predefine testverilog.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 04/11/16 23:25:33 ###########


########## Tcl recorder starts at 04/11/16 23:25:34 ##########

# Commands to make the Process: 
# Synplify Synthesize Verilog File
if [catch {open top.cmd w} rspFile] {
	puts stderr "Cannot create response file top.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: testverilog.sty
PROJECT: top
WORKING_PATH: \"$proj_dir\"
MODULE: top
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" testverilog.h to4decode.v decode.v mux.v counter_n.v adder.v random.v key.v top.v
OUTPUT_FILE_NAME: top
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e top -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete top.cmd

########## Tcl recorder end at 04/11/16 23:25:34 ###########

