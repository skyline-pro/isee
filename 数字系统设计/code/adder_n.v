/*
模块：n位加法器

端口定义：
@adder1:第一位加数
@adder2:第二位加数
@result:计算结果
@co:进位输出

参数定义：
@n:加法器位数
*/

module adder_n (
    adder1 , adder2 , result , co
);
parameter n = 22;

input [n:1] adder1 , adder2;
output [n:1] result;
output co;

assign {co ,result} = adder1+adder2;
    
endmodule