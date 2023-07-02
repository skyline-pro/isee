/*
模块名：带同步清零、输入使能的D型寄存器

端口定义：
@d:输入端
@en:输入使能信号
@r:同步清零端口
@clk:时钟信号
@q:输出信号

参数定义：
@n:寄存器位数，默认为1。当n等于1时，作为D触发器使用；当n不等于1时，作为n为D寄存器使用
*/
module dffre(
   d, en , r , clk , q
);
parameter n = 1;//当n等于1时，作为D触发器使用；当n不等于1时，作为n为D寄存器使用
input en , r , clk; //en为使能信号，r为异步置零端，clk为时钟信号
input [n-1:0] d; 
output reg [n-1:0] q; 

always @(posedge clk) begin
    if(r) q = {n{1'b0}}; //当同步置零信号有效时，将寄存器所有位数置零
    else if(en) q = d;
    else q = q;
end
    
endmodule