clear ;
%设置参数
N = 8;
Fs = 8000;
snr = 3;
%% 采样
[cmd,fs] = sample('cmd/go.flac');
[out, q] = quantize(cmd, fs, N);
%% 生成码书DICT
[DICT,avglen] = dict;
%% 信源编码
[out_code,len_enc] = source_encode(out,DICT,N);
%% 信道编码
[channel_code,len_channel,trellis] = channel_encode(out_code);

%% multiple snr test
% snr_array = -20:0.01:20;
% err = zeros(length(snr_array), 1);
% ber = zeros(length(snr_array), 1);
% for i=1:length(snr_array)
%       m_out = modulation(channel_code, snr_array(i));
%      dem_out = demodulation(m_out);
%      [channel_decode1,len]= channel_decode(dem_out,trellis);
%      [err(i), ber(i)] = biterr(channel_decode1 , out_code);
%  end
%  figure;
%  subplot(121);
%  plot(snr_array, err, 'b');xlabel('SNR(dB)');ylabel('error number');title('不同信噪比下bit出错数');
%  subplot(122);
%  plot(snr_array, ber, 'b');xlabel('SNR(dB)');ylabel('bit error rate');title('不同信噪比下误码率');
%% 调制解调

%添加高斯噪声
m_out = modulation(channel_code , snr);
%demodulation
dem_out = demodulation(m_out);
%error compute
[err, ber] = biterr(dem_out, channel_code);
fprintf('-------- 调制解调 --------\n');
fprintf('调制解调出错数 : %d\n', err);
fprintf('调制解调误码率 : %f\n', ber);

%% 信道译码
[channel_decode,len_channel_decode] = channel_decode(dem_out,trellis);
[number,ratio]=biterr(channel_decode , out_code);
fprintf('-------- 信道译码 --------\n');
fprintf('信道译码出错数 : %d\n', number);
fprintf('信道译码误码率 : %f\n', ratio);
%% 信源译码
out_decode=huffmandeco(channel_decode,DICT);
[num,ratio1]=biterr(out_decode , out);
fprintf('-------- 信源译码 --------\n');
fprintf('信源译码出错数 : %d\n', num);
fprintf('信源译码误码率 : %f\n', ratio1);

%% 信号重建
r_out = rebuild(out_decode,q);

%% 语音识别
command=recognize(r_out,fs);

%% 绘图
len = length(cmd);
ts = (0:len-1)/fs;
% 时域图
figure(1);
subplot(211);
plot(ts, cmd, 'b')
title('原始语音信号');xlabel('time(s)');ylabel('amplitude(V)');
subplot(212);
plot(ts, r_out, 'b')
title('重建后的语音信号');xlabel('time(s)');ylabel('amplitude(V)');

% 频域图
figure(2);
fft_cmd = fft(cmd, fs);
f = fs*(0:fs/2-1)/fs;
subplot(211);
plot(f, abs(fft_cmd(1:fs/2)), 'b');
title('原始语音信号频谱');
xlabel('frequency(Hz)');ylabel('amplitude');
fft_r = fft(r_out, fs);
subplot(212);
plot(f, abs(fft_r(1:fs/2)), 'b');
title('重建语音信号频谱');
xlabel('frequency(Hz)');ylabel('amplitude');