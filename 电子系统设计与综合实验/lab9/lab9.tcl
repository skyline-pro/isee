
########## Tcl recorder starts at 05/07/16 18:46:38 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab9"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux16to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab9.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" serial.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoderHex2Dec.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoder2to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:46:38 ###########


########## Tcl recorder starts at 05/07/16 18:46:50 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:46:50 ###########


########## Tcl recorder starts at 05/07/16 18:46:51 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:46:51 ###########


########## Tcl recorder starts at 05/07/16 18:51:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab9.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:51:04 ###########


########## Tcl recorder starts at 05/07/16 18:51:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:51:04 ###########


########## Tcl recorder starts at 05/07/16 18:52:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:52:48 ###########


########## Tcl recorder starts at 05/07/16 18:52:48 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:52:48 ###########


########## Tcl recorder starts at 05/07/16 18:53:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:53:58 ###########


########## Tcl recorder starts at 05/07/16 18:53:58 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open dynamicshow.cmd w} rspFile] {
	puts stderr "Cannot create response file dynamicshow.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: dynamicshow
WORKING_PATH: \"$proj_dir\"
MODULE: dynamicshow
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v
OUTPUT_FILE_NAME: dynamicshow
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e dynamicshow -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dynamicshow.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf dynamicshow.edi -out dynamicshow.bl0 -err automake.err -log dynamicshow.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:53:58 ###########


########## Tcl recorder starts at 05/07/16 18:54:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:54:54 ###########


########## Tcl recorder starts at 05/07/16 18:54:54 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open dynamicshow.cmd w} rspFile] {
	puts stderr "Cannot create response file dynamicshow.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: dynamicshow
WORKING_PATH: \"$proj_dir\"
MODULE: dynamicshow
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v
OUTPUT_FILE_NAME: dynamicshow
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e dynamicshow -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete dynamicshow.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf dynamicshow.edi -out dynamicshow.bl0 -err automake.err -log dynamicshow.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:54:54 ###########


########## Tcl recorder starts at 05/07/16 18:55:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:55:29 ###########


########## Tcl recorder starts at 05/07/16 18:55:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:55:29 ###########


########## Tcl recorder starts at 05/07/16 18:55:30 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab9.bl5 -o lab9.sif"] {
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
	puts $rspFile "-nodal -src lab9.bl5 -type BLIF -presrc lab9.bl3 -crf lab9.crf -sif lab9.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab9.lct
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

########## Tcl recorder end at 05/07/16 18:55:30 ###########


########## Tcl recorder starts at 05/07/16 18:58:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:58:11 ###########


########## Tcl recorder starts at 05/07/16 18:58:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 18:58:11 ###########


########## Tcl recorder starts at 05/07/16 18:58:12 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab9.bl5 -o lab9.sif"] {
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
	puts $rspFile "-nodal -src lab9.bl5 -type BLIF -presrc lab9.bl3 -crf lab9.crf -sif lab9.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab9.lct
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

########## Tcl recorder end at 05/07/16 18:58:12 ###########


########## Tcl recorder starts at 05/07/16 19:00:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:00:22 ###########


########## Tcl recorder starts at 05/07/16 19:00:22 ##########

