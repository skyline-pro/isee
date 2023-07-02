module decode(
    input [3:0] test,
    output reg[6:0] out
);

    always @(*) begin
        case(test)
            0 : out = 7'b1111110;
            1 : out = 7'b0110000;
            2 : out = 7'b1101101;
            3 : out = 7'b1111001;
            4 : out = 7'b0110011;
            5 : out = 7'b1011011;
            6 : out = 7'b0011111;
            7 : out = 7'b1110000;
            8 : out = 7'b1111111;
            9 : out = 7'b1110011;
            default:out = 7'b1111110;
        endcase
    end


endmodule