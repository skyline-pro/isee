module lab12 (
    input clkh , reset,
    output [7:0] col , row
);

    
    wire clkl;
    
    counter_n #(.n(48829) , .counter_bits(16)) conter(.clk(clkh) , .r(1'b0) , .en(1'b1) , .q() , .co(clkl));

    wire resetButton;
    button button1(.keyin(reset) , .clk(clkl) , .keyout(resetButton));

    ledDotMatrix led1(.clk(clkh) , .reset(resetButton) , .ledRow(row) , .ledCol(col));
    
endmodule