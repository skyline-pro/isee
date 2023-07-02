module timer (
    r , en , clk ,  done , n
);
parameter counter_bits = 6;
input [counter_bits-1:0] n;
input r , en , clk;
output  done;
reg [counter_bits:1]q;
assign done = en && (q==n-1);
always @(posedge clk) begin
    if(r) q = 0;
    else begin
        if(en)
            begin
                if(q==n-1) q=0;
                else q = 1+q;
            end
        else begin
            q=q;
        end
    end
end
endmodule