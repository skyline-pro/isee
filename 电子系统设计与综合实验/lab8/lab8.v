module lab8 (
    input [3:0] keyIn,
    input reset,
    input clkl , clkh,
    output [3:0] keyOut,
    output [4:0] led,
    output pointTime,
    output [6:0] show,
    output [3:0] LEDVCC
);
    wire resetButton;
    wire [3:0] keyInButton;
    button button0(.keyin(reset) , .clk(clkl) , .keyout(resetButton));
    button button1(.keyin(keyIn[0]) , .clk(clkl) , .keyout(keyInButton[0]));
    button button2(.keyin(keyIn[1]) , .clk(clkl) , .keyout(keyInButton[1]));
    button button3(.keyin(keyIn[2]) , .clk(clkl) , .keyout(keyInButton[2]));
    button button4(.keyin(keyIn[3]) , .clk(clkl) , .keyout(keyInButton[3]));

    wire [3:0] data0 , data1 , data2;

    calculate calculate(.clk(clkh) , .reset(resetButton) , .key_in(keyInButton) , .key_out(keyOut) , .led(led) , .PointTime(pointTime) , .led_int_Data0(data0) , .led_int_Data1(data1) , .led_int_Data2(data2));

    dynamicshow dynamicshow(.Data0(data0) , .Data1(data1) , .Data2(data2) , .Data3(4'b1111) , .clk(clkl) , .show(show) , .LEDVCC(LEDVCC));
    
endmodule