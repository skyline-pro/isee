module vga (
    input clk_50m , reset, orient,
    output reg [2:0] vga_d,
    output vga_hs,
    output reg vga_vs
);
    parameter H_PIXELS      = 'd800;
    parameter H_FRONTPORCH  = 'd16;
    parameter H_SYNCTIME    = 'd80;
    parameter H_BACKPORCH   = 'd160;
    parameter H_SYNCSTART   = 'd816;
    parameter H_SYNCEND     = 'd896;
    parameter H_PERIOD      = 'd1056;

    parameter V_LINES       = 'd600;
    parameter V_FRONTPORCH  = 'd1;
    parameter V_SYNCTIME    = 'd3;
    parameter V_BACKPORCH   = 'd21;
    parameter V_SYNCSTART   = 'd601;
    parameter V_SYNCEND     = 'd604;
    parameter V_PERIOD      = 'd625;


    //水平像素计数器
    reg [10:0] hcnt;
    always @(posedge clk_50m or negedge reset) begin
        if(!reset)begin
            hcnt <= 0;
        end
        else if(hcnt < H_PERIOD)begin
            hcnt <= hcnt + 1;
        end
        else hcnt <= 0;
    end 

    //内部水平同步脉冲产生
    reg hsyncint;
    always @(posedge clk_50m or negedge reset) begin
        if(!reset)begin
            hsyncint <= 1;
        end
        else if(hcnt >= H_SYNCSTART && hcnt < H_SYNCEND)begin
            hsyncint <= 0;
        end
        else hsyncint <= 1;
    end

    //水平同步输出
    // wire vga_hs;
    assign vga_hs = hsyncint;

    //垂直行计数器
    reg [9:0] vcnt;
    always @(posedge hsyncint or negedge reset) begin
        if(!reset) vcnt <= 0;
        else if(vcnt < V_PERIOD) vcnt <= vcnt + 1;
        else vcnt <= 0;
    end

    //垂直同步脉冲产生
    // reg vga_vs;
    always @(posedge hsyncint or negedge reset) begin
        if(!reset) vga_vs <= 1;
        else if(vcnt >= V_SYNCSTART && vcnt < V_SYNCEND) vga_vs <= 0;
        else vga_vs <= 1;
    end

    //使能与消隐颜色输出
    reg enable;
    always @(posedge clk_50m or negedge reset) begin
        if(!reset) enable <= 0;
        else if(hcnt >= H_PIXELS || vcnt >= V_LINES) enable <= 0;
        else enable <= 1;
    end

    assign blank = enable;

    //输出颜色生成
    // reg [2:0] vga_d;
    always @(enable or orient or hcnt or vcnt) begin
        if(enable == 0) vga_d = 0;
        else if(orient)begin
            if(vcnt < 75) vga_d = 'h1;
            else if(vcnt < 150) vga_d = 'h2;
            else if(vcnt < 225) vga_d = 'h3;
            else if(vcnt < 300) vga_d = 'h4;
            else if(vcnt < 375) vga_d = 'h5;
            else if(vcnt < 450) vga_d = 'h6;
            else if(vcnt < 525) vga_d = 'h7;
            else vga_d = 'h0;
        end
        else begin
            if(hcnt < 100) vga_d = 'h1;
            else if(hcnt < 200) vga_d = 'h2;
            else if(hcnt < 300) vga_d = 'h3;
            else if(hcnt < 400) vga_d = 'h4;
            else if(hcnt < 500) vga_d = 'h5;
            else if(hcnt < 600) vga_d = 'h6;
            else if(hcnt < 700) vga_d = 'h7;
            else vga_d = 'h0;

        end
    end

endmodule