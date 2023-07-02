from turtle import color
import numpy as np
import matplotlib.pyplot as plt

A = np.random.random((30,2))
B = np.random.random((30,2))
A = np.mat(A*3+10)
B = np.mat(B*3+15)

meanA = np.mat(np.mean(A , axis = 0))
meanB = np.mat(np.mean(B , axis = 0))

Sw = np.zeros((2,2))

for i in range(30):
    Sw = Sw + (A[i] - meanA).T * (A[i] - meanA)
    Sw = Sw + (B[i] - meanA).T * (B[i] - meanA)

temp = (meanA - meanB)
tempT = temp.reshape(2,1)
Sb = tempT * temp

eigVals, eigVecs = np.linalg.eig(np.linalg.inv(Sw).dot(Sb))
eigValIndex = np.argsort(eigVals)
w = np.array(eigVecs[1])


plt.scatter(A[:,0].tolist() , A[:,1].tolist() , marker = '^')
plt.scatter(B[:,0].tolist() , B[:,1].tolist() , marker = 'o')

x = np.arange(10,18,0.1)
y = -w[0][0]*x/w[0][1]
plt.plot(x,y,color = 'red')

plt.show()