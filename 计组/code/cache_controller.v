module cache_controller (
    input clk,reset,
    input ld , st,
    input [31:0] addr,
    input valid , dirty,
    input [20:0] tag_loaded,
    input l2_ack, write_done,
    output reg hit , miss,
    output reg load_ready , write_l1,
    output reg write_l2 , read_l2,
    output state
);
    parameter IDLE = 0 , CompareTag = 1 , WriteBack = 2 , Allocate = 3;
    reg [1:0] state , nextstate;

    always @(posedge clk) begin
        if(reset) state = IDLE;
        else state = nextstate;
    end

    always @(*) begin
        hit = 0 ; miss = 0;
        load_ready = 0 ; write_l1 = 0;
        write_l2 = 0 ;read_l2 = 0;
        case (state)
            IDLE : begin
                if(ld || st) begin
                    nextstate = CompareTag;
                end
                else nextstate = IDLE;
            end 

            CompareTag : begin
                if(!(valid && tag_loaded == addr[31:11]))begin
                    miss = 1 ; 
                    if(dirty)begin
                        nextstate = WriteBack;
                    end
                    else begin
                        nextstate = Allocate;
                    end
                end
                else begin
                    if(st)begin
                        hit = 1 ;
                        load_ready = 1 ; write_l1 = 1;
                    end
                    else begin
                        hit = 1 ; miss = 0;
                        load_ready = 1;write_l1 = 0;
                        write_l2 = 0 ; read_l2 = 0;
                    end
                    nextstate = IDLE;
                end
            end

            WriteBack : begin
                write_l2 = 1;
                if(write_done)begin
                    nextstate  = Allocate;
                end
                else begin
                    nextstate = WriteBack;
                end
            end

            Allocate : begin
                read_l2=1;
                if(l2_ack)begin
                    nextstate = CompareTag;
                end
                else begin
                    nextstate = Allocate;
                end
            end
        endcase
    end  
endmodule