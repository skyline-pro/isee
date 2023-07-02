function [x , n] = comFunc(f1 , f2 , delta , phi , T , length)
%COMPOSFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
n = 0:1:length-1;
x = sin(2*pi*f1*n*T) + delta * sin(2*pi*f2*n*T + phi*(2*pi)/360);
end

