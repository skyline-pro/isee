`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module EX(ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex,Imm_ex, rs1Addr_ex, rs2Addr_ex, rs1Data_ex, 
          rs2Data_ex, PC_ex, RegWriteData_wb, ALUResult_mem,rdAddr_mem, rdAddr_wb, 
		  RegWrite_mem, RegWrite_wb, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);
    //input
    input [3:0] ALUCode_ex;
    input ALUSrcA_ex;
    input [1:0]ALUSrcB_ex;
    input [31:0] Imm_ex;
    input [4:0]  rs1Addr_ex;
    input [4:0]  rs2Addr_ex;
    input [31:0] rs1Data_ex;
    input [31:0] rs2Data_ex;
	input [31:0] PC_ex;
    input [31:0] RegWriteData_wb;
    input [31:0] ALUResult_mem;
	input [4:0]rdAddr_mem;
    input [4:0] rdAddr_wb;
    input RegWrite_mem;
    input RegWrite_wb;
    //output
    output [31:0] ALUResult_ex;
    output [31:0] MemWriteData_ex;
    output [31:0] ALU_A;
    output [31:0] ALU_B;

    //define and assign the signal to select the output of mux
    wire [1:0] ForwardA , ForwardB;

    assign ForwardA[0] = RegWrite_wb && (rdAddr_wb != 0) && (rdAddr_mem != rs1Addr_ex) && (rdAddr_wb == rs1Addr_ex);
    assign ForwardA[1] = RegWrite_mem && (rdAddr_mem != 0) && (rdAddr_mem == rs1Addr_ex);
    assign ForwardB[0] = RegWrite_wb && (rdAddr_wb != 0) && (rdAddr_mem != rs2Addr_ex) && (rdAddr_wb == rs2Addr_ex);
    assign ForwardB[1] = RegWrite_mem && (rdAddr_mem != 0) && (rdAddr_mem == rs2Addr_ex);

    //define some temp varibles for the forward part mux
    wire [31 : 0] A_temp , B_temp;

    mux3 #(.n(32)) mux_B(
        .a0(rs2Data_ex),
        .a1(RegWriteData_wb),
        .a2(ALUResult_mem),
        .select(ForwardB),
        .s(B_temp)
    );

    assign MemWriteData_ex = B_temp;

    mux3 #(.n(32)) mux_A(
        .a0(rs1Data_ex),
        .a1(RegWriteData_wb),
        .a2(ALUResult_mem),
        .select(ForwardA),
        .s(A_temp)
    );

    //use two mux to select ALU_A and ALU_B
    mux2 #(.n(32)) mux_ALUA(
        .a0(A_temp),
        .a1(PC_ex),
        .select(ALUSrcA_ex),
        .s(ALU_A)
    );

    mux3 #(.n(32)) mux_ALUB(
        .a0(B_temp),
        .a1(Imm_ex),
        .a2(32'b0100),
        .select(ALUSrcB_ex),
        .s(ALU_B)
    );

    //define a ALU
    ALU ALU(
        .ALUResult(ALUResult_ex),
        .ALUCode(ALUCode_ex),
        .A(ALU_A),
        .B(ALU_B)
    );

endmodule
