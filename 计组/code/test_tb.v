`timescale 1ns / 1ps

module testbench;
    parameter delay = 100;
    //inputs
    reg clk,reset;
    reg ld , st;
    reg [31:0] addr;
    reg valid , dirty;
    reg [20:0] tag_loaded;
    reg l2_ack;
    reg write_done;

    //outputs
    wire hit , miss;
    wire load_ready , write_l1;
    wire write_l2 , read_l2;
    wire [1:0]state;

    //instantiation of the cache controller
    cache_controller cache(
        .clk(clk),
        .reset(reset),
        .ld(ld),
        .st(st),
        .addr(addr),
        .valid(valid),
        .dirty(dirty),
        .tag_loaded(tag_loaded),
        .l2_ack(l2_ack),
        .hit(hit),
        .miss(miss),
        .load_ready(load_ready),
        .write_l1(write_l1),
        .write_l2(write_l2),
        .read_l2(read_l2),
        .write_done(write_done),
        .state(state)
    );

    //set the free running clock
    initial begin
        clk = 1;
        forever begin
            #(delay/2) clk = ~clk;
        end
    end

    //set up the reset signal
    initial begin
        reset = 1 ;
        #(delay*2) reset = 0;
    end

    initial begin
        //initial input
        ld = 0; 
		st = 0;
		addr = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
		tag_loaded = 21'b0000_0000_0000_0000_0000_0;
		valid = 0; 
		dirty = 0;
		l2_ack = 0;
        write_done = 0;


        //read hit
        #(delay*2)
            ld = 1 ; st = 0;
            addr = 32'b0000_0000_0000_0000_0101_1000_0000_0000;
            tag_loaded = 21'b0000_0000_0000_0000_0101_1;
            valid = 1;        
        //wait for next instruction
        #delay
            ld = 0 ; st = 0;
        //write hit
        #delay
            ld = 0 ; st = 1;
        //wait for next instruction
        #delay
            ld = 0 ; st = 0;

        //read compulsory miss
        #(delay)
            ld = 1 ; st = 0;
            valid = 0;
        //wait for the l2_ack
        #(delay*3)
            l2_ack = 1;
            valid = 1;
        //wait for next instruction
        #delay
            ld = 0 ; st = 0;

        //write compulsory miss
        #(delay)
            ld = 0 ; st = 1;
            valid = 0;
            l2_ack = 0;
        //wait for the l2_ack
        #(delay*4)
            l2_ack = 1;
            valid = 1;
        //wait for next instruction
        #delay
            ld = 0 ; st = 0;
            l2_ack = 0;
        
        //conflict miss with dirty=0
        #(delay)
            ld = 1 ; st = 0;
            tag_loaded = 21'b0000_0000_0000_0000_0101_0;
            valid = 1;
        //wait for the l2_ack
        #(delay*3)
            l2_ack = 1;
            tag_loaded = 21'b0000_0000_0000_0000_0101_1;
        #delay
            ld = 0 ; st = 0;
            l2_ack=0;

        //conflict miss with dirty=1
        #(delay)
            ld = 0 ; st = 1;
            tag_loaded = 21'b0000_0000_0000_0000_0101_0;
            dirty = 1;
        //wait for the write_done signal
        #(delay)
            write_done = 1;
        #(delay*3)
            write_done = 0;
            l2_ack = 1;
            tag_loaded = 21'b0000_0000_0000_0000_0101_1;
        #(delay*2)
            ld = 0 ;st = 0;
            l2_ack=0;

        #(delay*3)
            
            $stop;

        end

endmodule