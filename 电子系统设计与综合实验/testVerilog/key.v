module key( 
    input clk ,
    input key ,
    output  out
);
    wire w;
    assign w = !out & key;
    counter_n #(.counter_bits(5) , .n(32)) key1(.clk(clk) , .r(!key) , .en(w) , .q() , .co(out));

endmodule
