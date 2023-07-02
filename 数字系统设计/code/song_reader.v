module song_reader (
    input clk,reset,play,note_done,
    input [1:0] song,
    output reg new_note,
    output song_done,
    output [5:0] note , duration
);
    //状态编码
    parameter RESET = 0 , NEW_NOTE = 1 , WAIT = 2 , NEXT_NOTE = 3;
    reg [1:0] state , nextstate;

    wire [4:0] lowaddr;//song_rom的低五位地址
    wire judge;//歌曲结束标志一
    
    //控制器时序部分
    always @(posedge clk) begin
        if(reset) state = RESET;
        else state = nextstate;
    end

    //控制器组合部分
    always @(*) begin
        //默认输出
        new_note = 0;
        case (state)
            RESET:begin
                new_note = 0;
                if(play) nextstate = NEW_NOTE;
                else nextstate = RESET;
            end
            NEW_NOTE:begin
                new_note = 1;
                nextstate = WAIT;
            end  
            WAIT:begin
                new_note = 0;
                if(play == 0) nextstate = RESET;
                else if(note_done) nextstate = NEXT_NOTE;
                else nextstate = WAIT;
            end
            NEXT_NOTE:begin
                new_note = 0;
                nextstate = NEW_NOTE;
            end
        endcase
    end

    //实例化地址计数器
    counter_n #(.n(32) , .counter_bits(5)) addrCounter(.clk(clk) , .r(reset) , .en(note_done) , .q(lowaddr) , .co(judge));
    
    //实例化song_rom，取出音符
    song_rom song_rom(.clk(clk) , .dout({note,duration}) , .addr({song,lowaddr}));

    //实例化判断模块
    over is_over(.signal((duration==0)||co) , .reset(reset) , .clk(clk) , .done(song_done));

endmodule

//判断乐曲是否播放结束模块
module is_over (
    input [5:0] duration ,
    input reset , clk ,
    output reg done
);
    parameter RESET = 0 , PAUSE = 1 , PLAY = 2 , OUT = 3;
    reg [1:0] state=0 , nextstate;

    always @(posedge clk) begin
        if(reset) state = RESET;
        else state = nextstate;
    end

    always @(*) begin
        done = 0;
        case (state)
            RESET:begin
                done = 1;
                nextstate = PAUSE;
            end 
            PAUSE:begin
                done = 0;
                if(duration)begin
                    nextstate = PLAY;
                end
                else nextstate = PAUSE;
            end
            PLAY:begin
                done = 0;
                if(duration) nextstate = PLAY;
                else nextstate = OUT;
            end
            OUT:begin
                done = 1;
                nextstate = PAUSE;
            end
        endcase
    end
endmodule

//新的结束模块实现
module over (
    input signal , reset , clk,
    output reg done 
);

parameter PAUSE = 0 , PLAY = 1 , OUT = 3;
reg [1:0] state , nextstate;

always @(posedge clk) begin
    if(reset) state = PAUSE;
    else state = nextstate;
end

always @(*) begin
    done = 0;
    case(state)
    PAUSE: begin
        done = 0;
        if(signal) nextstate = PAUSE;
        else nextstate = PLAY;
    end
    PLAY: begin
        done = 0;
        if(signal) nextstate = OUT;
        else nextstate = PLAY;
    end
    OUT: begin
        done = 1;
        nextstate = PAUSE;
    end
    default:nextstate = PAUSE;
    endcase
end
    
endmodule