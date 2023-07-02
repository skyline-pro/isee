from cmath import isnan
from matplotlib.pyplot import axis
import numpy as np
import matplotlib.pyplot as plt

def loadDataSet(filename):
    '''
    map()的返回值在python3里面已经不再是一个list了,而是一个iterators,这是python2里面的用法

    这个用法应该被扫进历史的垃圾桶！！！
    '''
    # fr = open(filename)
    # stringArr = [line.strip().split(delim) for line in fr.readline()]
    # dataArr = [map(float,line) for line in stringArr]
    dataArr = np.loadtxt(filename)
    return np.mat(dataArr)

def pca(dataMat , topNFeat = 9999):
    #求出每一列的均值，并且将dataMat中的均值减去
    meanVals = np.mean(dataMat , axis = 0)
    meanRemoved = dataMat - meanVals
    #求出协方差矩阵
    covMat = np.cov(meanRemoved , rowvar=0)
    eigVals , eigVects = np.linalg.eig(np.mat(covMat))
    eigValIndex = np.argsort(eigVals)
    eigValIndex = eigValIndex[:-(topNFeat+1):-1]
    redEigVects = eigVects[:,eigValIndex]
    lowDemensionDataMat = meanRemoved * redEigVects
    reconMat = (lowDemensionDataMat * redEigVects.T) + meanVals
    return lowDemensionDataMat , reconMat

def replaceNanWithMean():
    datMat = loadDataSet('secom.data')
    numFeat = np.shape(datMat)[1]
    for i in range(numFeat):
        all = 0
        k = 0
        for j in range(np.shape(datMat)[0]):
            if ~np.isnan(datMat[j,i]):
                all+=datMat[j,i]
                k+=1
        meanVal = all/k
        for j in range(np.shape(datMat)[0]):
            if np.isnan(datMat[j,i]):
                datMat[j,i] = meanVal
    return datMat

# 实验4-1
dataMat = loadDataSet('testSet.txt')
lowDemensionData1 , reconMat1 = pca(dataMat , 1)
lowDemensionData2 , reconMat2 = pca(dataMat , 2)
fig1 = plt.figure(1)
fig2 = plt.figure(2)
ax = fig1.add_subplot(111)
bx = fig2.add_subplot(111)
ax.scatter(dataMat[:,0].tolist() , dataMat[:,1].tolist() , marker = '^' , s = 90)
ax.scatter(reconMat1[:,0].tolist() , reconMat1[:,1].tolist() , marker = 'o' , s = 90)
bx.scatter(dataMat[:,0].tolist() , dataMat[:,1].tolist() , marker = '^' , s = 90)
bx.scatter(reconMat2[:,0].tolist() , reconMat2[:,1].tolist() , marker = 'o' , s = 90)
plt.show()

# 实验4-2
dataMat2 = replaceNanWithMean()
i = 1
while(1):
    x = 0
    y = 0
    lowDemensionData1 , reconMat1 = pca(dataMat2,i)
    
    accuracy = np.linalg.norm(dataMat2 - reconMat1) / np.linalg.norm(dataMat2)
    print(accuracy)
    if accuracy < 0.09:
        break
    else:
        i += 1
print(i)

