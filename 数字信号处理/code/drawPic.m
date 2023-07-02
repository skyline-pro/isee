function drawPic(x , n , text)
%绘制传入序列的时域图谱
figure('Name',text,'NumberTitle','off')
stem(n,real(x),'filled');
title(text);

saveas(gcf , text , 'png')
close(gcf)

%对传入序列进行fft变换
X = fft(x);
%为图片名称加入“频谱”前缀
text1 = ['频谱_' , text];
%绘制频域的实部图像
figure('Name',text,'NumberTitle','off')
subplot(3,1,1);
stem(n,real(X),'filled');
title('实部');
%绘制频域的虚部图像
subplot(3,1,2);
stem(n,imag(X),'filled');
title('虚部');
%绘制频域的模的图像
subplot(3,1,3);
stem(n,abs(X),'filled');
title('模');
saveas(gcf , text1 , 'png')
close(gcf)

end

