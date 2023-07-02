%arguements
Fs = 8000;
nBit = 16;
nChannels = 1;
recObj = audiorecorder(Fs,nBit,nChannels);
disp('Start speaking.')
recordblocking(recObj, 1);
disp('End of Recording.');
% 回放录音数据
play(recObj);
% 获取录音数据
myRecording = getaudiodata(recObj);
audiowrite('stop.flac',myRecording,Fs)
% 绘制录音数据波形
plot(myRecording); 