module mux3 (
    a0,a1,a2,select,s
);
parameter n = 32;
input [n-1 : 0] a0 , a1 , a2;
input [1 : 0] select;
output reg [n-1 : 0] s;

always @(*) begin
    case (select)
        0 : s <= a0;
        1 : s <= a1;
        2 : s <= a2;
    endcase
end
    
endmodule