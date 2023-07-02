function plotPart(x  , n , text)
figure('Name',text,'NumberTitle','off')

subplot(2,2,1);
stem(n,real(x),'filled');
title('实部');
 
subplot(2,2,2);
stem(n,imag(x),'filled');
title('虚部');
 
subplot(2,2,3);
stem(n,abs(x),'filled');
title('模');
 
subplot(2,2,4);
stem(n,(180/pi)*angle(x),'filled');
title('相位');
saveas(gcf , text , 'png')
close(gcf)
end

