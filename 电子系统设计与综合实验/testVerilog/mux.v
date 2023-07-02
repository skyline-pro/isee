module mux (
    a0,a1,a2,a3,select,s
);
parameter n = 4;
input [n-1 : 0] a0 , a1 , a2 , a3;
input [1 : 0] select;
output reg [n-1 : 0] s;

always @(*) begin
    case (select)
        0 : s <= a0;
        1 : s <= a1;
        2 : s <= a2;
	    3 : s <= a3;
    endcase
end
    
endmodule
