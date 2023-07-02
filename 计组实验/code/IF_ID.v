module IF_ID (
    input en , r,clk,
    input [31:0] PC_if , instruction_if,
    output reg [31:0] PC_id , instruction_id 
);

    always @(posedge clk) begin
        if(r) begin
            PC_id <= 0;
            instruction_id <= 0;
        end
        else if(en) begin
            PC_id <= PC_if;
            instruction_id <= instruction_if;
        end
        else begin
            PC_id <= PC_id;
            instruction_id <= instruction_id;
        end
    end

    
endmodule