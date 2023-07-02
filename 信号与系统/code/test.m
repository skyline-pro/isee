clc
clear
%%
N=128,A0=255;PI=3.1415926;
i=1:N;
x=A0 * (sin(2*PI*i/25)+sin(2*PI* i * 0.4 ));
tic;
y=fft(x,N);%进行傅里叶变换求得幅度谱
toc;
z=abs(y);%对求得的幅度谱加绝对值   
figure(1);
subplot(2,2,1);plot(i,x);title('时域图');
subplot(2,2,2);plot(i,z);title('MATLAB自带fft测试结果')
tic;
var2 = fftNew(x);
toc;
subplot(2,2,3);plot(i,x);title('时域图');
subplot(2,2,4);plot(i,abs(var2));title('自己所写fftNew测试结果');
%%
N=234,A0=255;PI=3.1415926;
i=1:N;
x=A0 * (sin(2*PI*i/25)+sin(2*PI* i * 0.4 ));
tic;
y=fft(x,N);%进行傅里叶变换求得幅度谱
toc;
z=abs(y);%对求得的幅度谱加绝对值   
figure(2);
subplot(2,2,1);plot(i,x);title('时域图');
subplot(2,2,2);plot(i,z);title('MATLAB自带fft测试结果')
tic;
var2 = fftNew(x);
toc;
subplot(2,2,3);plot(i,x);title('时域图');
subplot(2,2,4);plot(i,abs(var2));title('自己所写fftNew测试结果');