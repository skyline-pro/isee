source "C:/Users/Zhou_/AppData/Local/Synplicity/scm_perforce.tcl"
history clear
project -load E:/Grade-3_2/ISP_Project/testVerilog/proj_1.prj
add_file -verilog ./random.v
project -run  -bg 
project -run  -bg 
project -run  -bg 
project_file -remove E:/Grade-3_2/ISP_Project/testVerilog/mix.v
add_file -verilog ./decode.v
project -run  -bg 
project -run  -bg 
project -run  -bg 
text_select 9 39 9 55
text_select 9 39 9 50
text_select 8 35 8 51
project -run  -bg 
project -run  -bg 
text_select 2 17 2 22
text_select 7 14 7 19
project -run  -bg 
project -run  -bg 
project -save E:/Grade-3_2/ISP_Project/testVerilog/proj_1.prj 
project -run  -bg 
add_file -verilog -before E:/Grade-3_2/ISP_Project/testVerilog/decode.v ./mux.v
add_file -verilog -before E:/Grade-3_2/ISP_Project/testVerilog/decode.v ./mux.v
add_file -verilog -before E:/Grade-3_2/ISP_Project/testVerilog/decode.v ./random.v
add_file -verilog -before E:/Grade-3_2/ISP_Project/testVerilog/decode.v ./to4decode.v
add_file -verilog -before E:/Grade-3_2/ISP_Project/testVerilog/decode.v ./top.v
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -run  -bg 
project -save E:/Grade-3_2/ISP_Project/testVerilog/proj_1.prj 
project -close E:/Grade-3_2/ISP_Project/testVerilog/proj_1.prj
