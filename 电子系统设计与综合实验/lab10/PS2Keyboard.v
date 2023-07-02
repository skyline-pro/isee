module PS2Keyboard (
    //输入
    input clk , reset,
    //输出
    output reg [3:0] psData,
    //双向
    inout keyClock,
    inout keyData
);

    reg keyClock_r0 , keyClock_r1 , keyClock_r2;//用于滤波
    always @(posedge clk or negedge reset) begin
        if(!reset)begin
            keyClock_r0 <= 1'b0;
            keyClock_r1 <= 1'b0;
            keyClock_r2 <= 1'b0;
        end
        else begin
            keyClock_r0 <= keyClock;
            keyClock_r1 <= keyClock_r0;
            keyClock_r2 <= keyClock_r1;
        end
    end

    wire neg_keyClock;//keyClock的下降沿
    assign neg_keyClock = ~keyClock_r1 & keyClock_r2;

    //接收扫描码
    reg [3:0] counter;  //计数器，用于判断是否接收完成
    reg RxEn;           //接收完成标志，下降沿代表接收完成
    reg [10:0] RxData;   //缓存接收到的数据
    always @(posedge clk or negedge reset) begin
        if(!reset)begin
            counter <= 0;
            RxEn <= 1;
        end
        else if(neg_keyClock)begin
            RxData[counter] <= keyData;
            if(counter >= 10) RxEn <= 0;
            else RxEn <= 1;
            if(counter >= 10) counter <= 0;
            else counter <= counter + 1;
        end
    end

    //避免一个按键产生两个数据
    reg [7:0] lastRxData;   //记录上一次接受到的数据
    reg ledEn;              //是否允许数码管显示
    always @(negedge RxEn or negedge reset) begin
        if(!reset)begin
            lastRxData <= 8'h45;
            ledEn <= 0;
        end
        else if(RxEn == 0)begin
            if(lastRxData == 8'hF0) ledEn <= 1;
            else ledEn <= 0;
            lastRxData <= RxData[8:1];
        end
    end

    //翻译扫描码
    reg [3:0] save;
    always @(lastRxData or reset or ledEn) begin
        if(!reset)begin
            psData <= 0;
        end
        else if(!ledEn)begin
            case (lastRxData)
                8'b01000101: begin psData <= 4'b0000; save <= 4'b0000;end 
                8'b00010110: begin psData <= 4'b0001; save <= 4'b0001;end
                8'b00011110: begin psData <= 4'b0010; save <= 4'b0010;end
                8'b00100110: begin psData <= 4'b0011; save <= 4'b0011;end
                8'b00100101: begin psData <= 4'b0100; save <= 4'b0100;end
                8'b00101110: begin psData <= 4'b0101; save <= 4'b0101;end
                8'h36: begin psData <= 4'h6; save <= 4'h6;end
                8'h3D: begin psData <= 4'h7; save <= 4'h7;end
                8'h3E: begin psData <= 4'h8; save <= 4'h8;end
                8'h46: begin psData <= 4'h9; save <= 4'h9;end 
                default: psData <= save;
            endcase
        end
    end


endmodule