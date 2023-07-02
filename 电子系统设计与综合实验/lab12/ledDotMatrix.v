module ledDotMatrix (
    input clk,reset,
    output [7:0] ledRow , ledCol
);

    reg [15:0] cntScan;
    reg [7:0] rowBuf;
    always @(posedge clk or negedge reset) begin
        begin
            if(!reset)begin
                cntScan <= 0;
                rowBuf <= 8'b1000_0000;
            end
            else if(cntScan != 16'hffff) cntScan <= cntScan + 1;
            else begin
                //此处因为是非阻塞，所以两行语句是同时执行的，能够达到位移的作用
                rowBuf[7:1] <= rowBuf[6:0];
                rowBuf[0] <= rowBuf[7];
                cntScan <= 0;
            end
        end
    end


    reg [25:0] cntNext;
    reg [3:0] scanData;
    always @(posedge clk or negedge reset) begin
        if(!reset)begin
            cntNext <= 0;
            scanData <= 0;
        end
        else if(cntNext != 39999999) cntNext <= cntNext + 1;
        else begin
            cntNext <= 0;
            scanData <= scanData + 1'b1;
        end
    end

    reg [7:0] col1 , col2 , col3 , col4 , col5 , col6 , col7 , col8;
    always @(scanData) begin
        case (scanData) 
            4'h0:begin
                col1 <= 8'h0e;
                col2 <= 8'h11;
                col3 <= 8'h13;
                col4 <= 8'h15;
                col5 <= 8'h19;
                col6 <= 8'h11;
                col7 <= 8'h0e;
                col8 <= 8'h00;
            end 
            4'h1:begin
                col1 <= 8'h04;
                col2 <= 8'h0c;
                col3 <= 8'h04;
                col4 <= 8'h04;
                col5 <= 8'h04;
                col6 <= 8'h04;
                col7 <= 8'h0e;
                col8 <= 8'h00;
            end
            4'h2:begin
                col1 <= 8'h0f;
                col2 <= 8'h01;
                col3 <= 8'h01;
                col4 <= 8'h0f;
                col5 <= 8'h08;
                col6 <= 8'h08;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'h3:begin
                col1 <= 8'h0f;
                col2 <= 8'h01;
                col3 <= 8'h01;
                col4 <= 8'h0f;
                col5 <= 8'h01;
                col6 <= 8'h01;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'h4:begin
                col1 <= 8'h09;
                col2 <= 8'h09;
                col3 <= 8'h09;
                col4 <= 8'h0f;
                col5 <= 8'h01;
                col6 <= 8'h01;
                col7 <= 8'h01;
                col8 <= 8'h00;
            end
            4'h5:begin
                col1 <= 8'h0f;
                col2 <= 8'h08;
                col3 <= 8'h08;
                col4 <= 8'h0f;
                col5 <= 8'h01;
                col6 <= 8'h01;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'h6:begin
                col1 <= 8'h0f;
                col2 <= 8'h08;
                col3 <= 8'h08;
                col4 <= 8'h0f;
                col5 <= 8'h09;
                col6 <= 8'h09;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'h7:begin
                col1 <= 8'h0f;
                col2 <= 8'h01;
                col3 <= 8'h01;
                col4 <= 8'h01;
                col5 <= 8'h01;
                col6 <= 8'h01;
                col7 <= 8'h01;
                col8 <= 8'h00;
            end
            4'h8:begin
                col1 <= 8'h0f;
                col2 <= 8'h09;
                col3 <= 8'h09;
                col4 <= 8'h0f;
                col5 <= 8'h09;
                col6 <= 8'h09;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'h9:begin
                col1 <= 8'h0f;
                col2 <= 8'h09;
                col3 <= 8'h09;
                col4 <= 8'h0f;
                col5 <= 8'h01;
                col6 <= 8'h01;
                col7 <= 8'h0f;
                col8 <= 8'h00;
            end
            4'd10:begin
                col1 <= 8'h2f;
                col2 <= 8'h29;
                col3 <= 8'h29;
                col4 <= 8'h29;
                col5 <= 8'h29;
                col6 <= 8'h29;
                col7 <= 8'h2f;
                col8 <= 8'h00;
            end
            4'd11:begin
                col1 <= 8'h21;
                col2 <= 8'h21;
                col3 <= 8'h21;
                col4 <= 8'h21;
                col5 <= 8'h21;
                col6 <= 8'h21;
                col7 <= 8'h21;
                col8 <= 8'h00;
            end
            4'd12:begin
                col1 <= 8'h2f;
                col2 <= 8'h21;
                col3 <= 8'h21;
                col4 <= 8'h2f;
                col5 <= 8'h28;
                col6 <= 8'h28;
                col7 <= 8'h2f;
                col8 <= 8'h00;
            end
            4'd13:begin
                col1 <= 8'h2f;
                col2 <= 8'h21;
                col3 <= 8'h21;
                col4 <= 8'h2f;
                col5 <= 8'h21;
                col6 <= 8'h21;
                col7 <= 8'h2f;
                col8 <= 8'h00;
            end
            4'd14:begin
                col1 <= 8'h29;
                col2 <= 8'h29;
                col3 <= 8'h29;
                col4 <= 8'h2f;
                col5 <= 8'h21;
                col6 <= 8'h21;
                col7 <= 8'h21;
                col8 <= 8'h00;
            end
            4'd15:begin
                col1 <= 8'h2f;
                col2 <= 8'h28;
                col3 <= 8'h28;
                col4 <= 8'h2f;
                col5 <= 8'h21;
                col6 <= 8'h21;
                col7 <= 8'h2f;
                col8 <= 8'h00;
            end
            default: begin
                col1 <= 8'h00;
                col2 <= 8'h00;
                col3 <= 8'h00;
                col4 <= 8'h00;
                col5 <= 8'h00;
                col6 <= 8'h00;
                col7 <= 8'h00;
                col8 <= 8'h00;
            end
        endcase
    end

    reg [7:0] colBuf;
    always @(rowBuf) begin
        case (rowBuf)
            8'h01: colBuf <= col1;
            8'h02: colBuf <= col2;
            8'h04: colBuf <= col3;
            8'h08: colBuf <= col4;
            8'h10: colBuf <= col5;
            8'h20: colBuf <= col6;
            8'h40: colBuf <= col7;
            8'h80: colBuf <= col8; 
            default: colBuf <= 8'h00;
        endcase
    end

    assign ledCol = ~ colBuf;
    assign ledRow = rowBuf;
    
endmodule