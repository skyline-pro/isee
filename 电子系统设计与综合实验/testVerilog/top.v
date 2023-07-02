module top(
    input key , res , clk ,
    output a,b,c,d,e,f,g,pick0, pick1,pick2,pick3
);
    wire gen;
    key generator(.clk(clk) , .key(key) , .out(gen));
    wire reset;
    key rst(.clk(clk) , .key(res) , .out(reset));
    wire innerreset;
    wire [3:0] rand1 , rand2;
    random random(.key(gen) , .r(reset | innerreset) , .clk(clk) , .rand1(rand1) , .rand2(rand2));

    
    wire [3:0] countAll;
    counter_n #(.n(7) , .counter_bits(4)) timeAll(.clk(gen) , .r(reset) , .en(1'b1) , .q(countAll) , .co(innerreset));

    wire [3:0] sum;
    adder adder(.a(rand1) ,.ci(1'b0), .b(rand2) , .s(sum) , .co());

    wire [3:0] countWin;
    counter_n #(.n(7) , .counter_bits(4)) timeWin(.clk(sum==7 || sum==11) , .r(reset || innerreset) , .en(1'b1) , .q(countWin) , .co(innerreset));

    wire[1:0] choosen;
    counter_n #(.n(4) , .counter_bits(2)) scan(.clk(clk) , .r(reset || innerreset) , .en(1'b1) , .q(choosen) , .co());
    wire [3:0] choosenOne;
    mux mux(.a0(rand1) , .a1(rand2) , .a2(countAll) , .a3(countWin) , .select(choosen) , .s(choosenOne));
    decode decode(.test(choosenOne) , .out({a,b,c,d,e,f,g}));
    to4decode decode2(.src(choosen) , .out({pick0,pick1,pick2,pick3}));
endmodule