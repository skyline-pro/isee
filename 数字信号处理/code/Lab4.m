%%
N = 31;
n = 0:1:N-1;
%生成理想滤波器的冲激响应
hd_1 = sin((n-15).*0.5*pi)./((n-15)*pi);
hd_1(16) = 0.5;
%矩形窗
w_1 = boxcar(31)';
h_1 = hd_1 .* w_1;
%汉明窗
w_2 = hamming(31)';
h_2 = hd_1 .* w_2;
%绘制出两种窗的区别
stem(n , h_1);
hold on;
stem(n , h_2);
hold off;
saveas(gcf ,'h区别', 'png')
%%
%绘制两个窗频率响应的区别
[H_1,w_1] = freqz(h_1 , [1] , N);
[H_2,w_2] = freqz(h_2 , [1] , N);
plot(w_1 , abs(H_1))
hold on;
plot(w_2 , abs(H_2));
hold off;
saveas(gcf , '频响区别','png')

%%
%生成x(n)并绘制出X（k）
xn = rand(1,200)-0.5;
stem(xn);
saveas(gcf , 'xn','png')
[H_x , w_x] = freqz(xn);
plot(w_x , abs(H_x))
saveas(gcf , 'X(k)','png')

%%
%使用前面两种滤波器对x(n)进行滤波
y_1 = conv(xn , h_1);
y_2 = conv(xn , h_2);
[H_y1 , w_y1] = freqz(y_1);
[H_y2 , w_y2] = freqz(y_2);

%%
%生成长度为127的矩形窗
N_2 = 127;
n_2 = 0:1:N_2-1;
hd_2 = sin((n_2-63).*0.5*pi)./((n_2-63)*pi);
hd_2(64) = 0.5;
w_3 = boxcar(127)';
h_3 = w_3.*hd_2;
%使用第三种滤波器对x(n)滤波
y_3 = conv(xn , h_3);
[H_y3 , w_y3] = freqz(y_3);

%%绘图
%绘制X(k)与Y1(k)区别
plot(w_x , abs(H_x));
hold on;
plot(w_y1 , abs(H_y1));
hold off;
saveas(gcf , 'X(k)与Y1(k)区别' , 'png');
%绘制Y1(k)与Y2(k)区别
plot(w_y2 , abs(H_y2));
hold on;
plot(w_y1 , abs(H_y1));
hold off;
saveas(gcf , 'Y2(k)与Y1(k)区别' , 'png');
%绘制Y1(k)与Y3(k)区别
plot(w_y3 , abs(H_y3) );
hold on;
plot(w_y1 , abs(H_y1));
hold off;
saveas(gcf , 'Y3(k)与Y1(k)区别' , 'png');
