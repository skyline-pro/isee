from sklearn import datasets
import numpy as np
import matplotlib.pyplot as plt

def w(data , n_neighbors = 10 , t = 1):
    sum_x = np.sum(np.square(data) , 1)
    dist = np.add(np.add(-2 * np.dot(data, data.T), sum_x).T, sum_x)
    dist[dist<0] = 0
    n = dist.shape[0]
    rbf_dist = np.exp(-(dist/t))

    W = np.zeros((n,n))
    for i in range(n):
        index_ = np.argsort(dist[i])[1:1+n_neighbors]
        W[i , index_] = rbf_dist[i,index_]
        W[index_ , i] = rbf_dist[index_,i]
    
    return W

def lpp(data , n = 2 , n_nerghbors = 30 , t = 1.0):
    N = data.shape[0]
    W = w(data , n_nerghbors , t)
    D = np.zeros_like(W)

    for i in range(N):
        D[i,i] = np.sum(W[i])
    
    L = D - W
    XDXT = np.dot(np.dot(data.T, D), data)
    XLXT = np.dot(np.dot(data.T, L), data)

    eigVals , eigVecs = np.linalg.eig(np.dot(np.linalg.pinv(XDXT) , XLXT))

    sortIndex = np.argsort(np.abs(eigVals))
    eigVals = eigVals[sortIndex]

    j = 0
    while eigVals[j] < 1e-6:
        j+=1

    sortIndex = sortIndex[j:j+n]
    eigValPicked = eigVals[j:j+n]
    eigValPicked = eigVecs[:,sortIndex]
    dataNDim = np.dot(data,eigValPicked)

    return dataNDim

#加载手写数字集
X = datasets.load_digits().data
y = datasets.load_digits().target

sum_x = np.sum(np.square(X) , 1)
dist = np.add(np.add(-2 * np.dot(X, X.T), sum_x).T, sum_x)
maxDist = np.max(dist)

data2D = lpp(X , n_nerghbors=5 , t=0.01*maxDist)

plt.scatter(data2D[:, 0] , data2D[:,1] , c =y)

plt.show()
 