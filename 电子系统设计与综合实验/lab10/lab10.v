module lab10 (
    //input
    input clkh , clkl,
    input reset,
    //output
    output [3:0] LEDVCC,
    output [6:0] show,
    //inout
    inout keyClock,
    inout keyData
);
    wire resetButton;
    button button0(.keyin(reset) , .clk(clkl) , .keyout(resetButton));


    wire [3:0] data;
    PS2Keyboard ps(.clk(clkh) , .reset(resetButton) , .psData(data) , .keyClock(keyClock) , .keyData(keyData));
    
    dynamicshow dynamicshow(.Data0(data) , .Data1(4'hF) , .Data2(4'hF) , .Data3(4'hF) , .clk(clkl) , .show(show) , .LEDVCC(LEDVCC));
    
endmodule