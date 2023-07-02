//利用两个D触发器作为同步器使用
module synch (
    asynch_in , clk , asynch_out
);
    input asynch_in , clk;
    output asynch_out;
    wire Q1,Q2; 
    dffre #(.n(1)) d1(.en(1) , .r(0) , .clk(clk) , .d(asynch_in) , .q(Q1));
    dffre #(.n(1)) d2(.en(1) , .r(0) , .clk(clk) , .d(Q1) , .q(Q2));
    assign asynch_out = Q1 & (~Q2);
endmodule