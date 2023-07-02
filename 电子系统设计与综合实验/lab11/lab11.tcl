
########## Tcl recorder starts at 05/08/16 00:15:10 ##########

set version "2.1"
set proj_dir "E:/Grade-3_2/ISP_Project/lab11"
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
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" keyboard.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" mux16to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoderHex2Dec.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" counter_n.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" decoder2to4.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:15:10 ###########


########## Tcl recorder starts at 05/08/16 00:20:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:20:36 ###########


########## Tcl recorder starts at 05/08/16 00:20:36 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:20:36 ###########


########## Tcl recorder starts at 05/08/16 00:20:38 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:20:38 ###########


########## Tcl recorder starts at 05/08/16 00:28:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:28:24 ###########


########## Tcl recorder starts at 05/08/16 00:28:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:28:25 ###########


########## Tcl recorder starts at 05/08/16 00:28:26 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:28:26 ###########


########## Tcl recorder starts at 05/08/16 00:38:53 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dynamicShow.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" button.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:38:53 ###########


########## Tcl recorder starts at 05/08/16 00:38:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:38:54 ###########


########## Tcl recorder starts at 05/08/16 00:38:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:38:56 ###########


########## Tcl recorder starts at 05/08/16 00:44:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:44:38 ###########


########## Tcl recorder starts at 05/08/16 00:44:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:44:38 ###########


########## Tcl recorder starts at 05/08/16 00:44:39 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 00:44:39 ###########


########## Tcl recorder starts at 05/08/16 00:45:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:45:29 ###########


########## Tcl recorder starts at 05/08/16 00:45:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:45:29 ###########


########## Tcl recorder starts at 05/08/16 00:45:30 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 00:45:30 ###########


########## Tcl recorder starts at 05/08/16 00:49:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:49:07 ###########


########## Tcl recorder starts at 05/08/16 00:49:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:49:08 ###########


########## Tcl recorder starts at 05/08/16 00:49:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 00:49:09 ###########


########## Tcl recorder starts at 05/08/16 01:06:28 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:06:28 ###########


########## Tcl recorder starts at 05/08/16 01:06:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:06:29 ###########


########## Tcl recorder starts at 05/08/16 01:06:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:06:30 ###########


########## Tcl recorder starts at 05/08/16 01:11:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:11:43 ###########


########## Tcl recorder starts at 05/08/16 01:11:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:11:43 ###########


########## Tcl recorder starts at 05/08/16 01:11:44 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:11:44 ###########


########## Tcl recorder starts at 05/08/16 01:13:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:13:03 ###########


########## Tcl recorder starts at 05/08/16 01:13:03 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:13:03 ###########


########## Tcl recorder starts at 05/08/16 01:13:05 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:13:05 ###########


########## Tcl recorder starts at 05/08/16 01:14:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:14:44 ###########


########## Tcl recorder starts at 05/08/16 01:14:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:14:44 ###########


########## Tcl recorder starts at 05/08/16 01:14:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:14:45 ###########


########## Tcl recorder starts at 05/08/16 01:16:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:16:41 ###########


########## Tcl recorder starts at 05/08/16 01:16:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 01:16:41 ###########


########## Tcl recorder starts at 05/08/16 01:16:42 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 01:16:42 ###########


########## Tcl recorder starts at 05/08/16 09:55:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:55:45 ###########


########## Tcl recorder starts at 05/08/16 09:55:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:55:46 ###########


########## Tcl recorder starts at 05/08/16 09:55:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 09:55:47 ###########


########## Tcl recorder starts at 05/08/16 10:07:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:07:08 ###########


########## Tcl recorder starts at 05/08/16 10:07:08 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:07:08 ###########


########## Tcl recorder starts at 05/08/16 10:07:09 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:07:09 ###########


########## Tcl recorder starts at 05/08/16 10:12:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:12:06 ###########


########## Tcl recorder starts at 05/08/16 10:12:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:12:06 ###########


########## Tcl recorder starts at 05/08/16 10:12:07 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:12:07 ###########


########## Tcl recorder starts at 05/08/16 10:20:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:20:44 ###########


########## Tcl recorder starts at 05/08/16 10:20:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:20:44 ###########


########## Tcl recorder starts at 05/08/16 10:20:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:20:45 ###########


########## Tcl recorder starts at 05/08/16 10:23:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:23:59 ###########


########## Tcl recorder starts at 05/08/16 10:23:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:23:59 ###########


########## Tcl recorder starts at 05/08/16 10:24:00 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 10:24:00 ###########


########## Tcl recorder starts at 05/08/16 10:29:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:29:48 ###########


########## Tcl recorder starts at 05/08/16 10:29:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:29:49 ###########


########## Tcl recorder starts at 05/08/16 10:29:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:29:50 ###########


########## Tcl recorder starts at 05/08/16 10:31:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:31:17 ###########


########## Tcl recorder starts at 05/08/16 10:31:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:31:17 ###########


########## Tcl recorder starts at 05/08/16 10:31:18 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:31:18 ###########


########## Tcl recorder starts at 05/08/16 10:34:44 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:34:44 ###########


########## Tcl recorder starts at 05/08/16 10:34:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:34:45 ###########


########## Tcl recorder starts at 05/08/16 10:34:46 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:34:46 ###########


########## Tcl recorder starts at 05/08/16 10:35:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:35:32 ###########


########## Tcl recorder starts at 05/08/16 10:35:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:35:33 ###########


########## Tcl recorder starts at 05/08/16 10:35:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:35:34 ###########


########## Tcl recorder starts at 05/08/16 10:36:20 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:36:21 ###########


########## Tcl recorder starts at 05/08/16 10:36:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:36:21 ###########


########## Tcl recorder starts at 05/08/16 10:36:22 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:36:22 ###########


