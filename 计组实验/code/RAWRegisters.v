module RAWRegisters(
    input [4:0] rs1Addr , rs2Addr , WriteAddr,
    input [31:0] WriteData,
    input clk , RegWrite,
    output [31:0] rs1Data , rs2Data 
);
    //the variables store temprary readDate
    wire [31:0] ReadData1 , ReadData2;
    //the signal to indicate whether to forward
    wire rs1Sel , rs2Sel;
    //define the regs
    reg [31:0] regs[31:0];

    //assign the value of temprary readData
    assign ReadData1 = (rs1Addr == 5'b0)?31'b0:regs[rs1Addr];
    assign ReadData2 = (rs2Addr == 5'b0)?31'b0:regs[rs2Addr];

    //assign the values of select signal
    assign rs1Sel = RegWrite & (WriteAddr != 0) & (WriteAddr == rs1Addr);
    assign rs2Sel = RegWrite & (WriteAddr != 0) & (WriteAddr == rs2Addr);

    //write data into regs
    always @(posedge clk) begin
        if(RegWrite) regs[WriteAddr] <= WriteData;
    end

    //if need forward , choose WriteData as output,else choose the data from regs
    assign rs1Data = (rs1Sel == 1)?WriteData:ReadData1;
    assign rs2Data = (rs2Sel == 1)?WriteData:ReadData2;

    
endmodule