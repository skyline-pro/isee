`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Branch,Jump, IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output [31:0] PC;
    output IF_flush;

    //define PC register
    reg [31:0] PC;
    //some other variables
    wire [31:0] NextPC_if , PCSource , NextPC;

    assign IF_flush = Branch | Jump;
    assign PCSource = IF_flush;

    adder_32bits adder_PC(
        .a(PC),
        .b(32'b0100),
        .ci(0),
        .s(NextPC_if),
        .co()
    );

    //generate next PC
    mux2 #(.n(32)) mux_PC(
        .a0(NextPC_if),
        .a1(JumpAddr),
        .select(PCSource),
        .s(NextPC)
    );


    //get new value of PC register
    always @(posedge clk) begin
        if(reset) PC <= 0;
        else if(IFWrite) PC <= NextPC;
        else PC <= PC;
    end

    //instantiation a InstructionROM
    InstructionROM IROM(
        .addr(PC[7:2]),
        .dout(Instruction_if)
    );


endmodule
