module random( 
    input key,clk,r,
    output [3:0] rand1 , rand2
);
    counter_n #(.n(6) , .counter_bits(3)) randGen(.clk(clk) , .r(r) , .en(key) , .q(rand1) ,.co());
    wire clk2;
    counter_n clkGen(.clk(clk) , .r(r) ,.en(1) , .q() , .co(clk2));
    counter_n #(.n(6) , .counter_bits(3)) randGen2(.clk(clk2) , .r(r) , .en(key) , .q(rand2), .co());
    
endmodule
