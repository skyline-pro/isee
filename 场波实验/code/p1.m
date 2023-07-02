x = 0:10:90;
y = [1 0.912 0.776 0.525 0.331 0.158 0.060 0.014 0.001 0.000];
m = cosd(x);
n = m.^2;
plot(x,y);
hold on 
plot(x,m);
hold on
plot(x,n)
legend('实际曲线','cos(\theta)','cos^2\theta');