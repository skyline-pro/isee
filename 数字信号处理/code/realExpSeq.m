function [x , n] = realExpSeq(a,length)
%a为传入的底数 ， length为传入的长度
%x为返回的序列，n为序列所在的位置信息
    n = 0:1:length-1;
    x = a.^n;
end

