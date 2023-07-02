module music_player (
    input clk, //éŤçľĺšłćć?
    input reset, //ĺ¤ä˝čžĺĽďźéŤçľĺšłćć
    input play_pause,  //âć­ć?/ćĺâčžĺĽďźéŤçľĺšłĺć­Ľčĺ?
    input next,//âä¸ä¸?éŚâ?čžĺĽďźéŤçľĺšłĺć­Ľčĺ?
    input NewFrame,//éŤçľĺšłéĺć­Ľčĺ˛ďźç´˘ĺć°çć ˇć?
    output [15:0] sample,//ć­ŁĺźŚć ˇĺčžĺş
    output play, //ć­ćžçść?ćç¤?
    output [1:0] song //ć˛ĺˇćç¤ş
);

    parameter sim = 0;

    wire ready;
    wire beat;//čć
    wire song_done;//ć­ć˛ć­ćžĺŽćäżĄĺˇ
    wire reset_play;//ç¨äşĺ¤ä˝song_readerä¸note_player
    wire note_done;//éłčć­ćžĺŽć
    wire new_note;//ĺé?çťnote_playerçć§ĺśäżĄĺˇďźčĄ¨ç¤şćć°çéłçŹŚéčŚć­ć?
    wire [5:0]note;//é?čŚć­ćžçéłçŹŚ
    wire [5:0]duration;//é?čŚć­ćžçéłçŹŚçćśé?
    wire sample_ready;

    //ĺć­Ľĺçľčˇ?
    synch synch1(
        .asynch_in(NewFrame) , 
        .clk(clk),
        .asynch_out(ready)
        );
    
    //čćĺşĺäş§çĺ?
    counter_n #(.n(sim?64:1000) , .counter_bits(sim?6:10)) beater(.clk(clk) , .r(0) , .en(ready) , .q() , .co(beat));

    //ĺŽäžĺä¸ťć§ĺśĺ?
    mcu mcu1( 
        .clk(clk),
        .reset(reset),
        .play_pause(play_pause),
        .next(next),
        .song_done(song_done),//
        .play(play),
        .reset_play(reset_play),
        .song(song)
    
    );

    //ĺŽäžĺsong_reader
    song_reader song_reader1(
        .clk(clk),
        .reset(reset_play),
        .play(play),
        .note_done(note_done),
        .song(song),
        .song_done(song_done),
        .new_note(new_note),
        .note(note),
        .duration(duration)
    );

    //ĺŽäžĺnote_player
    note_player note_player(
        .clk(clk),
        .reset(reset_play),
        .play_enable(play),
        .note_to_load(note),
        .duration_to_load(duration),
        .load_new_note(new_note),
        .sampling_pulse(ready),
        .beat(beat),
        .note_done(note_done),
        .sample(sample),
        .sample_ready(sample_ready)
    );


    
endmodule