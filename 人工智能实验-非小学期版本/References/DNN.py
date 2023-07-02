import numpy as np

class DNN:
    def __init__(self , layerNum , layer , iter , maxError):
        # 断言输入的层数与layer的长度一致
        assert len(layer) == layerNum , "定义的层数与layer长度不符"
        # 初始化网络层数
        self.layerNum = layerNum
        #初始化输入层的节点数
        self.inputN = layer[0]
        #初始化隐藏层的节点数
        self.hideN = []
        for i in range(layerNum-2):
            self.hideN.append(layer[i+1])
        #初始化输出层的节点数
        self.outputN = layer[layerNum-1]

        #初始化输入层与第一隐藏层之间的权值矩阵
        self.inputWeight = 2*np.random.random((self.inputN , self.hideN[0]))-1
        #初始化隐藏层
        self.hideWights = []
        for i in range(layerNum-3):
            self.hideWights.append(2*np.random.random((self.hideN[i] , self.hideN[i+1]))-1)

        #初始化输出层
        self.outputWight = 2*np.random.random((self.hideN[layerNum-3] , self.outputN))-1

        #初始化迭代次数
        self.iter = iter

        #初始化最大误差
        self.maxError = maxError

        #用于储存隐藏层输出
        self.hideY = []
    
    def reset(self):
        #初始化输入层与第一隐藏层之间的权值矩阵
        self.inputWeight = 2*np.random.random((self.inputN , self.hideN[0]))-1

        #初始化隐藏层
        self.hideWights = []
        for i in range(layerNum-3):
            self.hideWights.append(2*np.random.random((self.hideN[i] , self.hideN[i+1]))-1)

        #初始化输出层
        self.outputWight = 2*np.random.random((self.hideN[layerNum-3] , self.outputN))-1

    def relu(self , x):
        return np.maximum(x,0)

    def reluDerivation(self , x):
        if(x>0):
            return 1
        else:
            return 0

    def softMax(self , x):
        x -= np.max(x)
        p = np.exp(x) / np.sum(np.exp(x))
        return p

    def dropOut(self,x,prob):
        y = np.random.binomial(n=1, p=1-prob, size=len(x))
        y = y / (1-prob)
        return y

    def forwardBackwordDropout(self , data , dest , learnRate = 0.01 , prob = 0.2):
        reluDerivation = np.vectorize(self.reluDerivation)
        #转换类型
        assert isinstance(data , list) , "输入data不为list"
        assert isinstance(dest , list) , "输入dest不为list"
        data = np.array(data)
        dest = np.array(dest)

        hideY = []
        hideE = []
        #计算第一层隐藏层的输出
        hideV = np.dot(data , self.inputWeight)
        hideE.append(self.dropOut(hideV , prob))
        hideY.append(self.relu(hideV) * hideE[0])

        #计算出隐藏层的输出
        for i in range(self.layerNum - 3):
            hideV = np.dot(hideY[i] , self.hideWights[i])
            hideE.append(self.dropOut(hideV , prob))
            hideY.append(self.relu(hideV) * hideE[i+1])

        #计算输出层输出
        outputV = np.dot(hideY[self.layerNum-3] , self.outputWight)
        outputY = self.softMax(outputV)

        #计算出输出层误差
        outputError = outputY - dest

        outputDelta = outputError

        #进行反向传播
        hideError = []
        hideDelta = []
        for i in range(self.layerNum - 2):
            if(i != 0):
                hideError.insert(0 , np.dot(hideDelta[0] , (self.hideWights[self.layerNum-3-i]).T))
                assert hideError[0].ndim == 1 , "hideError的维度必须为1"
                hideDelta.insert(0 , hideE[self.layerNum-3-i]*hideError[0] * reluDerivation(hideY[self.layerNum-3-i])) 
            else:
                hideError.insert(0 , np.dot(outputDelta , self.outputWight.T))
                hideDelta.insert(0 , hideError[0] * reluDerivation(hideY[self.layerNum-3]))

        #更新输入层权值矩阵
        for i in range(self.inputWeight.shape[0]):
            for j in range(self.inputWeight.shape[1]):
                self.inputWeight[i][j] -= learnRate*hideDelta[0][j]*data[i]

        #更新隐藏层权值矩阵
        for k in range(len(self.hideWights)):
            for i in range(self.hideWights[k].shape[0]):
                for j in range(self.hideWights[k].shape[1]):
                    self.hideWights[k][i][j] -= learnRate*hideDelta[k+1][j]*hideY[k][i]

        #更新输出层权值矩阵
        for i in range(self.outputWight.shape[0]):
            for j in range(self.outputWight.shape[1]):
                self.outputWight[i][j] -= learnRate*outputDelta[j]*hideY[self.layerNum-3][i]

        return outputError

    def forwardBackword(self , data , dest , learnRate = 0.01):
        reluDerivation = np.vectorize(self.reluDerivation)
        #转换类型
        assert isinstance(data , list) , "输入data不为list"
        assert isinstance(dest , list) , "输入dest不为list"
        data = np.array(data)
        dest = np.array(dest)

        hideY = []
        #计算第一层隐藏层的输出
        hideV = np.dot(data , self.inputWeight)
        hideY.append(self.relu(hideV))

        #计算出隐藏层的输出
        for i in range(self.layerNum - 3):
            hideV = np.dot(hideY[i] , self.hideWights[i])
            hideY.append(self.relu(hideV))

        #计算输出层输出
        outputV = np.dot(hideY[self.layerNum-3] , self.outputWight)
        outputY = self.softMax(outputV)

        #计算出输出层误差
        outputError = outputY - dest

        outputDelta = outputError

        #进行反向传播
        hideError = []
        hideDelta = []
        for i in range(self.layerNum - 2):
            if(i != 0):
                hideError.insert(0 , np.dot(hideDelta[0] , (self.hideWights[self.layerNum-3-i]).T))
                assert hideError[0].ndim == 1 , "hideError的维度必须为1"
                hideDelta.insert(0 , hideError[0] * reluDerivation(hideY[self.layerNum-3-i])) 
            else:
                hideError.insert(0 , np.dot(outputDelta , self.outputWight.T))
                hideDelta.insert(0 , hideError[0] * reluDerivation(hideY[self.layerNum-3]))

        #更新输入层权值矩阵
        for i in range(self.inputWeight.shape[0]):
            for j in range(self.inputWeight.shape[1]):
                self.inputWeight[i][j] -= learnRate*hideDelta[0][j]*data[i]

        #更新隐藏层权值矩阵
        for k in range(len(self.hideWights)):
            for i in range(self.hideWights[k].shape[0]):
                for j in range(self.hideWights[k].shape[1]):
                    self.hideWights[k][i][j] -= learnRate*hideDelta[k+1][j]*hideY[k][i]

        #更新输出层权值矩阵
        for i in range(self.outputWight.shape[0]):
            for j in range(self.outputWight.shape[1]):
                self.outputWight[i][j] -= learnRate*outputDelta[j]*hideY[self.layerNum-3][i]

        return outputError

    def fit(self , X , y):
        for i in range(self.iter):
            #print(i)
            error = 0.0
            for j in range(len(X)):
                error += abs(self.forwardBackword(X[j] , y[j]))
            error = error.sum()

            if abs(error) <= self.maxError:
                print(i)
                break
    
    def fitDropout(self , X , y):
        for i in range(self.iter):
            #print(i)
            error = 0.0
            for j in range(len(X)):
                error += abs(self.forwardBackwordDropout(X[j] , y[j]))
            error = error.sum()

            if abs(error) <= self.maxError:
                print(i)
                break
    
    def predict(self , testX):
        # relu = np.vectorize(self.relu)
        assert isinstance(testX , list) , "输入testX不为list"
        testX = np.array(testX)
        hideY = []
        #计算第一层隐藏层的输出
        hideV = np.dot(testX , self.inputWeight)
        hideY.append(self.relu(hideV))

        #计算出隐藏层的输出
        for i in range(self.layerNum - 3):
            hideV = np.dot(hideY[i] , self.hideWights[i])
            hideY.append(self.relu(hideV))

        #计算输出层输出
        outputV = np.dot(hideY[self.layerNum-3] , self.outputWight)
        outputY = self.softMax(outputV)
        print(outputY)
        return outputY

