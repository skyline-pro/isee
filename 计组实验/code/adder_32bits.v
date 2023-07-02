module adder_32bits (
    input [31:0] a , b,
    input ci,
    output [31:0] s,
    output co
);
    wire c0 , c1 , c2 , c3 , c4 , c5 , c6;
    adder_4bits adder1(.a(a[3:0]) , .b(b[3:0]) , .ci(ci) , .s(s[3:0]) , .co(c0));
    CAS_4 block1(.a(a[7:4]) , .b(b[7:4]) , .ci(c0) , .s(s[7:4]) , .co(c1));
    CAS_4 block2(.a(a[11:8]) , .b(b[11:8]) , .ci(c1) , .s(s[11:8]) , .co(c2));
    CAS_4 block3(.a(a[15:12]) , .b(b[15:12]) , .ci(c2) , .s(s[15:12]) , .co(c3));
    CAS_4 block4(.a(a[19:16]) , .b(b[19:16]) , .ci(c3) , .s(s[19:16]) , .co(c4));
    CAS_4 block5(.a(a[23:20]) , .b(b[23:20]) , .ci(c4) , .s(s[23:20]) , .co(c5));
    CAS_4 block6(.a(a[27:24]) , .b(b[27:24]) , .ci(c5) , .s(s[27:24]) , .co(c6));
    CAS_4 block7(.a(a[31:28]) , .b(b[31:28]) , .ci(c6) , .s(s[31:28]) , .co(co));
    
endmodule

module CAS_4 (
    input [3:0] a , b,
    input ci,
    output [3:0] s,
    output co
);
    wire co0 , co1;
    wire [4:0] s0 , s1;
    adder_4bits adder0(.a(a) , .b(b) , .ci(0) , .s(s0) , .co(co0));
    adder_4bits adder1(.a(a) , .b(b) , .ci(1) , .s(s1) , .co(co1));

    assign co = (ci&co1)|co0;
    assign s = ci?s1:s0;

endmodule