from cmath import isnan
from sys import int_info
import numpy as np

class BP:
    def __init__(self , layer , iter , maxError , beta):
        #初始化输入、隐藏、输出层的节点数目
        self.inputN = layer[0]
        self.hideN = layer[1]
        self.outputN = layer[2]

        self.beta = beta

        #初始化输入层与隐藏层之间的权值矩阵
        self.inputWeight = np.random.random((self.inputN , self.hideN))
        #初始化隐藏层与输出层之间的权值矩阵
        self.outputWeight = np.random.random((self.hideN , self.outputN))

        #初始化最大迭代次数
        self.iter = iter
        #初始化停止的最大误差
        self.maxError = maxError

        #初始化momentum所需参数
        self.inputM = np.zeros((self.inputN , self.hideN))
        self.outputM = np.zeros((self.hideN , self.outputN))

        self.MSE = []
        self.MSEMomentum = []

    #定义激活函数
    def sigmid(self , x):
        return 1.0/(1+np.exp(-x))

    #定义激活函数的导数
    def sigmidDerivation(self , x):
        return x*(1-x)

    def forwardBackwordMomentum(self , data , dest , learnRate = 0.5 , beta = 0.1):
        assert isinstance(data , list) , "输入data不为list"
        assert isinstance(dest , list) , "输入dest不为list"
        data = np.array(data)
        dest = np.array(dest)
        
        #利用输入层与隐藏层之间的权值矩阵计算出隐藏层输出
        hideV = np.dot(data , self.inputWeight)
        hideY = self.sigmid(hideV)

        #同上计算出输出层输出
        outputV = np.dot(hideY , self.outputWeight)
        outputY = self.sigmid(outputV)

        #得到输出层误差
        outputError = outputY - dest

        outputDelta = outputError * self.sigmidDerivation(outputY)

        #进行反向传播
        hideError = np.dot(outputDelta , self.outputWeight.T)
        assert hideError.ndim == 1 , "hideError维度不为1"
        hideDelta = hideError * self.sigmidDerivation(hideY)

        #更新输入层权值矩阵
        for i in range(self.inputWeight.shape[0]):
            for j in range(self.inputWeight.shape[1]):
                self.inputM[i][j] = learnRate*hideDelta[j]*data[i] + beta * self.inputM[i][j]
                self.inputWeight[i][j] -= self.inputM[i][j]

        #更新输出层权值矩阵
        for i in range(self.outputWeight.shape[0]):
            for j in range(self.outputWeight.shape[1]):
                self.outputM[i][j] = learnRate*outputDelta[j]*hideY[i] + beta * self.outputM[i][j]
                self.outputWeight[i][j] -= self.outputM[i][j]
        
        return outputError , outputY

    def resetBP(self):
        #初始化输入层与隐藏层之间的权值矩阵
        self.inputWeight = np.random.random((self.inputN , self.hideN))
        #初始化隐藏层与输出层之间的权值矩阵
        self.outputWeight = np.random.random((self.hideN , self.outputN))
        #初始化momentum所需参数
        self.inputM = np.zeros((self.inputN , self.hideN))
        self.outputM = np.zeros((self.hideN , self.outputN))


    def forwardBackwordSGD(self , data , dest , learnRate = 0.1):
        assert isinstance(data , list) , "输入data不为list"
        assert isinstance(dest , list) , "输入dest不为list"
        data = np.array(data)
        dest = np.array(dest)
        
        #利用输入层与隐藏层之间的权值矩阵计算出隐藏层输出
        hideV = np.dot(data , self.inputWeight)
        hideY = self.sigmid(hideV)

        #同上计算出输出层输出
        outputV = np.dot(hideY , self.outputWeight)
        outputY = self.sigmid(outputV)

        #得到输出层误差
        outputError = outputY - dest

        outputDelta = outputError * self.sigmidDerivation(outputY)

        #进行反向传播
        hideError = np.dot(outputDelta , self.outputWeight.T)
        assert hideError.ndim == 1 , "hideError维度不为1"
        hideDelta = hideError * self.sigmidDerivation(hideY)

        #更新输入层权值矩阵
        for i in range(self.inputWeight.shape[0]):
            for j in range(self.inputWeight.shape[1]):
                self.inputWeight[i][j] -= learnRate*hideDelta[j]*data[i]

        #更新输出层权值矩阵
        for i in range(self.outputWeight.shape[0]):
            for j in range(self.outputWeight.shape[1]):
                self.outputWeight[i][j] -= learnRate*outputDelta[j]*hideY[i]

        return outputError , outputY
    
    def fitSGD(self , X , y):
        for i in range(self.iter):
            error = 0.0
            outputy = []
            for j in range(len(X)):
                temp , y1= self.forwardBackwordSGD(X[j] , y[j])
                error += abs(temp)
                outputy.append(y1)
            error = error.sum()
            self.MSE.append(np.mean(np.square(np.array(y)-np.array(outputy))))

            if abs(error) <= self.maxError:
                print(i)
                break

    def fitMomentum(self , X , y):
        for i in range(self.iter):
            error = 0.0
            outputy = []
            for j in range(len(X)):
                temp , y1= self.forwardBackwordMomentum(X[j] , y[j] , self.beta)
                error += abs(temp)
                outputy.append(y1)
            error = error.sum()
            self.MSEMomentum.append(np.mean(np.square(np.array(y)-np.array(outputy))))

            if abs(error) <= self.maxError:
                print(i)
                break
            

    def predict(self , testX):
        assert isinstance(testX , list) , "输入testX不为list"
        testX = np.array(testX)
        hideV = np.dot(testX , self.inputWeight)
        hideY = self.sigmid(hideV)
        outputV = np.dot(hideY , self.outputWeight)
        y = self.sigmid(outputV)
        #print(y)
        return y

if __name__ == '__main__':
    layer = [3, 4, 2]
    X = [
            [0,0,1],
            [0,1,1],
            [1,0,1],
            [1,1,1]
        ]
    y = [[0], [1], [1], [0]]
    #  设置最大的迭代次数，以及最大误差值
    bp = BP(layer, 100000, 0.0001)
    bp.fitSGD(X, y)
    bp.predict(X)
    bp.resetBP()
    bp.fitMomentum(X,y)
    bp.predict(X)