if __name__ == '__main__':
    layerNum = 5
    layer = [25 , 20,20, 20 , 5]
    X = [
        [0,1,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,1,1,1,0],
        [1,1,1,1,0, 0,0,0,0,1, 0,1,1,1,0, 1,0,0,0,0, 1,1,1,1,1],
        [1,1,1,1,0, 0,0,0,0,1, 0,1,1,1,0, 0,0,0,0,1, 1,1,1,1,0],
        [0,0,0,1,0, 0,0,1,1,0, 0,1,0,1,0, 1,1,1,1,1, 0,0,0,1,0],
        [1,1,1,1,1, 1,0,0,0,0, 1,1,1,1,0, 0,0,0,0,1, 1,1,1,1,0]
    ]

    y = [
        [1,0,0,0,0],
        [0,1,0,0,0],
        [0,0,1,0,0],
        [0,0,0,1,0],
        [0,0,0,0,1]
    ]

    dnn = DNN(layerNum , layer , 1000 , 0.00000000001)
    dnn.fitDropout(X,y)
    print("采用Dropout结果：")
    for i in range(len(y)):
        dnn.predict(X[i])

    dnn.reset()
    dnn.fit(X,y)
    print("不采用Dropout结果：")
    for i in range(len(y)):
        dnn.predict(X[i]) 