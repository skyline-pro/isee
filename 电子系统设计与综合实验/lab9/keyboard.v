module keyboard (
    input clk,
    input reset,
    input [3:0] key_in,
    output reg [3:0] key_out,
    output reg [4:0] led,
    output reg [3:0] led_int_Data1,
    output reg [3:0] led_int_Data0
);

    reg [7:0]combvalue;
    reg [3:0]scanvalue;
    reg time1Oms;
    reg [15:0] timecnt;

    always @(posedge time1Oms or negedge reset) //clklow为低频128Hz
    begin
        if(reset == 0)
            begin
                scanvalue <= 1;
                led<=5'b11111;
                combvalue<=0;
            end
        else
            begin
                key_out <= scanvalue;
                case(scanvalue)
                    4'b0001:scanvalue<=4'b0010;
                    4'b0010:scanvalue<=4'b0100;
                    4'b0100:scanvalue<=4'b1000;
                    4'b1000:scanvalue<=4'b0001;
                    default:scanvalue<=4'b0001;
                endcase
                combvalue <={key_in , key_out};
                case(combvalue)
                    8'b00010001 : led <= 5'b11110;//1
                    8'b00100001 : led <= 5'b11101;//2
                    8'b01000001 : led <= 5'b11100;//3
                    8'b00010010 : led <= 5'b11010;//4
                    8'b00100010 : led <= 5'b11001;//5
                    8'b01000010 : led <= 5'b11000;//6
                    8'b00010100 : led <= 5'b10110;//7
                    8'b00100100 : led <= 5'b10101;//8
                    8'b01000100 : led <= 5'b10100;//9
                    8'b00011000 : led <= 5'b10010;//0
                    8'b10000001 : led <= 5'b11011;//X
                    8'b10000010 : led <= 5'b10111;//Y
                    8'b10000100 : led <= 5'b10011;//Z
                    8'b00101000 : led <= 5'b10001;//+
                    8'b01001000 : led <= 5'b10000;//-
                    8'b10001000 : led <= 5'b01111;//<=
                    default: led <= 5'b11111;
                endcase
            end
    end


    always @(posedge clk or negedge reset) //clk 为系统时钟信号6MHz
    begin
        if(reset==1'b0) timecnt<=0; //timecnt 为分频计数器， 用来得到lOms 时钟
        else if(timecnt==29999)
            begin
                time1Oms<=~time1Oms; //time1Oms 为lOms 时钟
                timecnt<=0;
            end
        else timecnt<=timecnt+ 1;
    end

    reg [1:0] flag_Data;
    reg flag_Over;
    reg [3:0] int_Data0;
    reg [3:0] int_Data1;
    reg [9:0] int_Data;
    reg [9:0] temp;
    always @(posedge time1Oms or negedge reset)
    begin
        if(reset == 0)
            begin
                flag_Data <= 0;
                flag_Over <= 0;
                int_Data0 <= 0;
                int_Data1 <= 0;
                int_Data <= 0;
                temp <= 0;
                led_int_Data1 <=0;
                led_int_Data0 <=0;
            end
        else 
            begin

                case ({key_in , key_out})
                    8'b00010001://1
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=1; led_int_Data0<=1;flag_Data<=1;end
                                2: begin int_Data1<=1; led_int_Data0<=1;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00100001://2
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=2; led_int_Data0<=2;flag_Data<=1;end
                                2: begin int_Data1<=2; led_int_Data0<=2;flag_Data<=3;end 
                                default: ;
                            endcase
                        end 
                    8'b01000001://3
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=3; led_int_Data0<=3;flag_Data<=1;end
                                2: begin int_Data1<=3; led_int_Data0<=3;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00010010://4
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=4; led_int_Data0<=4;flag_Data<=1;end
                                2: begin int_Data1<=4; led_int_Data0<=4;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00100010://5
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=5; led_int_Data0<=5;flag_Data<=1;end
                                2: begin int_Data1<=5; led_int_Data0<=5;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b01000010://6
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=6; led_int_Data0<=6;flag_Data<=1;end
                                2: begin int_Data1<=6; led_int_Data0<=6;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00010100://7
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=7; led_int_Data0<=7;flag_Data<=1;end
                                2: begin int_Data1<=7; led_int_Data0<=7;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00100100://8
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=8; led_int_Data0<=8;flag_Data<=1;end
                                2: begin int_Data1<=8; led_int_Data0<=8;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b01000100://9
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=9; led_int_Data0<=9;flag_Data<=1;end
                                2: begin int_Data1<=9; led_int_Data0<=9;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b00011000://0
                        begin
                            case (flag_Data)
                                0: begin int_Data0<=0; led_int_Data0<=0;flag_Data<=1;end
                                2: begin int_Data1<=0; led_int_Data0<=0;flag_Data<=3;end 
                                default: ;
                            endcase
                        end
                    8'b10000001:;//X
                    8'b10000010:;//Y
                    8'b10000100:;//Z
                    8'b00101000:;//+
                    8'b01001000:;//-
                    8'b10001000://<=
                        begin
                            if(flag_Data == 3) begin
                                case(int_Data1)
                                    4'b0000: led_int_Data0<=0;
                                    4'b0001: led_int_Data0<=1;
                                    4'b0010: led_int_Data0<=2;
                                    4'b0011: led_int_Data0<=3;
                                    4'b0100: led_int_Data0<=4;
                                    4'b0101: led_int_Data0<=5;
                                    4'b0110: led_int_Data0<=6;
                                    4'b0111: led_int_Data0<=7;
                                    4'b1000: led_int_Data0<=8;
                                    4'b1001: led_int_Data0<=9;
                                endcase
                            flag_Data <= 0;
                            end
                            else if(flag_Data == 1)begin
                                case(int_Data0)
                                    4'b0000: led_int_Data1<=0;
                                    4'b0001: led_int_Data1<=1;
                                    4'b0010: led_int_Data1<=2;
                                    4'b0011: led_int_Data1<=3;
                                    4'b0100: led_int_Data1<=4;
                                    4'b0101: led_int_Data1<=5;
                                    4'b0110: led_int_Data1<=6;
                                    4'b0111: led_int_Data1<=7;
                                    4'b1000: led_int_Data1<=8;
                                    4'b1001: led_int_Data1<=9;
                                endcase
                                led_int_Data0 <=0;
                                flag_Data <= 2;
                            end
                        end
                    default: ;
                endcase
            end
    end

    // always @(time1Oms,reset) begin
    //     if(reset==0)
    //         begin
    //             led_int_Data1<=0;led_int_Data0<=0;
    //         end
    //     else
    //         begin
    //             if(int_Data >79)
    //                 begin
    //                     led_int_Data1<=8;led_int_Data0<=int_Data-80;
    //                 end
    //                     else if(int_Data > 69) begin led_int_Data1<=7;led_int_Data0<=int_Data-70; end
    //                     else if(int_Data > 59) begin led_int_Data1<=6;led_int_Data0<=int_Data-60; end
    //                     else if(int_Data > 49) begin led_int_Data1<=5;led_int_Data0<=int_Data-50; end
    //                     else if(int_Data > 39) begin led_int_Data1<=4;led_int_Data0<=int_Data-40; end
    //                     else if(int_Data > 29) begin led_int_Data1<=3;led_int_Data0<=int_Data-30; end
    //                     else if(int_Data > 19) begin led_int_Data1<=2;led_int_Data0<=int_Data-20; end
    //                     else if(int_Data > 9) begin led_int_Data1<=1;led_int_Data0<=int_Data-10; end
    //             else
    //                 begin
    //                     led_int_Data1<=0;
    //                     led_int_Data0 <= int_Data;
    //                 end
                
    //         end
    // end

endmodule