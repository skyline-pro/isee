module dds (
    K , clk , reset ,sampling_pulse , sample , new_sample_ready
);
    input [21:0] K;
    input clk , reset , sampling_pulse;
    output [15:0] sample;
    output new_sample_ready;

    wire [21:0] temp ;//作为加法器输出
    wire [21:0] raw_addr; //待处理地址
    wire [9:0] rom_addr; //ROM地址
    wire area;//区域
    wire [15:0] raw_data;//原始数据
    wire [15:0] data;//处理后的数据

    //实例化加法器
    adder_n #(.n(22)) adder(.adder1(K) , .adder2(raw_addr) , .result(temp) , .co());

    //实例化D型寄存器
    dffre #(.n(22)) D1(.d(temp) , .en(sampling_pulse) , .r(reset) , .clk(clk) , .q(raw_addr));

    //处理地址
    //rom_addr应该可以不指定位数
    assign rom_addr = raw_addr[20]?((raw_addr[20:10]==1024)?1023:(~raw_addr[19:10]+1)):raw_addr[19:10];

    //实例化D触发器得到area
    dffre #(.n(1)) D2(.d(raw_addr[21]) , .en(1) , .r(0) , .clk(clk) , .q(area));

    //取出原始数据
    sine_rom rom(.clk(clk) , .addr(rom_addr) , .dout(raw_data));

    //处理原始数据
    assign data = area?(~raw_data+1):raw_data;

    //实例化D寄存器得到取样值sample
    dffre #(.n(16)) D3(.d(data) , .en(sampling_pulse) , .r(0) , .clk(clk) , .q(sample));

    //实例化D触发器得到new_sample_ready信号
    dffre #(.n(1)) D4(.d(sampling_pulse) , .en(1) , .r(0) , .clk(clk) , .q(new_sample_ready));

endmodule