# Commands to make the Process: 
# Generate Schematic Symbol
if [runCmd "\"$cpld_bin/vlog2jhd\" lab9.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/naf2sym\" lab9"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:00:22 ###########


########## Tcl recorder starts at 05/07/16 19:00:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:00:31 ###########


########## Tcl recorder starts at 05/07/16 19:00:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:00:31 ###########


########## Tcl recorder starts at 05/07/16 19:00:32 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab9.bl5 -o lab9.sif"] {
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
	puts $rspFile "-nodal -src lab9.bl5 -type BLIF -presrc lab9.bl3 -crf lab9.crf -sif lab9.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab9.lct
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

########## Tcl recorder end at 05/07/16 19:00:32 ###########


########## Tcl recorder starts at 05/07/16 19:04:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab9.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:04:58 ###########


########## Tcl recorder starts at 05/07/16 19:04:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:04:59 ###########


########## Tcl recorder starts at 05/07/16 19:05:00 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:05:00 ###########


########## Tcl recorder starts at 05/07/16 19:07:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:07:44 ###########


########## Tcl recorder starts at 05/07/16 19:07:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:07:44 ###########


########## Tcl recorder starts at 05/07/16 19:07:45 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab9.bl5 -o lab9.sif"] {
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
	puts $rspFile "-nodal -src lab9.bl5 -type BLIF -presrc lab9.bl3 -crf lab9.crf -sif lab9.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab9.lct
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

########## Tcl recorder end at 05/07/16 19:07:45 ###########


########## Tcl recorder starts at 05/07/16 19:11:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:11:36 ###########


########## Tcl recorder starts at 05/07/16 19:11:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:11:36 ###########


########## Tcl recorder starts at 05/07/16 19:11:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:11:37 ###########


########## Tcl recorder starts at 05/07/16 19:28:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:28:18 ###########


########## Tcl recorder starts at 05/07/16 19:28:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:28:19 ###########


########## Tcl recorder starts at 05/07/16 19:28:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:28:20 ###########


########## Tcl recorder starts at 05/07/16 19:31:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:31:11 ###########


########## Tcl recorder starts at 05/07/16 19:31:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:31:12 ###########


########## Tcl recorder starts at 05/07/16 19:31:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:31:13 ###########


########## Tcl recorder starts at 05/07/16 19:34:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:34:29 ###########


########## Tcl recorder starts at 05/07/16 19:34:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:34:29 ###########


########## Tcl recorder starts at 05/07/16 19:34:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:34:31 ###########


########## Tcl recorder starts at 05/07/16 19:43:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:43:49 ###########


########## Tcl recorder starts at 05/07/16 19:43:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:43:49 ###########


########## Tcl recorder starts at 05/07/16 19:43:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:43:50 ###########


########## Tcl recorder starts at 05/07/16 19:47:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:47:21 ###########


########## Tcl recorder starts at 05/07/16 19:47:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:47:21 ###########


########## Tcl recorder starts at 05/07/16 19:47:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:47:23 ###########


########## Tcl recorder starts at 05/07/16 19:51:51 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:51:51 ###########


########## Tcl recorder starts at 05/07/16 19:51:52 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:51:52 ###########


########## Tcl recorder starts at 05/07/16 19:51:53 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:51:53 ###########


########## Tcl recorder starts at 05/07/16 19:53:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:53:04 ###########


########## Tcl recorder starts at 05/07/16 19:53:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:53:04 ###########


########## Tcl recorder starts at 05/07/16 19:53:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:53:05 ###########


########## Tcl recorder starts at 05/07/16 19:56:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:56:28 ###########


########## Tcl recorder starts at 05/07/16 19:56:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:56:29 ###########


########## Tcl recorder starts at 05/07/16 19:56:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:56:30 ###########


########## Tcl recorder starts at 05/07/16 19:58:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:58:20 ###########


########## Tcl recorder starts at 05/07/16 19:58:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:58:21 ###########


########## Tcl recorder starts at 05/07/16 19:58:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 19:58:22 ###########


########## Tcl recorder starts at 05/07/16 20:01:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 20:01:57 ###########


########## Tcl recorder starts at 05/07/16 20:01:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 20:01:57 ###########


########## Tcl recorder starts at 05/07/16 20:01:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 20:01:58 ###########


########## Tcl recorder starts at 05/08/16 09:47:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:47:06 ###########


########## Tcl recorder starts at 05/08/16 09:47:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:47:07 ###########


########## Tcl recorder starts at 05/08/16 09:47:08 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:47:08 ###########


########## Tcl recorder starts at 05/08/16 09:51:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:51:05 ###########


########## Tcl recorder starts at 05/08/16 09:51:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:51:05 ###########


########## Tcl recorder starts at 05/08/16 09:51:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:51:06 ###########


########## Tcl recorder starts at 05/08/16 09:52:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:52:25 ###########


########## Tcl recorder starts at 05/08/16 09:52:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab9.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:52:25 ###########


########## Tcl recorder starts at 05/08/16 09:52:26 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab9.cmd w} rspFile] {
	puts stderr "Cannot create response file lab9.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab9.sty
PROJECT: lab9
WORKING_PATH: \"$proj_dir\"
MODULE: lab9
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab9.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v serial.v keyboard.v dffre.v button.v lab9.v
OUTPUT_FILE_NAME: lab9
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab9 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab9.edi -out lab9.bl0 -err automake.err -log lab9.log -prj lab9 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab9.bl1\" -o \"lab9.bl2\" -omod \"lab9\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab9 -lci lab9.lct -log lab9.imp -err automake.err -tti lab9.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -blifopt lab9.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab9.bl2 -sweep -mergefb -err automake.err -o lab9.bl3 @lab9.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -diofft lab9.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab9.bl3 -family AMDMACH -idev van -o lab9.bl4 -oxrf lab9.xrf -err automake.err @lab9.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab9.lct -dev lc4k -prefit lab9.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab9.bl4 -out lab9.bl5 -err automake.err -log lab9.log -mod lab9 @lab9.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab9.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs1: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -nojed -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab9.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab9.rs2: $rspFile"
} else {
	puts $rspFile "-i lab9.bl5 -lci lab9.lct -d m4s_256_64 -lco lab9.lco -html_rpt -fti lab9.fti -fmt PLA -tto lab9.tt4 -eqn lab9.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab9.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab9.rs1
file delete lab9.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab9.bl5 -o lab9.tda -lci lab9.lct -dev m4s_256_64 -family lc4k -mod lab9 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab9 -if lab9.jed -j2s -log lab9.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:52:26 ###########

