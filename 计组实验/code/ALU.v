module ALU (
	// Outputs
	   ALUResult,
	// Inputs
	   ALUCode, A, B);
	input [3:0]	ALUCode;				// Operation select
	input [31:0]	A, B;
	output reg [31:0]	ALUResult;
	
// Decoded ALU operation select (ALUsel) signals
   parameter	 alu_add=  4'b0000;
   parameter	 alu_sub=  4'b0001;
   parameter	 alu_lui=  4'b0010;
   parameter	 alu_and=  4'b0011;
   parameter	 alu_xor=  4'b0100;
   parameter	 alu_or =  4'b0101;
   parameter 	 alu_sll=  4'b0110;
   parameter	 alu_srl=  4'b0111;
   parameter	 alu_sra=  4'b1000;
   parameter	 alu_slt=  4'b1001;
   parameter	 alu_sltu= 4'b1010;

//define some signal
   wire Binvert; //the signal control add or sub
   wire [31:0] d0,d2,d3,d4,d5,d6,d7,d8; //store diffrent result
   wire d9,d10;
   wire [31:0] convert;
   reg signed [31:0] A_reg; //use to realize >>>
   wire [31:0]B_add;
//generate Binvert and convert for the add and sub opration
   assign Binvert = ~(ALUCode == 0);
   assign convert = Binvert?32'b1111_1111_1111_1111_1111_1111_1111_1111:0;
   assign B_add = B^convert;
//assign A_reg 
   always @(*) begin
      A_reg = A;
   end


//add and sub result
   adder_32bits adder(.a(A) , .b(B_add) , .ci(Binvert) , .s(d0) , .co());
//the result of lui
   assign d2 = B;
//the result of A&B
   assign d3 = A&B;
//the result of A^B
   assign d4 = A^B;
//the result of A|B
   assign d5 = A|B;
//the result of A<<B
   assign d6 = A<<B;
//the result of A>>B
   assign d7 = A>>B;
//the result of A>>>B 
   assign d8 = A_reg >>> B;
//the result uof slt
   assign d9 = A[31]&(~B[31]) | (~B[31])&d0[31] | A[31]&d0[31];
//the result of sltu
   assign d10 = (~A[31])&d0[31] | B[31]&(d0[31]) | B[31]&d0[31];
   
//assign the ALUResult according to the ALUCode
   always @(*) begin
      case (ALUCode)
         alu_add: ALUResult <= d0;
         alu_sub: ALUResult <= d0;
         alu_lui: ALUResult <= d2;
         alu_and: ALUResult <= d3;
         alu_xor: ALUResult <= d4;
         alu_or : ALUResult <= d5;
         alu_sll: ALUResult <= d6;
         alu_srl: ALUResult <= d7;
         alu_sra: ALUResult <= d8;
         alu_slt: ALUResult <= d9;
         alu_sltu:ALUResult <= d10;
      endcase
   end

endmodule