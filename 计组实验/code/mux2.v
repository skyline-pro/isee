module mux2 (
    a0,a1,select,s
);
parameter n = 32;
input [n-1 : 0] a0 , a1;
input  select;
output [n-1 : 0] s;

assign s = select?a1:a0;
    
endmodule