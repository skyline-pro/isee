module lab13 (
    input clkh,reset,
    output [7:0] lcdD,
    output lcdRs,
    output lcdRw,
    output ledEN
);
    reg clkl;
    reg [19:0] cnt;
    always @(posedge clkh) begin
        if(cnt == 20'hfffff)
            begin
                cnt <= 0;
                clkl <= ~ clkl;
            end
        else
            begin
                cnt <= cnt + 1;
            end
    end
    
    wire resetButton;
    button button(.keyin(reset) , .clk(clkl) , .keyout(resetButton));
    lcd1602 lcd(.clk_50m(clkh) , .reset(resetButton) , .lcdD(lcdD) , .lcdRs(lcdRs) , .lcdRw(lcdRw) , .ledEN(ledEn));
endmodule