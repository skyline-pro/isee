function [x,n] = comExpSeq(a,b,length)
%a为传入底数的实部，b为传入底数的虚部，length则为序列的长度
%x为所得的序列， n为序列所在的位置信息
n = 0:1:length-1;
index = a+1j*b;
x = power( index,n);
end

