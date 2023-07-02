from cProfile import label
from matplotlib import lines
import kNN
import numpy as np

import sklearn.model_selection as ms

class standerScale(object):
    def __init__(self):
        self.mean = None
        self.std = None
    def fit(self , x):
        assert x.ndim == 2 , '传入数据维度必须为2维'
        self.mean = np.array([np.mean(x[:,i]) for i in range(x.shape[1])])
        self.std = np.array([np.std(x[:,i]) for i in range(x.shape[1])])
        return self
    def scale(self , x):
        assert x.ndim == 2 , '传入数据维度必须为2维'
        assert self.mean is not None and self.std is not None , '在使用scale方法前必须先使用fit方法'
        assert x.shape[1] == len(self.mean) , '传入数据列数必须和均值方差长度相等'
        ans = np.empty(shape = x.shape , dtype = float)
        for i in range(x.shape[1]):
            ans[:,i] = (x[:,i] - self.mean[i])/self.std[i]
        return ans

#函数creatDataset从txt中读取数据，归一化并且划分出训练集和测试集
def creatDataset(str):
    fp = open(str,'r')
    line = fp.readline()
    dataSet = []
    labels = []
    while line:
        linestr = line.split('\t')
        a = []
        a.append(float(linestr[0]))
        a.append(float(linestr[1]))
        a.append(float(linestr[2]))
        dataSet.append(np.array(a))
        labels.append(int(linestr[3]))
        line = fp.readline()
    fp.close()
    dataSet = np.array(dataSet)
    labels = np.array(labels)
    data = standerScale()
    data.fit(dataSet)
    scaleDataSet = data.scale(dataSet)
    #自动划分训练集以及测试集
    trainData  , testData , trainLabel, testLabel = ms.train_test_split(scaleDataSet , labels , test_size=0.1)

    return trainData , trainLabel , testData , testLabel

trainData , trainLabel , testData , testLabel =  creatDataset('datingTestSet2.txt')
#两个counter用于计算100个测试集中正确的个数
falseNum = 0
trueNum = 0
#使用测试集验证正确性
for i in range(testData.shape[0]):
    ans = kNN.classify(testData[i] , trainData , trainLabel , k = 3)
    if ans!=testLabel[i]:
        # print('False')
        falseNum = falseNum + 1
    else:
        # print('True')
        trueNum = trueNum + 1

print('正确率为%.2lf%%' %(trueNum/(trueNum+falseNum)*100))