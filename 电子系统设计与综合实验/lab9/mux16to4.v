module mux16to4 (
    input [3:0] Data0 , Data1 , Data2 , Data3,
    input [1:0] sel,
    output reg [3:0] DataOut
);
    always @(*) begin
        case (sel)
            0: DataOut <= Data0;
            1: DataOut <= Data1;
            2: DataOut <= Data2;
            3: DataOut <= Data3; 
            default: DataOut <= 4'b0000;
        endcase
    end
    
endmodule