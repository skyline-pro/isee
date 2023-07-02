module counter_n (
    clk , r , en , q , co
);
parameter n = 2;
parameter counter_bits = 1;

input clk , r , en;

output reg [counter_bits:1] q=0;
output co;


assign co = en && (q==n-1);

always @(posedge clk) begin
    if(r) q = 0;
    else if(en)
        begin
            if(q==(n-1)) q=0;
            else q = q+1;
        end
end
    
endmodule
