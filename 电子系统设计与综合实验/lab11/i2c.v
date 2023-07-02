module i2c (
    input CMD_RD , CMD_WR,//读写命令输入
    input CLK , RST,
    input [3:0] DATA_IN,DATA_IN2,//输入的四位数据
    output SCL,
    inout SDA,//数据总线以及时钟线
    output reg [3:0] DataLED , DataLED2
);
    //设置从机地址以及存储空间地址
    parameter i2c_addr = 7'b1010000 , eeprom_addr = 8'b0000_0110;

    reg scl_buf;
    reg sda_buf;
    reg Flag_RW;
    assign SCL = scl_buf;
    assign SDA = (Flag_RW)?sda_buf:1'bz;


    reg phase0 , phase1 , phase2 , phase3;
    reg [3:0] clk_div;
    always @(posedge CLK or negedge RST) 
    begin
        if(RST==0)
        begin
            phase0 <= 0;
            phase1 <= 0;
            phase2 <= 0;
            phase3 <= 0;
            clk_div <= 0;
        end
        else
        begin
            if(clk_div != 4'b1111) clk_div <= clk_div + 4'b0001;
            else clk_div <= 0;
            //phase0:上升沿
            if(phase0 == 1) phase0 <= 0;
            else if(clk_div == 4'b1111) phase0 <= 1;
            //phase1:1的中间时刻
            if(phase1 == 1) phase1 <= 0;
            else if(clk_div == 4'b0011) phase1 <= 1;
            //phase2:下降沿
            if(phase2 == 1) phase2 <= 0;
            else if(clk_div == 4'b0111) phase2 <= 1;
            //phase3:0的中间时刻
            if(phase3 == 1) phase3 <= 0;
            else if(clk_div == 4'b1011) phase3 <= 1;
        end
    end

    //按键消抖的延时进程
    reg start_delay;
    reg [9:0] key_delay;
    always @(posedge CLK or negedge RST) 
    begin
        if(RST == 0) key_delay <= 0;//按键消抖计数器
        else if(start_delay == 1) key_delay <= key_delay + 1;
        else key_delay <= 0;
    end

    //I2C进程
    reg [1:0] eeprom_state;
    reg [7:0] WrData; //WrData为待写入EEPROM的8位数据
    
    reg [7:0] RdData; //用于存放从EEPROM中读取的8位数据
    reg [5:0]bit_state; //发送或者接收数据时的位状态
    reg sda_tem;
    always @(posedge CLK or negedge RST) 
    begin
        if(RST == 0)
        begin
            start_delay <= 0;
            eeprom_state <= 0;//0无操作，1为写，2为读
        end
        else
            begin
                case (eeprom_state)
                    0:
                        begin
                            WrData <= {DATA_IN2,DATA_IN};
                            RdData <= 0;
                            bit_state <= 0;
                            Flag_RW <= 0;
                            //防抖动
                            if((key_delay==0)&&((CMD_WR==0)||(CMD_RD==0))) start_delay <= 1;
                            else if(key_delay == 10'b1000_0000_00)
                                begin
                                    if(CMD_WR == 0)eeprom_state<=1;
                                    else if(CMD_RD == 0) eeprom_state <= 2;
                                    else eeprom_state <= 0;
                                    start_delay <= 0;
                                end
                        end
                    1:
                        begin
                            if(phase0 == 1) scl_buf <= 1;
                            else if(phase2 == 1) scl_buf <= 0;

                            case (bit_state)
                                0: //发送从机位置第0位
                                    begin
                                        if(phase1 == 1) begin sda_buf <= 0;Flag_RW<=1;end
                                        if((phase3&Flag_RW)==1)begin
                                            sda_buf <= i2c_addr[6];
                                            Flag_RW <= 1;
                                            bit_state <= 1;
                                        end
                                    end
                                1: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[5];
                                        Flag_RW <= 1;
                                        bit_state <= 2;
                                    end
                                2: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[4];
                                        Flag_RW <= 1;
                                        bit_state <= 3;
                                    end
                                3: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[3];
                                        Flag_RW <= 1;
                                        bit_state <= 4;
                                    end
                                4: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[2];
                                        Flag_RW <= 1;
                                        bit_state <= 5;
                                    end
                                5: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[1];
                                        Flag_RW <= 1;
                                        bit_state <= 6;
                                    end
                                6: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[0];
                                        Flag_RW <= 1;
                                        bit_state <= 7;
                                    end
                                7: //表示写从机
                                    if(phase3 == 1) begin sda_buf <= 0;Flag_RW <= 1; bit_state <= 8; end
                                8: //准备读应答ACK
                                    if(phase3 == 1) begin Flag_RW <= 0; bit_state <= 9;end
                                9: //读应答ACK
                                    begin
                                        if(phase0 == 1) begin sda_tem <= SDA; end
                                        if((phase1 == 1)&&(sda_tem == 1)) eeprom_state <= 0;
                                        if(phase3 == 1) begin sda_buf <= eeprom_addr[7];Flag_RW <= 1; bit_state <= 10;end
                                    end
                                10: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[6];Flag_RW <= 1;bit_state <= 11;end
                                11: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[5];Flag_RW <= 1;bit_state <= 12;end
                                12: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[4];Flag_RW <= 1;bit_state <= 13;end
                                13: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[3];Flag_RW <= 1;bit_state <= 14;end
                                14: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[2];Flag_RW <= 1;bit_state <= 15;end
                                15: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[1];Flag_RW <= 1;bit_state <= 16;end
                                16: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[0];Flag_RW <= 1;bit_state <= 17;end
                                17: 
                                    if(phase3 == 1) begin Flag_RW <= 0;bit_state<=18;end
                                18:
                                    begin
                                        if(phase0 == 1) begin sda_tem <= SDA; end
                                        if((phase1 == 1)&&(sda_tem == 1)) eeprom_state <= 0;
                                        if(phase3 == 1) begin sda_buf <= WrData[7];Flag_RW <= 1;bit_state<=19;end
                                    end
                                19:
                                    if(phase3 == 1) begin sda_buf <= WrData[6];Flag_RW<=1;bit_state<=20; end
                                20:
                                    if(phase3 == 1) begin sda_buf <= WrData[5];Flag_RW<=1;bit_state<=21; end
                                21:
                                    if(phase3 == 1) begin sda_buf <= WrData[4];Flag_RW<=1;bit_state<=22; end
                                22:
                                    if(phase3 == 1) begin sda_buf <= WrData[3];Flag_RW<=1;bit_state<=23; end
                                23:
                                    if(phase3 == 1) begin sda_buf <= WrData[2];Flag_RW<=1;bit_state<=24; end
                                24:
                                    if(phase3 == 1) begin sda_buf <= WrData[1];Flag_RW<=1;bit_state<=25; end
                                25:
                                    if(phase3 == 1) begin sda_buf <= WrData[0];Flag_RW<=1;bit_state<=26; end
                                26:
                                    if(phase3 == 1) begin Flag_RW <= 0;bit_state <= 27;end
                                27: 
                                    begin
                                        if(phase0 == 1) begin sda_tem <= SDA;end
                                        if((phase1 == 1)&&(sda_tem == 1)) eeprom_state <= 0;
                                        if(phase3 == 1) begin sda_buf <= 0;Flag_RW <= 1; bit_state <= 28; end
                                    end
                                28:
                                    begin
                                        if(phase1 == 1) sda_buf<=1;
                                        if(phase3 == 1) begin
                                            bit_state <= 0;
                                            eeprom_state<=0;
                                            DataLED<=DATA_IN;
                                            DataLED2 <= DATA_IN2;
                                        end
                                    end
                                default: begin bit_state <= 0;eeprom_state<=0;end
                            endcase
                        end 
                    2:
                        begin
                            if(phase0 == 1) scl_buf <= 1;
                            else if(phase2 == 1) scl_buf <= 0;

                            case (bit_state)
                                0:
                                    begin
                                        if(phase1==1)begin sda_buf <= 0;Flag_RW <= 1;end
                                        if((phase3&Flag_RW)==1)
                                            begin sda_buf <= i2c_addr[6];Flag_RW <= 1;bit_state<=1;end
                                    end 
                                1: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[5];
                                        Flag_RW <= 1;
                                        bit_state <= 2;
                                    end
                                2: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[4];
                                        Flag_RW <= 1;
                                        bit_state <= 3;
                                    end
                                3: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[3];
                                        Flag_RW <= 1;
                                        bit_state <= 4;
                                    end
                                4: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[2];
                                        Flag_RW <= 1;
                                        bit_state <= 5;
                                    end
                                5: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[1];
                                        Flag_RW <= 1;
                                        bit_state <= 6;
                                    end
                                6: //从机位置第一位
                                    if(phase3 == 1)begin
                                        sda_buf <= i2c_addr[0];
                                        Flag_RW <= 1;
                                        bit_state <= 7;
                                    end
                                7: 
                                    if(phase3 == 1) begin sda_buf <= 0;Flag_RW <= 1;bit_state<=8;end
                                8:
                                    if(phase3 == 1) begin Flag_RW <= 0 ; bit_state <= 9;end
                                9:
                                    begin
                                        if(phase0<=1)sda_tem<=SDA;
                                        if((phase1 == 1)&&(sda_tem==1))eeprom_state <= 0;
                                        if(phase3 == 1)begin sda_buf<=eeprom_addr[7];Flag_RW<=1;bit_state<=10;end
                                    end
                                10: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[6];Flag_RW <= 1;bit_state <= 11;end
                                11: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[5];Flag_RW <= 1;bit_state <= 12;end
                                12: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[4];Flag_RW <= 1;bit_state <= 13;end
                                13: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[3];Flag_RW <= 1;bit_state <= 14;end
                                14: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[2];Flag_RW <= 1;bit_state <= 15;end
                                15: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[1];Flag_RW <= 1;bit_state <= 16;end
                                16: 
                                    if(phase3 == 1)begin sda_buf <= eeprom_addr[0];Flag_RW <= 1;bit_state <= 17;end
                                17: 
                                    if(phase3 == 1) begin Flag_RW <= 0;bit_state<=18;end
                                18:
                                    begin
                                        if(phase0 == 1) sda_tem <= SDA;
                                        if((phase1 == 1)&&(sda_tem == 1)) eeprom_state <= 0;
                                        if(phase3 == 1) begin sda_buf <= 1;Flag_RW <= 1;bit_state<=19;end
                                    end
                                19:
                                    begin
                                        if(phase1 == 1)begin sda_buf<=0;Flag_RW<=1;end
                                        if((phase3&Flag_RW) == 1)
                                            begin sda_buf <= i2c_addr[6];Flag_RW<=1;bit_state<=20;end
                                    end
                                20:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[5] ;Flag_RW <= 1 ; bit_state<=21;end
                                21:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[4] ;Flag_RW <= 1 ; bit_state<=22;end
                                22:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[3] ;Flag_RW <= 1 ; bit_state<=23;end
                                23:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[2] ;Flag_RW <= 1 ; bit_state<=24;end
                                24:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[1] ;Flag_RW <= 1 ; bit_state<=25;end
                                25:
                                    if(phase3 == 1) begin sda_buf <= i2c_addr[0] ;Flag_RW <= 1 ; bit_state<=26;end
                                26:
                                    if(phase3 == 1) begin sda_buf <= 1;Flag_RW <= 1;bit_state<=27;end
                                27:
                                    if(phase3 == 1) begin Flag_RW <= 0;bit_state <= 28;end
                                28:
                                    begin
                                        if(phase0 == 1) sda_tem <= SDA;
                                        if((phase1==1)&&(sda_tem==1))eeprom_state<=0;
                                        if(phase3) begin Flag_RW <= 0;bit_state<=29;end
                                    end
                                29:
                                    begin
                                        if(phase1 == 1)RdData[7]<=SDA;
                                        if(phase3 == 1) bit_state <= 30;
                                    end
                                30:
                                    begin
                                        if(phase1 == 1)RdData[6]<=SDA;
                                        if(phase3 == 1) bit_state <= 31;
                                    end
                                31:
                                    begin
                                        if(phase1 == 1)RdData[5]<=SDA;
                                        if(phase3 == 1) bit_state <= 32;
                                    end
                                32:
                                    begin
                                        if(phase1 == 1)RdData[4]<=SDA;
                                        if(phase3 == 1) bit_state <= 33;
                                    end
                                33:
                                    begin
                                        if(phase1 == 1)RdData[3]<=SDA;
                                        if(phase3 == 1) bit_state <= 34;
                                    end
                                34:
                                    begin
                                        if(phase1 == 1)RdData[2]<=SDA;
                                        if(phase3 == 1) bit_state <= 35;
                                    end
                                35:
                                    begin
                                        if(phase1 == 1)RdData[1]<=SDA;
                                        if(phase3 == 1) bit_state <= 36;
                                    end
                                36:
                                    begin
                                        if(phase1 == 1)RdData[0]<=SDA;
                                        if(phase3 == 1) bit_state <= 37;
                                    end
                                37:
                                    if(phase3 == 1)begin sda_buf <= 0;Flag_RW <= 1;bit_state<=38;end
                                38:
                                    begin
                                        if(phase1 == 1)sda_buf<=1;
                                        if(phase3 == 1)
                                            begin bit_state <=0;eeprom_state<=0;
                                            DataLED<=RdData[3:0];
                                            DataLED2<=RdData[7:4];
                                            end
                                    end
                                default: begin bit_state <= 0;eeprom_state<=0;end
                            endcase
                        end
                    default: eeprom_state<=0;
                endcase
            end
    end
endmodule