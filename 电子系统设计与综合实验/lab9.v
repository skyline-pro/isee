module lab9 (
    input clk,
    input reset,
    input dout,
    input Rx,
    input [7:0] Data_Send,
    output reg TX,
    output reg [3:0] Data1,
    output reg [3:0] Data2
    
);

    //产生时钟
    reg [10:0] ClockCount;
    reg [6:0] ClockCount_Rx;
    reg Clock9600;
    reg Clock16;
    always @(posedge clk or negedge reset) begin
        if(reset == 0);
        else
        begin
            if(ClockCount == 624)begin Clock9600 <= 1; ClockCount <= 0; end
            else begin Clock9600 <= 0;ClockCount <= ClockCount+1;end

            if(ClockCount_Rx == 38)begin Clock16 <= 1; ClockCount_Rx <= 0; end
            else begin Clock16 <= 0; ClockCount_Rx <= ClockCount_Rx+1; end
        end
    end

    //串口发送部分
    reg [3:0] Send_count;
    reg Send_over;
    reg [9:0] Send_data;
    reg Send_en;
    always @(posedge Clock9600 or posedge Send_en)
    begin
        if(Send_en == 1)begin Send_count <= 0 ; TX <= 1;Send_over<=1;end
        else if(Send_count == 9)begin TX <= Send_data[9] ; Send_over<=0;end
        else begin TX <= Send_data[Send_count] ; Send_count <= Send_count+1;end
    end

    always @(posedge dout or negedge reset or negedge Send_over)
    begin
        if(reset == 0) begin Send_en <= 1;Send_data <= 10'b1000_0000_00;end
        else if(Send_over == 0)begin Send_en<=1;Send_data <= 10'b1000_0000_00;end
        else    
            begin
                Send_en <= 0;
                Send_data <= {1'b1 , Data_Send , 1'b0};
            end
    end

    //串口接收
    reg Rx_Hold;
    always @(Rx or reset)
    begin
        if(reset == 0) Rx_Hold <= 0;
        else if(Rx == 0) Rx_Hold <= 1;
        else Rx_Hold <= 0;
    end

    //接收进程
    reg Rx_Valid;
    reg [7:0] m;
    reg [7:0] Rx_Data;
    always @(posedge Clock16 or negedge reset) begin
        if(reset == 0) begin Rx_Valid <= 0; m<=0;end
        else
            begin
                case (m)
                    0:
                        begin
                            if(Rx_Hold == 1)
                                begin
                                    m <= m+1;
                                end
                            else
                                begin
                                    m<=0;
                                    Rx_Valid<=0;
                                end
                        end

                    24: begin Rx_Data[0]<=Rx;m<=m+1;end
                    40: begin Rx_Data[1]<=Rx;m<=m+1;end
                    56: begin Rx_Data[2]<=Rx;m<=m+1;end
                    72: begin Rx_Data[3]<=Rx;m<=m+1;end
                    88: begin Rx_Data[4]<=Rx;m<=m+1;end
                    104: begin Rx_Data[5]<=Rx;m<=m+1;end
                    120: begin Rx_Data[6]<=Rx;m<=m+1;end
                    136: begin Rx_Data[7]<=Rx;m<=m+1;end
                    152: begin Rx_Valid<=1;m<=m+1;end
                    168: begin m<=0;Rx_Valid<=0; end
                    default: m<=m+1;
                endcase
            end
    end

    //送显
    always @(negedge Rx_Valid or negedge reset) begin
        if(reset == 0) begin Data1 <= 0;Data2<=0;end
        else
            begin
                Data1<={Rx_Data[3],Rx_Data[2],Rx_Data[1],Rx_Data[0]};
                Data2<={Rx_Data[7],Rx_Data[6],Rx_Data[5],Rx_Data[4]};
            end
    end


endmodule