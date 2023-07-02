function [X] = dftPlot(x , n , text)
X = fft(x);

figure('Name',text,'NumberTitle','off')
subplot(3,1,1);
stem(n,real(X),'filled');
title('实部');

subplot(3,1,2);
stem(n,imag(X),'filled');
title('虚部');

subplot(3,1,3);
stem(n,abs(X),'filled');
title('模');
saveas(gcf , text , 'png')
close(gcf)
end

