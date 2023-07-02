function [x,n] = cosSeq(f , delta , T , length)
%SINSEQ 此处显示有关此函数的摘要
%   此处显示详细说明
n = 0:1:length-1;
x = cos(2*pi*f*n*T+delta);
end