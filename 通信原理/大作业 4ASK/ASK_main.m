pic = imread('pic.png');
[w,h,c] = size(pic);

%% 设置参数
fs = 32e3;
fb = 1e3;
fc = 4e3;
SNR = 0:1:20;
PMe_ideal = zeros(1,length(SNR));
PMe = zeros(1,length(SNR));
%% 脉冲成型，使用了方波
[x , n] = pic2pluse(pic , fs , fb);

%% 传输,采样,判决并计算理论与实际误码率
for i = 1:1:length(SNR)
    sample = trans(x , SNR(i) , fs , fc);

    judge_series = judge(sample);

    PMe_ideal(i) =1.5*qfunc(sqrt(6*10^(SNR(i)/10)/15));
    error_num = length(find(x(1:32:end)-judge_series == 0));
    PMe(i) =(w*h*12 - error_num)/(w*h*12);
    if i == 1 || i == 6 || i == 11 || i == 16 || i ==21
        pic_recovered = recover(judge_series , n , w, h, c);
        imshow(pic_recovered);
        imwrite(pic_recovered, [num2str(i-1),'dB.jpg']);
    end
end
%% 绘制误码率图
plot(SNR,PMe_ideal,'r');
hold on;
plot(SNR,PMe,'b');
legend('理论误码率','实际误码率')


