module button (
    input keyin,
    input clk,
    output keyout
);

    wire out1, out2 , out3;

    dffre d1(.d(keyin) , .en(1'b1) , .r(1'b0) , .clk(clk) , .q(out1));
    dffre d2(.d(out1) , .en(1'b1) , .r(1'b0) , .clk(clk) , .q(out2));
    dffre d3(.d(out2) , .en(1'b1) , .r(1'b0) , .clk(clk) , .q(out3));

    assign keyout = out1|out2|out3;
    
endmodule