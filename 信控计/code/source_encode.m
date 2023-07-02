function [out,len_enc] = source_encode(x,dict,N)
    out = huffmanenco(x,dict);
    len_enc = length(out);
    len = length(x);
    len_before_enc = len*N;
    fprintf('-------- source encode --------\n');
    fprintf('信源编码前字符串总长度 : %d\n', len_before_enc);
    fprintf('信源编码后字符串二进制总长度 : %d\n', len_enc);
    fprintf('压缩率 : %f\n', len_before_enc/len_enc);
end

