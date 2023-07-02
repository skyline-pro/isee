module lcd1602 (
    input clk_50m,
    input reset,
    output [7:0] lcdD,
    output reg lcdRs,
    output reg lcdRw,
    output ledEN
);
    parameter CLEAR         = 8'b0000_0001;
    parameter SETDDRAM      = 8'b0000_0010;
    parameter SETFUNCTION   = 8'b0000_0100;
    parameter SWITCHMODE    = 8'b0000_1000;
    parameter SETMODE       = 8'b0001_0000;
    parameter RETURNCURSOR  = 8'b0010_0000;
    parameter SHIFT         = 8'b0100_0000;
    parameter WRITERAM      = 8'b1000_0000;

    parameter CUR_INC       = 1;
    parameter CUR_NOSHIFT   = 0;
    parameter OPEN_DISPLAY  = 1;
    parameter OPEN_CUR      = 0;
    parameter BLANK_CUR     = 0;
    parameter DATAWIDTH8    = 1;
    parameter DATAWIDTH4    = 0;
    parameter TWOLINE       = 1;
    parameter ONELINE       = 0;
    parameter FONT5X10      = 1;
    parameter FONT5X8       = 0;
    parameter DATA_IN       = "    01234567        89ABCEDF    ";

    // 通过系统时钟获取低频时钟
    
    reg [19:0] cnt;
    reg clkhz;
    always @(posedge clk_50m) begin
        if(cnt == 20'hfffff)
            begin
                cnt <= 0;
                clkhz <= ~ clkhz;
            end
        else
            begin
                cnt <= cnt + 1;
            end
    end
    assign ledEN = clkhz;

    //1602状态机
    reg [7:0] state;
    reg [7:0] lcdD;
    reg [5:0] dispCount;
    //TODO:检查次数位宽
    reg [255:0] dataInBuf;
    always @(posedge clkhz or negedge reset) begin
        if(!reset)begin
            lcdRs <= 0;
            lcdRw <= 0;
            lcdD <= 8'b0000_0001;
            state <= CLEAR;
            dispCount <= 6'b0;
        end
        else begin
            case (state)
                CLEAR:begin//清屏
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD <= 8'b0000_0001;
                    dataInBuf <= DATA_IN;
                    state <= SETDDRAM;
                end 
                SETDDRAM:begin//设置地址
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD <= 8'b1000_0000;
                    state <= SETFUNCTION;
                end
                SETFUNCTION:begin//工作方式设置
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD[7:5] <= 3'b001;
                    lcdD[4] <= DATAWIDTH8;
                    lcdD[3] <= TWOLINE;
                    lcdD[2] <= FONT5X8;
                    lcdD[1:0] <= 2'b00;
                    state <= SWITCHMODE;
                end
                SWITCHMODE:begin//显示开关控制
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD[7:3] <= 5'b00001;
                    lcdD[2] <= OPEN_DISPLAY;
                    lcdD[1] <= OPEN_CUR;
                    lcdD[0] <= BLANK_CUR;
                    state <= SETMODE;
                end
                SETMODE:begin//设置输入模式
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD[7:2] <= 6'b000001;
                    lcdD[1] <= CUR_INC;
                    lcdD[0] <= CUR_NOSHIFT;
                    state <= WRITERAM;
                end
                RETURNCURSOR:begin//光标归位
                    lcdRs <= 0;
                    lcdRw <= 0;
                    lcdD <= 8'b0000_0010;
                    state <= WRITERAM;
                end
                SHIFT:begin//换行后写第二行第一个字符
                    lcdRs <= 1;
                    lcdRw <= 0;
                    lcdD <= dataInBuf[255:248];
                    dataInBuf <= (dataInBuf<<8);
                    dispCount <= dispCount + 1'b1;
                    state <= WRITERAM;
                end
                WRITERAM:begin//写DDRAM显示
                    lcdRs <= 1;
                    lcdRw <= 0;
                    if(dispCount == 32)begin
                        dispCount <= 4'b0;
                        state <= CLEAR;
                    end
                    else if(dispCount == 16)begin
                        lcdRs <= 0;
                        lcdRw <= 0;
                        lcdD <= 8'b11000000;
                        state <= SHIFT;
                    end
                    else begin
                        lcdD <= dataInBuf[255:248];
                        dataInBuf <= (dataInBuf << 8);
                        dispCount <= dispCount + 1'b1;
                        state <= WRITERAM;
                    end
                end
            endcase
        end
    end


endmodule