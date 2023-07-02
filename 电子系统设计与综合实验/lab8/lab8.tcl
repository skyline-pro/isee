
########## Tcl recorder starts at 05/07/16 17:07:57 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab8"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoder2to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux16to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoderHex2Dec.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_4.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicshow.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:07:57 ###########


########## Tcl recorder starts at 05/07/16 17:08:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:08:27 ###########


########## Tcl recorder starts at 05/07/16 17:11:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" calculate.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoder2to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux16to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoderHex2Dec.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicshow.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:11:16 ###########


########## Tcl recorder starts at 05/07/16 17:11:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:11:17 ###########


########## Tcl recorder starts at 05/07/16 17:11:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open calculate.cmd w} rspFile] {
	puts stderr "Cannot create response file calculate.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: calculate
WORKING_PATH: \"$proj_dir\"
MODULE: calculate
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h calculate.v
OUTPUT_FILE_NAME: calculate
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e calculate -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete calculate.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf calculate.edi -out calculate.bl0 -err automake.err -log calculate.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" calculate.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"calculate.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod calculate @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab8.bl5 -o lab8.sif"] {
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
	puts $rspFile "-nodal -src lab8.bl5 -type BLIF -presrc lab8.bl3 -crf lab8.crf -sif lab8.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab8.lct
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

########## Tcl recorder end at 05/07/16 17:11:18 ###########


########## Tcl recorder starts at 05/07/16 17:22:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab8.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:22:08 ###########


########## Tcl recorder starts at 05/07/16 17:22:12 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:22:12 ###########


########## Tcl recorder starts at 05/07/16 17:22:12 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:22:12 ###########


########## Tcl recorder starts at 05/07/16 17:28:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab8.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:28:17 ###########


########## Tcl recorder starts at 05/07/16 17:28:18 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:28:18 ###########


########## Tcl recorder starts at 05/07/16 17:31:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:31:35 ###########


########## Tcl recorder starts at 05/07/16 17:31:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:31:35 ###########


########## Tcl recorder starts at 05/07/16 17:31:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab8.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs1: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -nojed -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab8.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs2: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab8.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.rs1
file delete lab8.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab8.bl5 -o lab8.tda -lci lab8.lct -dev m4s_256_64 -family lc4k -mod lab8 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab8 -if lab8.jed -j2s -log lab8.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:31:36 ###########


########## Tcl recorder starts at 05/07/16 17:32:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:32:32 ###########


########## Tcl recorder starts at 05/07/16 17:32:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:32:32 ###########


########## Tcl recorder starts at 05/07/16 17:32:33 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab8.bl5 -o lab8.sif"] {
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
	puts $rspFile "-nodal -src lab8.bl5 -type BLIF -presrc lab8.bl3 -crf lab8.crf -sif lab8.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab8.lct
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

########## Tcl recorder end at 05/07/16 17:32:33 ###########


########## Tcl recorder starts at 05/07/16 17:36:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:36:22 ###########


########## Tcl recorder starts at 05/07/16 17:36:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:36:22 ###########


########## Tcl recorder starts at 05/07/16 17:36:23 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab8.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs1: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -nojed -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab8.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs2: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab8.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.rs1
file delete lab8.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab8.bl5 -o lab8.tda -lci lab8.lct -dev m4s_256_64 -family lc4k -mod lab8 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab8 -if lab8.jed -j2s -log lab8.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:36:23 ###########


########## Tcl recorder starts at 05/07/16 17:39:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab8.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:39:00 ###########


########## Tcl recorder starts at 05/07/16 17:39:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:39:01 ###########


########## Tcl recorder starts at 05/07/16 17:39:02 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab8.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs1: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -nojed -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab8.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs2: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab8.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.rs1
file delete lab8.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab8.bl5 -o lab8.tda -lci lab8.lct -dev m4s_256_64 -family lc4k -mod lab8 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab8 -if lab8.jed -j2s -log lab8.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:39:02 ###########


########## Tcl recorder starts at 05/07/16 17:40:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab8.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:40:34 ###########


########## Tcl recorder starts at 05/07/16 17:40:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:40:34 ###########


########## Tcl recorder starts at 05/07/16 17:40:35 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab8.bl5 -o lab8.sif"] {
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
	puts $rspFile "-nodal -src lab8.bl5 -type BLIF -presrc lab8.bl3 -crf lab8.crf -sif lab8.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab8.lct
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

########## Tcl recorder end at 05/07/16 17:40:35 ###########


########## Tcl recorder starts at 05/07/16 17:41:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:41:43 ###########


########## Tcl recorder starts at 05/07/16 17:41:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:41:44 ###########


########## Tcl recorder starts at 05/07/16 17:41:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab8.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs1: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -nojed -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab8.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs2: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab8.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.rs1
file delete lab8.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab8.bl5 -o lab8.tda -lci lab8.lct -dev m4s_256_64 -family lc4k -mod lab8 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab8 -if lab8.jed -j2s -log lab8.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:41:45 ###########


########## Tcl recorder starts at 05/07/16 17:45:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab8.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:45:58 ###########


########## Tcl recorder starts at 05/07/16 17:45:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab8.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:45:58 ###########


########## Tcl recorder starts at 05/07/16 17:45:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab8.cmd w} rspFile] {
	puts stderr "Cannot create response file lab8.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab8.sty
PROJECT: lab8
WORKING_PATH: \"$proj_dir\"
MODULE: lab8
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab8.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicshow.v calculate.v dffre.v button.v lab8.v
OUTPUT_FILE_NAME: lab8
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab8 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab8.edi -out lab8.bl0 -err automake.err -log lab8.log -prj lab8 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab8.bl1\" -o \"lab8.bl2\" -omod \"lab8\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab8 -lci lab8.lct -log lab8.imp -err automake.err -tti lab8.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -blifopt lab8.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab8.bl2 -sweep -mergefb -err automake.err -o lab8.bl3 @lab8.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -diofft lab8.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab8.bl3 -family AMDMACH -idev van -o lab8.bl4 -oxrf lab8.xrf -err automake.err @lab8.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab8.lct -dev lc4k -prefit lab8.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab8.bl4 -out lab8.bl5 -err automake.err -log lab8.log -mod lab8 @lab8.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab8.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs1: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -nojed -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab8.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab8.rs2: $rspFile"
} else {
	puts $rspFile "-i lab8.bl5 -lci lab8.lct -d m4s_256_64 -lco lab8.lco -html_rpt -fti lab8.fti -fmt PLA -tto lab8.tt4 -eqn lab8.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab8.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab8.rs1
file delete lab8.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab8.bl5 -o lab8.tda -lci lab8.lct -dev m4s_256_64 -family lc4k -mod lab8 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab8 -if lab8.jed -j2s -log lab8.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/07/16 17:45:59 ###########

