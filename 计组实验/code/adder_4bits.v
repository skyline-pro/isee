module adder_4bits(
    input [3:0] a , b,
    input ci,
    output [3:0] s , 
    output co
);
    wire [3:0] P , G;
    wire [3:0] C;

    assign G = a & b;
    assign P = a | b;
    
    assign C[0] = G[0] | P[0]&ci;
    assign C[1] = G[1] | P[1]&G[0] | P[1]&P[0]&ci;
    assign C[2] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&ci;
    assign C[3] = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&ci;

    assign s[0] = P[0]&(~G[0])^ci;
    assign s[1] = P[1]&(~G[1])^C[0];
    assign s[2] = P[2]&(~G[2])^C[1];
    assign s[3] = P[3]&(~G[3])^C[2];

    assign co = C[3];
    
endmodule