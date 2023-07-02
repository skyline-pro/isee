% 0101随机数，待编码数据
bits = randi([0 1],256,1);
% trellis = poly2trellis(7,{'1 + x^3 + x^4 + x^5 + x^6', ...
%     '1 + x + x^3 + x^4 + x^6'})
% 产生生成多项式
gen_math = poly2trellis(7, [171 133]);% 8进制，分别对应相应位置的抽头
% 卷积码编码
codeData = convenc(bits,gen_math);
% Viterbi译码
decodeData = vitdec(codeData,gen_math,34,'trunc','hard');
% 算误码
err = biterr(decodeData,bits);