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
tempData , testData , tempLabel , testLabel = skl.train_test_split(x,y,random_state=0,test_size=0.15)
#将训练集中的一部分用来训练，一部分用作超参数选择
trainData , selectData , trainLabel , selectLabel = skl.train_test_split(tempData,tempLabel,random_state=0,test_size=0.15)
td , sd , tl , sl = skl.train_test_split(selectData,selectLabel,random_state=0,test_size=0.2)

#计算出两个超参数
get = False
if get:
    result =[]
    for i in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
        C = 2 ** i
        for j in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
            G = 2 ** j
            clf1 = svm.SVC(kernel='rbf', gamma=G, C=C).fit(td,tl.ravel())
            y_predictions1=clf1.predict(sd)
            k=0
            for i in range(len(sl)):
                if y_predictions1[i]==sl[i]:
                    k+=1
            result.append([C,G,k])
            print([C,G,k])
    result1 = sorted(result, key=lambda x:x[2]) 
    np.set_printoptions(suppress=False)
    np.savetxt('chooseHyperpara.txt',result1, fmt='%.04f')

# 以选取的超参数进行训练
clf_final= svm.SVC(kernel='rbf', gamma=0.25, C=0.5).fit(trainData,trainLabel.ravel())
labelPredict = clf_final.predict(testData)
k = 0
for i in range(len(labelPredict)):
    if testLabel[i]==labelPredict[i]:
        k+=1
accuracy=float(k)/float(len(testLabel))
print("The accuracy of SVM is %f"%(accuracy))

# 读入最终的测试数据
testPath = './testingNoAnswer.data'
testDataFinal = np.loadtxt(testPath)
#将其归一化
mean = np.array([np.mean(testDataFinal[:,i]) for i in range(testDataFinal.shape[1])])
std = np.array([np.std(testDataFinal[:,i]) for i in range(testDataFinal.shape[1])])
ans = np.empty(shape = testDataFinal.shape , dtype = float)
for i in range(testDataFinal.shape[1]):
    ans[:,i] = (testDataFinal[:,i] - mean[i])/std[i]
testDataFinal = ans
#调用训练好的模型对测试数据进行分类
labelPredictFinal = clf_final.predict(testDataFinal)
#保存结果
np.savetxt('submit.txt',labelPredictFinal, fmt='%.00f')