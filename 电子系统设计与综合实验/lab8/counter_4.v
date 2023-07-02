module counter_4(
    input clk,
    input en,
    input r,
    output wire q0,
    output wire q1
    );
    reg [1:0] q = 0;
    always @(posedge clk or posedge r) 
        begin
            if(r) q=0; //置零
            else if(en)  //en=1,计数；en=0,保持
                begin	 
                        if(q==3)  q=0 ; //q已满，进位
                        else q=q+1;		      //q为满，计数
                end
            else q = q;
    end
    assign q0 = q[0];
    assign q1 = q[1];

endmodule
