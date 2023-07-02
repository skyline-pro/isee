
########## Tcl recorder starts at 05/11/22 18:41:29 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab12"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" ledDotMatrix.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/11/22 18:41:29 ###########


########## Tcl recorder starts at 05/11/22 18:41:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/11/22 18:41:38 ###########


########## Tcl recorder starts at 05/11/22 18:44:40 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" ledDotMatrix.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/11/22 18:44:40 ###########


########## Tcl recorder starts at 05/11/22 18:44:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/11/22 18:44:41 ###########


########## Tcl recorder starts at 05/12/22 22:10:54 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab12.bl5 -o lab12.sif"] {
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
	puts $rspFile "-nodal -src lab12.bl5 -type BLIF -presrc lab12.bl3 -crf lab12.crf -sif lab12.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab12.lct
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

########## Tcl recorder end at 05/12/22 22:10:54 ###########


########## Tcl recorder starts at 05/12/22 22:11:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/12/22 22:11:45 ###########


########## Tcl recorder starts at 05/12/22 22:11:46 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab12.bl5 -o lab12.sif"] {
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
	puts $rspFile "-nodal -src lab12.bl5 -type BLIF -presrc lab12.bl3 -crf lab12.crf -sif lab12.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab12.lct
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

########## Tcl recorder end at 05/12/22 22:11:46 ###########


########## Tcl recorder starts at 05/12/22 22:12:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/12/22 22:12:28 ###########


########## Tcl recorder starts at 05/12/22 22:12:29 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab12.bl5 -o lab12.sif"] {
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
	puts $rspFile "-nodal -src lab12.bl5 -type BLIF -presrc lab12.bl3 -crf lab12.crf -sif lab12.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab12.lct
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

########## Tcl recorder end at 05/12/22 22:12:29 ###########


########## Tcl recorder starts at 05/12/22 22:14:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/12/22 22:14:50 ###########


########## Tcl recorder starts at 05/13/22 08:14:00 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab12.bl5 -o lab12.sif"] {
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
	puts $rspFile "-nodal -src lab12.bl5 -type BLIF -presrc lab12.bl3 -crf lab12.crf -sif lab12.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab12.lct
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

########## Tcl recorder end at 05/13/22 08:14:00 ###########


########## Tcl recorder starts at 05/13/22 08:15:35 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:15:35 ###########


########## Tcl recorder starts at 05/13/22 08:16:33 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab12.bl5 -o lab12.sif"] {
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
	puts $rspFile "-nodal -src lab12.bl5 -type BLIF -presrc lab12.bl3 -crf lab12.crf -sif lab12.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab12.lct
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

########## Tcl recorder end at 05/13/22 08:16:33 ###########


########## Tcl recorder starts at 05/13/22 08:17:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:17:42 ###########


########## Tcl recorder starts at 05/13/22 08:17:42 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:17:42 ###########


########## Tcl recorder starts at 05/13/22 08:19:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:19:41 ###########


########## Tcl recorder starts at 05/13/22 08:19:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:19:41 ###########


########## Tcl recorder starts at 05/13/22 08:20:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:20:54 ###########


########## Tcl recorder starts at 05/13/22 08:20:55 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:20:55 ###########


########## Tcl recorder starts at 05/13/22 08:25:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:25:48 ###########


########## Tcl recorder starts at 05/13/22 08:25:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:25:48 ###########


########## Tcl recorder starts at 05/13/22 08:26:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" lab12.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:26:28 ###########


########## Tcl recorder starts at 05/13/22 08:26:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:26:29 ###########


########## Tcl recorder starts at 05/13/22 08:27:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab12.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:27:09 ###########


########## Tcl recorder starts at 05/13/22 08:27:12 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab12.cmd w} rspFile] {
	puts stderr "Cannot create response file lab12.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab12.sty
PROJECT: lab12
WORKING_PATH: \"$proj_dir\"
MODULE: lab12
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab12.h ledDotMatrix.v dffre.v button.v counter_n.v lab12.v
OUTPUT_FILE_NAME: lab12
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab12 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab12.edi -out lab12.bl0 -err automake.err -log lab12.log -prj lab12 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab12.bl1\" -o \"lab12.bl2\" -omod \"lab12\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab12 -lci lab12.lct -log lab12.imp -err automake.err -tti lab12.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -blifopt lab12.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab12.bl2 -sweep -mergefb -err automake.err -o lab12.bl3 @lab12.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -diofft lab12.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab12.bl3 -family AMDMACH -idev van -o lab12.bl4 -oxrf lab12.xrf -err automake.err @lab12.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab12.lct -dev lc4k -prefit lab12.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab12.bl4 -out lab12.bl5 -err automake.err -log lab12.log -mod lab12 @lab12.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab12.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs1: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -nojed -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab12.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab12.rs2: $rspFile"
} else {
	puts $rspFile "-i lab12.bl5 -lci lab12.lct -d m4s_256_96 -lco lab12.lco -html_rpt -fti lab12.fti -fmt PLA -tto lab12.tt4 -eqn lab12.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab12.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab12.rs1
file delete lab12.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab12.bl5 -o lab12.tda -lci lab12.lct -dev m4s_256_96 -family lc4k -mod lab12 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab12 -if lab12.jed -j2s -log lab12.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 08:27:12 ###########