########## Tcl recorder starts at 05/08/16 10:39:09 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:39:09 ###########


########## Tcl recorder starts at 05/08/16 10:39:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:39:10 ###########


########## Tcl recorder starts at 05/08/16 10:39:11 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:39:11 ###########


########## Tcl recorder starts at 05/08/16 10:43:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:43:17 ###########


########## Tcl recorder starts at 05/08/16 10:43:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:43:17 ###########


########## Tcl recorder starts at 05/08/16 10:43:18 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 10:43:18 ###########


########## Tcl recorder starts at 05/08/16 10:44:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:44:55 ###########


########## Tcl recorder starts at 05/08/16 10:44:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:44:55 ###########


########## Tcl recorder starts at 05/08/16 10:44:56 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:44:56 ###########


########## Tcl recorder starts at 05/08/16 10:47:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:47:29 ###########


########## Tcl recorder starts at 05/08/16 10:47:29 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:47:29 ###########


########## Tcl recorder starts at 05/08/16 10:47:30 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:47:30 ###########


########## Tcl recorder starts at 05/08/16 10:49:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:49:16 ###########


########## Tcl recorder starts at 05/08/16 10:49:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:49:16 ###########


########## Tcl recorder starts at 05/08/16 10:49:17 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 10:49:17 ###########


########## Tcl recorder starts at 05/08/16 11:08:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:08:46 ###########


########## Tcl recorder starts at 05/08/16 11:08:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:08:46 ###########


########## Tcl recorder starts at 05/08/16 11:08:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:08:47 ###########


########## Tcl recorder starts at 05/08/16 11:12:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:12:14 ###########


########## Tcl recorder starts at 05/08/16 11:12:14 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:12:14 ###########


########## Tcl recorder starts at 05/08/16 11:12:15 ##########

# Commands to make the Process: 
# Constraint Editor
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i lab11.bl5 -o lab11.sif"] {
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
	puts $rspFile "-nodal -src lab11.bl5 -type BLIF -presrc lab11.bl3 -crf lab11.crf -sif lab11.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_256_64.dev\" -lci lab11.lct
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

########## Tcl recorder end at 05/08/16 11:12:15 ###########


########## Tcl recorder starts at 05/08/16 11:16:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:16:18 ###########


########## Tcl recorder starts at 05/08/16 11:16:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:16:19 ###########


########## Tcl recorder starts at 05/08/16 11:16:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:16:20 ###########


########## Tcl recorder starts at 05/08/16 11:18:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:18:35 ###########


########## Tcl recorder starts at 05/08/16 11:18:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:18:35 ###########


########## Tcl recorder starts at 05/08/16 11:18:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:18:36 ###########


########## Tcl recorder starts at 05/08/16 11:19:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:19:49 ###########


########## Tcl recorder starts at 05/08/16 11:19:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:19:49 ###########


########## Tcl recorder starts at 05/08/16 11:19:50 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:19:50 ###########


########## Tcl recorder starts at 05/08/16 11:27:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:27:35 ###########


########## Tcl recorder starts at 05/08/16 11:27:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:27:35 ###########


########## Tcl recorder starts at 05/08/16 11:27:36 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:27:36 ###########


########## Tcl recorder starts at 05/08/16 11:30:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:30:11 ###########


########## Tcl recorder starts at 05/08/16 11:30:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:30:12 ###########


########## Tcl recorder starts at 05/08/16 11:30:13 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:30:13 ###########


########## Tcl recorder starts at 05/08/16 11:32:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" i2c.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/vlog2jhd\" lab11.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:32:39 ###########


########## Tcl recorder starts at 05/08/16 11:32:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" dffre.v -p \"$install_dir/ispcpld/generic\" -predefine lab11.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:32:39 ###########


########## Tcl recorder starts at 05/08/16 11:32:40 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open lab11.cmd w} rspFile] {
	puts stderr "Cannot create response file lab11.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: lab11.sty
PROJECT: lab11
WORKING_PATH: \"$proj_dir\"
MODULE: lab11
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" lab11.h decoder2to4.v decoderHex2Dec.v mux16to4.v counter_n.v dynamicShow.v i2c.v keyboard.v dffre.v button.v lab11.v
OUTPUT_FILE_NAME: lab11
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
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e lab11 -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf lab11.edi -out lab11.bl0 -err automake.err -log lab11.log -prj lab11 -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"lab11.bl1\" -o \"lab11.bl2\" -omod \"lab11\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj lab11 -lci lab11.lct -log lab11.imp -err automake.err -tti lab11.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -blifopt lab11.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" lab11.bl2 -sweep -mergefb -err automake.err -o lab11.bl3 @lab11.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -diofft lab11.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" lab11.bl3 -family AMDMACH -idev van -o lab11.bl4 -oxrf lab11.xrf -err automake.err @lab11.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci lab11.lct -dev lc4k -prefit lab11.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp lab11.bl4 -out lab11.bl5 -err automake.err -log lab11.log -mod lab11 @lab11.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open lab11.rs1 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs1: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -nojed -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open lab11.rs2 w} rspFile] {
	puts stderr "Cannot create response file lab11.rs2: $rspFile"
} else {
	puts $rspFile "-i lab11.bl5 -lci lab11.lct -d m4s_256_64 -lco lab11.lco -html_rpt -fti lab11.fti -fmt PLA -tto lab11.tt4 -eqn lab11.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@lab11.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete lab11.rs1
file delete lab11.rs2
if [runCmd "\"$cpld_bin/tda\" -i lab11.bl5 -o lab11.tda -lci lab11.lct -dev m4s_256_64 -family lc4k -mod lab11 -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj lab11 -if lab11.jed -j2s -log lab11.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/08/16 11:32:40 ###########

