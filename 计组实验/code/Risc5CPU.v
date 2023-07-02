`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module Risc5CPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult_ex, PC, MemDout_mem,Stall);
    input clk;
    input reset;
    output[1:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult_ex;
    output [31:0] PC;
    output [31:0] MemDout_mem;
    output Stall;


    //IF output signals
    wire [31:0] Instruction_if,PC_if;
    wire IF_flush;
    
    //IF_ID output signals
    wire [31:0] PC_id;

    //ID output signals
    wire MemtoReg_id;
    wire RegWrite_id;
    wire MemWrite_id;
    wire MemRead_id;
    wire [3:0] ALUCode_id;
    wire ALUSrcA_id;
    wire [1:0]ALUSrcB_id;
    wire Branch;
    wire Jump;
    wire IFWrite;
    wire [31:0] JumpAddr;
    wire [31:0] Imm_id;
    wire [31:0] rs1Data_id;
    wire [31:0] rs2Data_id;
	wire[4:0] rs1Addr_id,rs2Addr_id,rdAddr_id;

    //ID_EX output signal
    wire MemtoReg_ex,RegWrite_ex,MemWrite_ex,MemRead_ex;
    wire [3:0] ALUCode_ex;
    wire ALUSrcA_ex;
    wire [1:0] ALUSrcB_ex;
    wire [31:0] PC_ex;
    wire [31:0] Imm_ex;
    wire [4:0] rs1Addr_ex, rs2Addr_ex,rdAddr_ex;
    wire [31:0] rs1Data_ex, rs2Data_ex;

    //EX output signal
    wire [31:0]MemWriteData_ex;

    //EX_MEM output signal
    wire MemtoReg_mem,RegWrite_mem,MemWrite_mem;
    wire [31:0] ALUResult_mem,MemWriteData_mem;
    wire [4:0] rdAddr_mem;


    //MEM_WB output signal
    wire MemtoReg_wb,RegWrite_wb;
    wire [31:0] MemDout_wb,ALUResult_wb;
    wire [4:0] rdAddr_wb;

    //WB output signal
    wire [31:0] RegWriteData_wb;

    assign JumpFlag = {Jump,Branch};
    assign PC = PC_if;


    IF IF(
        .clk(clk),
        .reset(reset),
        .Branch(Branch),
        .Jump(Jump),
        .IFWrite(IFWrite),
        .JumpAddr(JumpAddr),
        .Instruction_if(Instruction_if),
        .PC(PC_if),
        .IF_flush(IF_flush)
    );

    IF_ID IF_ID(
        .en(IFWrite),
        .r(IF_flush|reset),
        .clk(clk),
        .PC_if(PC_if),
        .instruction_if(Instruction_if),
        .PC_id(PC_id),
        .instruction_id(Instruction_id)
    );

    ID ID(
        .clk(clk),
        .Instruction_id(Instruction_id),
        .PC_id(PC_id),
        .RegWrite_wb(RegWrite_wb),
        .rdAddr_wb(rdAddr_wb),
        .RegWriteData_wb(RegWriteData_wb),
        .MemRead_ex(MemRead_ex),
        .rdAddr_ex(rdAddr_ex),

        //output
        .MemtoReg_id(MemtoReg_id),
        .RegWrite_id(RegWrite_id),
        .MemWrite_id(MemWrite_id),
        .MemRead_id(MemRead_id),
        .ALUCode_id(ALUCode_id),
        .ALUSrcA_id(ALUSrcA_id),
        .ALUSrcB_id(ALUSrcB_id),
        .Stall(Stall),
        .Branch(Branch),
        .Jump(Jump),
        .IFWrite(IFWrite),
        .JumpAddr(JumpAddr),
        .Imm_id(Imm_id),
        .rs1Data_id(rs1Data_id),
        .rs2Data_id(rs2Data_id),
        .rs1Addr_id(rs1Addr_id),
        .rs2Addr_id(rs2Addr_id),
        .rdAddr_id(rdAddr_id)
    );

    ID_EX ID_EX(
        //input
        .r(Stall|reset),
        .clk(clk),
        .MemtoReg_id(MemtoReg_id),
        .RegWrite_id(RegWrite_id),
        .MemWrite_id(MemWrite_id),
        .MemRead_id(MemRead_id),
        .ALUCode_id(ALUCode_id),
        .ALUSrcA_id(ALUSrcA_id),
        .ALUSrcB_id(ALUSrcB_id),
        .PC_id(PC_id),
        .Imm_id(Imm_id),
        .rs1Data_id(rs1Data_id),
        .rs2Data_id(rs2Data_id),
        .rs1Addr_id(rs1Addr_id),
        .rs2Addr_id(rs2Addr_id),
        .rdAddr_id(rdAddr_id),
        //output
        .MemtoReg_ex(MemtoReg_ex),
        .RegWrite_ex(RegWrite_ex),
        .MemWrite_ex(MemWrite_ex),
        .MemRead_ex(MemRead_ex),
        .ALUCode_ex(ALUCode_ex),
        .ALUSrcA_ex(ALUSrcA_ex),
        .ALUSrcB_ex(ALUSrcB_ex),
        .PC_ex(PC_ex),
        .Imm_ex(Imm_ex),
        .rs1Addr_ex(rs1Addr_ex),
        .rs2Addr_ex(rs2Addr_ex),
        .rs1Data_ex(rs1Data_ex),
        .rs2Data_ex(rs2Data_ex),
        .rdAddr_ex(rdAddr_ex)
    );

    EX EX(
        //input
        .ALUCode_ex(ALUCode_ex),
        .ALUSrcA_ex(ALUSrcA_ex),
        .ALUSrcB_ex(ALUSrcB_ex),
        .Imm_ex(Imm_ex),
        .rs1Addr_ex(rs1Addr_ex),
        .rs2Addr_ex(rs2Addr_ex),
        .rs1Data_ex(rs1Data_ex),
        .rs2Data_ex(rs2Data_ex),
        .PC_ex(PC_ex),
        .RegWriteData_wb(RegWriteData_wb),
        .ALUResult_mem(ALUResult_mem),
        .rdAddr_mem(rdAddr_mem),
        .rdAddr_wb(rdAddr_wb),
        .RegWrite_mem(RegWrite_mem),
        .RegWrite_wb(RegWrite_wb),
        //output
        .ALUResult_ex(ALUResult_ex),
        .MemWriteData_ex(MemWriteData_ex),
        .ALU_A(ALU_A),
        .ALU_B(ALU_B)
    );

    EX_MEM EX_MEM(
        //input
        .clk(clk),
        .MemtoReg_ex(MemtoReg_ex),
        .RegWrite_ex(RegWrite_ex),
        .MemWrite_ex(MemWrite_ex),
        .ALUResult_ex(ALUResult_ex),
        .MemWriteData_ex(MemWriteData_ex),
        .rdAddr_ex(rdAddr_ex),
        //output
        .MemtoReg_mem(MemtoReg_mem),
        .RegWrite_mem(RegWrite_mem),
        .MemWrite_mem(MemWrite_mem),
        .ALUResult_mem(ALUResult_mem),
        .MemWriteData_mem(MemWriteData_mem),
        .rdAddr_mem(rdAddr_mem)
    );

    DataRAM your_instance_namedataRAM (
        //inout
        .a(ALUResult_mem[7:2]), 
        .d(MemWriteData_mem), 
        .clk(clk), 
        .we(MemWrite_mem), 
        //output
        .spo(MemDout_mem) 
    );

    MEM_WB MEM_WB(
        .clk(clk),
        .MemtoReg_mem(MemtoReg_mem),
        .RegWrite_mem(RegWrite_mem),
        .MemDout_mem(MemDout_mem),
        .ALUResult_mem(ALUResult_mem),
        .rdAddr_mem(rdAddr_mem),
        //output
        .MemtoReg_wb(MemtoReg_wb),
        .RegWrite_wb(RegWrite_wb),
        .MemDout_wb(MemDout_wb),
        .ALUResult_wb(ALUResult_wb),
        .rdAddr_wb(rdAddr_wb)
    );

    //WB
    mux2 #(.n(32)) mux_WB(
        .a0(ALUResult_wb),
        .a1(MemDout_wb),
        .select(MemtoReg_wb),
        .s(RegWriteData_wb)
    );






endmodule
