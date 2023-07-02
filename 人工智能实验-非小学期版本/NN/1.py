import math
from socket import MSG_DONTROUTE
from tkinter import Y
from turtle import color
import numpy as np
import random
import matplotlib.pyplot as plt
#定义激活函数
def sigmid(x):
    return 1.0/(1+math.exp(-x))

def deltaSGD(W , X , D , alpha):
    '''
    W:传递权重的参数
    X:训练数据
    D:标准输出
    alpha:学习率
    '''
    
    for i in range(len(X)):
        v = 0
        d = D[i]
        for j in range(len(X[0])):
            v = v + W[j]*X[i][j]
        y = sigmid(v)
        e = d - y
        for j in range(len(X[0])):
            dw = y*(1-y)*e*alpha*X[i][j]
            W[j] = W[j]+ dw
    return W

def Batch(W , X , D , alpha):
    '''
    W:传递权重的参数
    X:训练数据
    D:标准输出
    alpha:学习率
    '''
    wSum = []
    for i in range(len(W)):
        wSum.append(0)
    for i in range(len(X)):
        v = 0 
        d = D[i]
        for j in range(len(X[0])):
            v = v + W[j]*X[i][j]
        y = sigmid(v)
        e = d - y
        for j in range(len(X[0])):
            dw = y*(1-y)*alpha*e*X[i][j]
            wSum[j] = wSum[j] + dw
    for i in range(len(W)):
        W[i] = W[i] + wSum[i]*1.0/len(D)

    return W


if __name__ == '__main__':
    MSESGD = []
    MSEBatch = []
    WSGD = []
    WBatch = []
    data = [[0,0,1],[0,1,1],[1,0,1],[1,1,1]]
    D = [0,0,1,1]
    for i in range(len(data[0])):
        WSGD.append(2*random.random()-1)
        WBatch.append(2*random.random()-1)
    
    epoch = 1000
    alpha = 0.1
    for i in range(epoch):
        WSGD = deltaSGD(WSGD , data , D , alpha)
        WBatch = Batch(WBatch , data , D , alpha)
        ys = []
        yb = []
        #计算运算结果以及MSE
        for j in range(len(data)):
            vs = 0
            vb = 0
            for q in range(len(data[0])):
                vs = vs + WSGD[q]*data[j][q]
                vb = vb + WBatch[q]*data[j][q]
            ys.append(sigmid(vs))
            yb.append(sigmid(vb))
            
        MSEBatch.append(np.mean(np.square(np.array(D)-np.array(yb))))
        MSESGD.append(np.mean(np.square(np.array(D)-np.array(ys))))

    for j in range(len(data)):
        vs = 0
        for q in range(len(data[0])):
            vs = vs + WSGD[q]*data[j][q]
        ys=sigmid(vs)
        print(ys)

    plt.plot(range(epoch) , MSEBatch , color = 'red')
    plt.plot(range(epoch) , MSESGD , color = 'blue')
    plt.show()