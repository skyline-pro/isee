import numpy as np
from sklearn import svm
import sklearn.model_selection as skl

#从文件中读取出数据并且划分数据与标签
path = './training.data'
data = np.loadtxt(path )
x , y = np.split(data , indices_or_sections=(6,),axis=1)

#将数据归一化
mean = np.array([np.mean(x[:,i]) for i in range(x.shape[1])])
std = np.array([np.std(x[:,i]) for i in range(x.shape[1])])
ans = np.empty(shape = x.shape , dtype = float)
for i in range(x.shape[1]):
    ans[:,i] = (x[:,i] - mean[i])/std[i]
x = ans

#划分训练集以及测试集
tempData , testData , tempLabel , testLabel = skl.train_test_split(x,y,random_state=1,test_size=0.15)
#将训练集中的一部分用来训练，一部分用作超参数选择
trainData , selectData , trainLabel , selectLabel = skl.train_test_split(tempData,tempLabel,random_state=1,test_size=0.15)

clf_final= svm.SVC(kernel='rbf', gamma=0.25, C=0.5).fit(trainData,trainLabel)
labelPredict = clf_final.predict(testData)
k = 0
for i in range(len(labelPredict)):
    if testLabel[i]==labelPredict[i]:
        k+=1
accuracy=float(k)/float(len(testLabel))
print("The accuracy of SVM is %f"%(accuracy))