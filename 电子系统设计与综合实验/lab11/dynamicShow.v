module dynamicshow (
    input [3:0] Data0,Data1,Data2,Data3,
    input clk,
    output [6:0] show,
    output [3:0] LEDVCC
);
    wire [1:0] sel;
    counter_n #(.n(4) , .counter_bits(2)) counter4(.clk(clk) , .r(1'b0) , .en(1'b1) , .q(sel) , .co());

    wire [3:0] out;
    mux16to4 mux(.Data0(Data0) , .Data1(Data1) , .Data2(Data2) , .Data3(Data3) , .sel(sel) , .DataOut(out));

    decoderHex2Dec decoder1(.data(out) , .out(show));

    decoder2to4 decoder2(.in(sel) , .out(LEDVCC));
    
endmodule