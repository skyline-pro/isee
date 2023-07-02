import numpy as np
import sklearn.model_selection as ms
from MnistConv import *
from dataset import load_data
from kNN import classify

'''
此为数据读取与预处理部分
总计有15448个数据
img.shape=(15448,20,20)
label_temp.shape=(26,15448)
因此每张图片为20*20的大小
同时进行处理，reshape为15448*400
同时对label进行处理，将其处理为ABCD...这种形式
'''
img, label = load_data()
label = label.T
'''
数据训练阶段
首先对所有数据进行测试集和训练集的划分，划分的比例为1：9
此过程为监督学习，因此采用的方法为类似mnist的处理方法
'''
'''
一开始的参数权重设置实在是太重要了，一个合适的参数可以帮助正确率大大提高，太玄学了（笑）
同时一开始的参数权重可以设置的小一点，不要太大，以及尽可能在一个数量级
同时alpha=0.01 beta=0.95 确实是最合适的参数了，其他的参数都没有这个好用
'''
trainData, testData, trainLabel, testLabel = ms.train_test_split(img, label, test_size=0.1)
W1 = 1e-2 * np.random.randn(9, 9, 20)
W5 = 1e-2 * np.random.uniform(-1, 1, (300, 720))
Wo = 1e-2 * np.random.uniform(-1, 1, (26, 300))
for _epoch in range(10):
    print(_epoch)
    W1, W5, Wo = MnistConv(W1, W5, Wo, trainData, trainLabel)

'''
数据测试
'''
X = testData
D = testLabel

acc = 0
N = X.shape[0]
for k in range(N):
    x = X[k, :, :]

    y1 = Conv(x, W1)
    y2 = ReLU(y1)
    y3 = Pool(y2)
    y4 = np.reshape(y3, (-1, 1))
    v5 = np.matmul(W5, y4)
    y5 = ReLU(v5)
    v = np.matmul(Wo, y5)
    y = Softmax(v)

    i = np.argmax(y)
    d = D[k, :]
    temp = np.argmax(d)
    if i == temp:
        acc = acc + 1

acc = acc / N
print("Accuracy is : ", acc)
