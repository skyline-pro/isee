function [DICT,avglen] = dict
%此函数用于生成码书，返回值DICT即为编码码书
N = 8;
yes_data = audioread('cmd/yes.flac');
up_data = audioread('cmd/up.flac');
stop_data = audioread('cmd/stop.flac');
right_data = audioread('cmd/right.flac');
on_data = audioread('cmd/on.flac');
off_data = audioread('cmd/off.flac');
no_data = audioread('cmd/no.flac');
left_data = audioread('cmd/left.flac');
go_data = audioread('cmd/go.flac');
down_data = audioread('cmd/down.flac');
cmd = [down_data;up_data;stop_data;right_data;on_data;off_data;no_data;...
    left_data;go_data;down_data;yes_data];
q = (1-(-1))/2^N;
x = floor((cmd+1)/q);
len = length(x);
unique_x = unique(x);
unique_len = length(unique_x);

symbols = cell(1, unique_len);
p = zeros(1, unique_len);

% 计算符号概率
for i = 1:unique_len
    symbols{1,i} = unique_x(i);
    p(i) = numel(find(x==unique_x(i))) / len;
end

% 根据符号集symbols和概率数组p计算Huffman编码词典
[DICT, avglen] = huffmandict(symbols, p);

fprintf('平均码长 : %f\n', avglen );
fprintf('信源熵 : %f\n', sum(p.*(-log2(p))) );
fprintf('编码效率 : %f\n', sum(p.*(-log2(p)))/avglen );
end

