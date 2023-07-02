/*
counter_n为计数器/分频器?

端口定义：
@clk 为传入的时钟信号
@r 同步复位端
@en 使能信号
@q 输出
@co 输出进位，既是计数器的进位输出，也是分频器的输出

参数含义：本模块中有两个参数n与counter_bits
@n 定义为n为计数器或�?�n分频�?
@counter_bits �?要保�?2^counter_bits > n
*/
module counter_n (
    clk , r , en , q , co
);
parameter n = 2;
parameter counter_bits = 1;

input clk , r , en;

output reg [counter_bits:1] q=0;
output co;

//在always外对输出信号赋�??
assign co = en && (q==n-1);
//始终上升沿对q进行增加
always @(posedge clk) begin
    if(r) q = 0;
    else if(en)
        begin
            if(q==(n-1)) q=0;
            else q = q+1;
        end
end
    
endmodule