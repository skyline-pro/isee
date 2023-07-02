
########## Tcl recorder starts at 05/13/22 10:03:47 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab14"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:03:47 ###########


########## Tcl recorder starts at 05/13/22 10:03:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:03:50 ###########


########## Tcl recorder starts at 05/13/22 10:07:30 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:07:30 ###########


########## Tcl recorder starts at 05/13/22 10:07:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:07:30 ###########


########## Tcl recorder starts at 05/13/22 10:08:27 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab14.bl5 -o lab14.sif"] {
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
	puts $rspFile "-nodal -src lab14.bl5 -type BLIF -presrc lab14.bl3 -crf lab14.crf -sif lab14.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab14.lct
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

########## Tcl recorder end at 05/13/22 10:08:27 ###########


########## Tcl recorder starts at 05/13/22 10:09:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:09:41 ###########


########## Tcl recorder starts at 05/13/22 10:23:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:23:19 ###########


########## Tcl recorder starts at 05/13/22 10:23:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:23:20 ###########


########## Tcl recorder starts at 05/13/22 10:25:09 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab14.bl5 -o lab14.sif"] {
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
	puts $rspFile "-nodal -src lab14.bl5 -type BLIF -presrc lab14.bl3 -crf lab14.crf -sif lab14.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab14.lct
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

########## Tcl recorder end at 05/13/22 10:25:09 ###########


########## Tcl recorder starts at 05/13/22 10:28:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:28:24 ###########


########## Tcl recorder starts at 05/13/22 10:28:24 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:28:24 ###########


########## Tcl recorder starts at 05/13/22 10:30:25 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i lab14.bl5 -o lab14.sif"] {
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
	puts $rspFile "-nodal -src lab14.bl5 -type BLIF -presrc lab14.bl3 -crf lab14.crf -sif lab14.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_96.dev\" -lci lab14.lct
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

########## Tcl recorder end at 05/13/22 10:30:25 ###########


########## Tcl recorder starts at 05/13/22 10:33:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:33:32 ###########


########## Tcl recorder starts at 05/13/22 10:33:33 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:33:33 ###########


########## Tcl recorder starts at 05/13/22 10:37:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:37:13 ###########


########## Tcl recorder starts at 05/13/22 10:37:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:37:14 ###########


########## Tcl recorder starts at 05/13/22 10:38:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:38:38 ###########


########## Tcl recorder starts at 05/13/22 10:41:57 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:41:57 ###########


########## Tcl recorder starts at 05/13/22 10:41:57 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:41:57 ###########


########## Tcl recorder starts at 05/13/22 10:45:04 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" vga.v -p \"$install_dir/ispcpld/generic\" -predefine lab14.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:45:04 ###########


########## Tcl recorder starts at 05/13/22 10:45:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open vga.cmd w} rspFile] {
	puts stderr "Cannot create response file vga.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab14.sty
PROJECT: vga
WORKING_PATH: \"$proj_dir\"
MODULE: vga
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab14.h vga.v
OUTPUT_FILE_NAME: vga
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e vga -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete vga.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf vga.edi -out vga.bl0 -err automake.err -log vga.log -prj lab14 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" vga.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"vga.bl1\" -o \"lab14.bl2\" -omod \"lab14\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab14 -lci lab14.lct -log lab14.imp -err automake.err -tti lab14.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -blifopt lab14.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab14.bl2 -sweep -mergefb -err automake.err -o lab14.bl3 @lab14.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -diofft lab14.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab14.bl3 -family AMDMACH -idev van -o lab14.bl4 -oxrf lab14.xrf -err automake.err @lab14.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab14.lct -dev lc4k -prefit lab14.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab14.bl4 -out lab14.bl5 -err automake.err -log lab14.log -mod vga @lab14.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab14.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs1: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -nojed -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab14.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab14.rs2: $rspFile"
} else {
	puts $rspFile "-i lab14.bl5 -lci lab14.lct -d m4s_256_96 -lco lab14.lco -html_rpt -fti lab14.fti -fmt PLA -tto lab14.tt4 -eqn lab14.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab14.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab14.rs1
file delete lab14.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab14.bl5 -o lab14.tda -lci lab14.lct -dev m4s_256_96 -family lc4k -mod vga -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab14 -if lab14.jed -j2s -log lab14.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/22 10:45:04 ###########

