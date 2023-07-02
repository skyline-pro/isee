//主控制器
module mcu (
    input clk , reset , play_pause , next , song_done,
    output reg play,reset_play,
    output [1:0] song
);
    reg NextSong;

    //状态编码
    parameter RESET = 0 , PAUSE = 1 , PLAY = 2 , NEXT = 3;
    reg [1:0] state , nextstate;

    //时序逻辑，控制状态切换
    always @(posedge clk) begin
        if(reset) state = RESET;
        else state = nextstate;
    end
    

    //组合部分：控制次态以及控制器部分输出
    always @(*) begin
        //初始状态
        play = 0 ; NextSong = 0 ; reset_play = 1;
        case(state)
            RESET:begin
                play = 0 ; NextSong = 0 ; reset_play = 1;
                nextstate = PAUSE;
            end
            PAUSE:begin
                play = 0 ; NextSong = 0 ; reset_play = 0;
                if(play_pause)begin
                    nextstate = PLAY;
                end
                else if(next)begin
                    nextstate = NEXT;
                end
                else nextstate = PAUSE;
            end
            PLAY:begin
                play = 1 ; NextSong = 0 ; reset_play = 0;
                if(play_pause) nextstate = PAUSE;
                else if(next) nextstate = NEXT;
                else if(song_done) nextstate = RESET;
                else nextstate = PLAY;
            end
            NEXT:begin
                play = 0 ; NextSong = 1 ; reset_play = 1;
                nextstate = PLAY;
            end
        endcase
    end

    //实例化两位二进制计数器得到song
    counter_n #(.n(4) , .counter_bits(2)) counter(.en(NextSong) , .r(reset) , .clk(clk) , .q(song) , .co());
    
endmodule