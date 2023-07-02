
########## Tcl recorder starts at 05/08/16 13:03:32 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab10"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" decoder2to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux16to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoderHex2Dec.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:03:32 ###########


########## Tcl recorder starts at 05/08/16 13:03:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:03:43 ###########


########## Tcl recorder starts at 05/08/16 13:03:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:03:44 ###########


########## Tcl recorder starts at 05/08/16 13:03:46 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:03:46 ###########


########## Tcl recorder starts at 05/08/16 13:06:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:06:10 ###########


########## Tcl recorder starts at 05/08/16 13:06:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:06:11 ###########


########## Tcl recorder starts at 05/08/16 13:06:13 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:06:13 ###########


########## Tcl recorder starts at 05/08/16 13:08:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:08:43 ###########


########## Tcl recorder starts at 05/08/16 13:08:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:08:44 ###########


########## Tcl recorder starts at 05/08/16 13:08:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:08:45 ###########


########## Tcl recorder starts at 05/08/16 13:09:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:09:23 ###########


########## Tcl recorder starts at 05/08/16 13:09:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:09:24 ###########


########## Tcl recorder starts at 05/08/16 13:09:26 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:09:26 ###########


########## Tcl recorder starts at 05/08/16 13:10:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:10:23 ###########


########## Tcl recorder starts at 05/08/16 13:10:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:10:23 ###########


########## Tcl recorder starts at 05/08/16 13:10:25 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:10:25 ###########


########## Tcl recorder starts at 05/08/16 13:13:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:13:20 ###########


########## Tcl recorder starts at 05/08/16 13:13:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:13:21 ###########


########## Tcl recorder starts at 05/08/16 13:13:22 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:13:22 ###########


########## Tcl recorder starts at 05/08/16 13:15:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:15:07 ###########


########## Tcl recorder starts at 05/08/16 13:15:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:15:07 ###########


########## Tcl recorder starts at 05/08/16 13:15:09 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:15:09 ###########


########## Tcl recorder starts at 05/08/16 13:16:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:16:16 ###########


########## Tcl recorder starts at 05/08/16 13:16:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:16:16 ###########


########## Tcl recorder starts at 05/08/16 13:16:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:16:18 ###########


########## Tcl recorder starts at 05/08/16 13:17:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:17:34 ###########


########## Tcl recorder starts at 05/08/16 13:17:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:17:35 ###########


########## Tcl recorder starts at 05/08/16 13:17:36 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab10.bl5 -o lab10.sif"] {
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
	puts $rspFile "-nodal -src lab10.bl5 -type BLIF -presrc lab10.bl3 -crf lab10.crf -sif lab10.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab10.lct
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

########## Tcl recorder end at 05/08/16 13:17:36 ###########


########## Tcl recorder starts at 05/08/16 13:19:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:19:04 ###########


########## Tcl recorder starts at 05/08/16 13:19:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:19:04 ###########


########## Tcl recorder starts at 05/08/16 13:19:06 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:19:06 ###########


########## Tcl recorder starts at 05/08/16 13:30:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:30:41 ###########


########## Tcl recorder starts at 05/08/16 13:30:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:30:42 ###########


########## Tcl recorder starts at 05/08/16 13:30:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:30:43 ###########


########## Tcl recorder starts at 05/08/16 13:32:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab10.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" PS2Keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:32:35 ###########


########## Tcl recorder starts at 05/08/16 13:32:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab10.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:32:36 ###########


########## Tcl recorder starts at 05/08/16 13:32:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab10.cmd w} rspFile] {
	puts stderr "Cannot create response file lab10.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab10.sty
PROJECT: lab10
WORKING_PATH: \"$proj_dir\"
MODULE: lab10
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab10.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v PS2Keyboard.v dffre.v button.v lab10.v
OUTPUT_FILE_NAME: lab10
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab10 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab10.edi -out lab10.bl0 -err automake.err -log lab10.log -prj lab10 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab10.bl1\" -o \"lab10.bl2\" -omod \"lab10\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab10 -lci lab10.lct -log lab10.imp -err automake.err -tti lab10.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -blifopt lab10.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab10.bl2 -sweep -mergefb -err automake.err -o lab10.bl3 @lab10.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -diofft lab10.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab10.bl3 -family AMDMACH -idev van -o lab10.bl4 -oxrf lab10.xrf -err automake.err @lab10.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab10.lct -dev lc4k -prefit lab10.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab10.bl4 -out lab10.bl5 -err automake.err -log lab10.log -mod lab10 @lab10.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab10.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs1: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -nojed -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab10.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab10.rs2: $rspFile"
} else {
	puts $rspFile "-i lab10.bl5 -lci lab10.lct -d m4s_256_64 -lco lab10.lco -html_rpt -fti lab10.fti -fmt PLA -tto lab10.tt4 -eqn lab10.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab10.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab10.rs1
file delete lab10.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab10.bl5 -o lab10.tda -lci lab10.lct -dev m4s_256_64 -family lc4k -mod lab10 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab10 -if lab10.jed -j2s -log lab10.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 13:32:37 ###########

