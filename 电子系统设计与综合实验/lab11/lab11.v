module lab11 (
    input clkh , clkl,
    input reset,
    input CMD_RD , CMD_WR,
    input [3:0] keyIn,
    output [4:0] led,
    output [3:0] keyOut,
    output [3:0] LEDVCC,
    output [6:0] show,
    output SCL,
    inout SDA
);

    wire resetButton;
    wire [3:0] keyInButton;
    button button0(.keyin(reset) , .clk(clkl) , .keyout(resetButton));
    button button1(.keyin(keyIn[0]) , .clk(clkl) , .keyout(keyInButton[0]));
    button button2(.keyin(keyIn[1]) , .clk(clkl) , .keyout(keyInButton[1]));
    button button3(.keyin(keyIn[2]) , .clk(clkl) , .keyout(keyInButton[2]));
    button button4(.keyin(keyIn[3]) , .clk(clkl) , .keyout(keyInButton[3]));

    wire [3:0] data0 ,data1, data2 , data3;
    keyboard keyboard(.clk(clkh) , .reset(resetButton) , .key_in(keyInButton) , .key_out(keyOut) , .led(led) , .led_int_Data0(data2) , .led_int_Data1(data3));

    i2c i2c(.CMD_RD(CMD_RD) , .CMD_WR(CMD_WR) , .CLK(clkh) , .RST(reset), .DATA_IN(data2) , .DATA_IN2(data3), .SCL(SCL) , .SDA(SDA) , .DataLED(data0) , .DataLED2(data1) );

    dynamicshow dynamicshow(.Data0(data0) , .Data1(data1) , .Data2(data2) , .Data3(data3) , .clk(clkl) , .show(show) , .LEDVCC(LEDVCC));
    
endmodule