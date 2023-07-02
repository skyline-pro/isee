module decoderHex2Dec (
    input [3:0] data,
    output reg [6:0] out
);
    always @(*) begin
        case (data)
            0: begin out <= 7'b0000001; end
            1: begin out <= 7'b1001111; end
            2: begin out <= 7'b0010010; end
            3: begin out <= 7'b0000110; end
            4: begin out <= 7'b1001100; end
            5: begin out <= 7'b0100100; end
            6: begin out <= 7'b0100000; end
            7: begin out <= 7'b0001111; end
            8: begin out <= 7'b0000000; end
            9: begin out <= 7'b0000100; end
            10: begin out <= 7'b1111110; end
            default: out <= 7'b1111111; 
        endcase
    end
    
endmodule