%%
%计算得到5种共9个序列

%实指数序列
%a = 0.5 , length = 10
[x_11 , n_11] = realExpSeq(0.5 , 10);
%a = 0.9 , length = 10
[x_12 , n_12] = realExpSeq(0.9 , 10);
%a = 0.9 , length = 10
[x_13 , n_13] = realExpSeq(0.9 , 20);

%复指数序列
%a = 0.5 , b = 0.8 , length = 10
[x_2 , n_2] = comExpSeq(0.5 , 0.8 , 10);

%正弦序列
%f = 1Hz , delta = 0 , T = 0.1 , length = 10
[x_3 , n_3] = sinSeq(1 , 0 , 0.1 , 10);

%余弦序列
%f = 1Hz , delta = 0 , T = 0.1 , length = 10
[x_4 , n_4] = cosSeq(1 , 0 , 0.1 , 10);

%复合函数序列
%f1 = 1 , f2 = 3 , delta = 0.5 , phi = 0 , T = 0.1 , length = 10
[x_51 , n_51] = comFunc(1 , 3 , 0.5 , 0 , 0.1 , 10);
%f1 = 1 , f2 = 3 , delta = 0.5 , phi = 90 , T = 0.1 , length = 10
[x_52 , n_52] = comFunc(1 , 3 , 0.5 , 90 , 0.1 , 10);
%f1 = 1 , f2 = 3 , delta = 0.5 , phi = 180 , T = 0.1 , length = 10
[x_53 , n_53] = comFunc(1 , 3 , 0.5 , 180 , 0.1 , 10);
%%
%调用plotPart函数绘制序列的实部虚部模和相位

%实指数序列6
plotPart(x_11 , n_11 , '实指数序列_a=05,length=1x0')
%实指数序列2
plotPart(x_12 , n_12 , '实指数序列_a=09,length=10')
%实指数序列3
plotPart(x_13 , n_13 , '实指数序列_a=09,length=20')
%复指数序列
plotPart(x_2 , n_2 , '复指数序列')
%正弦序列
plotPart(x_3 , n_3 , '正弦序列')
%余弦序列
plotPart(x_4 , n_4 , '余弦序列')
%复合函数序列1
plotPart(x_51 , n_51 , '复合函数序列_phi=0')
%复合函数序列2
plotPart(x_52 , n_52 , '复合函数序列_phi=90')
%复合函数序列3
plotPart(x_53 , n_53 , '复合函数序列_phi=180')
%%
%调用dftPlot函数绘制序列频谱的实部虚部模

%实指数序列1
X_11 = dftPlot(x_11 , n_11 , '频谱_实指数序列_a=05,length=10');
%实指数序列2
X_12 = dftPlot(x_12 , n_12 , '频谱_实指数序列_a=09,length=10');
%实指数序列3
X_13 = dftPlot(x_13 , n_13 , '频谱_实指数序列_a=09,length=20');
%复指数序列
X_2 = dftPlot(x_2 , n_2 , '频谱_复指数序列');
%正弦序列
X_3 = dftPlot(x_3 , n_3 , '频谱_正弦序列');
%余弦序列
X_4 = dftPlot(x_4 , n_4 , '频谱_余弦序列');
%复合函数序列1
X_51 = dftPlot(x_51 , n_51 , '频谱_复合函数序列_phi=0');
%复合函数序列2
X_52 = dftPlot(x_52 , n_52 , '频谱_复合函数序列_phi=90');
%复合函数序列3
X_53 = dftPlot(x_53 , n_53 , '频谱_复合函数序列_phi=180');