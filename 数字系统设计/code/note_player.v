module note_player (
    input clk , reset , play_enable , 
    input [5:0] note_to_load,duration_to_load,
    input load_new_note,sampling_pulse,beat,
    output reg note_done,
    output [15:0] sample,
    output sample_ready);
    //状态编码
    parameter RESET = 0 , WAIT = 1 , DONE = 2 , LOAD = 3;
    reg [1:0] state , nextstate;

    reg timer_clear , load;
    wire timer_done;
    wire [5:0] addr;
    wire [19:0] klow;

    always @(posedge clk) begin
        if(reset) state = RESET;
        else state = nextstate;
    end

    always @(*) begin
        //默认状态
        timer_clear = 1 ; load = 0 ; note_done = 0;
        
        case (state)
            RESET:begin
                timer_clear = 1 ; load = 0 ; note_done = 0;
                nextstate = WAIT;
            end  
            WAIT:begin
                timer_clear = 0 ; load = 0 ; note_done = 0;
                if(play_enable == 0) nextstate = RESET;
                else if(timer_done) nextstate = DONE;
                else if(load_new_note) nextstate = LOAD;
                else nextstate = WAIT;
            end
            DONE:begin
                timer_clear = 1 ; load = 0 ; note_done = 1;
                nextstate = WAIT;
            end
            LOAD:begin
                timer_clear = 1 ; load = 1 ; note_done = 0;
                nextstate = WAIT;
            end
        endcase
    end

    //实例化音符节拍定时器
    timer #(.counter_bits(6)) timer1(.clk(clk) , .en(beat) , .r(timer_clear) , .done(timer_done) , .n(duration_to_load));          

    //实例一个D寄存器
    dffre #(.n(6)) D(.d(note_to_load) , .en(load) , .r(~play_enable||reset) , .clk(clk) , .q(addr));

    //实例化FreqROM
    frequency_rom FreqROM(.clk(clk) , .dout(klow) , .addr(addr));

    //实例化DDS
    dds DDS(.K({2'b00,klow}) , .clk(clk) , .reset(~play_enable||reset) , .sampling_pulse(sampling_pulse) , .sample(sample) , .new_sample_ready(sample_ready));
    
endmodule