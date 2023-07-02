import imp
from tkinter import Y, Image

from sympy import re
import LoadMnistData as ld
import numpy as np
import sklearn.model_selection as ms
from Conv import Conv
from Pool import Pool
from scipy import signal


def relu(x):
    return np.maximum(x, 0)


def softMax(x):
    x = np.subtract(x, np.max(x))  # prevent overflow
    ex = np.exp(x)

    return ex / np.sum(ex)


# 载入数据
Images, Labels = ld.LoadMnistData('MNIST\\t10k-images-idx3-ubyte.gz', 'MNIST\\t10k-labels-idx1-ubyte.gz')
Images = np.divide(Images, 255)
X_train = Images[0:2000, :, :]
D = Labels[0:2000]

# 将label转换为onehot
size = D.shape
labelOneHot = np.zeros((10, size[0]))
for i in range(size[0]):
    labelOneHot[D[i][0]][i] = 1
y_train = labelOneHot

W1 = 1e-2 * np.random.randn(9, 9, 20)
W2 = 1e-2 * np.random.uniform(-1, 1, (100, 2000))
W3 = 1e-2 * np.random.uniform(-1, 1, (10, 100))

epoch = 100

for k in range(epoch):
    alpha = 0.013
    beta = 0.96
    mmt1 = np.zeros_like(W1)
    mmt2 = np.zeros_like(W2)
    mmt3 = np.zeros_like(W3)
    for j in range(size[0]):
        x = X_train[j, :, :]
        d = y_train[:, j].reshape(10, 1)
        y1 = Conv(x, W1)
        y2 = relu(y1)
        y3 = Pool(y2)
        y4 = np.reshape(y3, (-1, 1))
        v5 = W2 @ y4
        y5 = relu(v5)
        v = W3 @ y5
        y = softMax(v)

        e = d - y
        delta = e
        e5 = W3.T @ delta
        delta5 = (y5 > 0) * e5
        e4 = W2.T @ delta5
        e3 = np.reshape(e4, y3.shape)
        e2 = np.zeros_like(y2)
        W4 = np.zeros_like(y2) / (2 * 2)
        for i in range(20):
            e2[:, :, i] = np.kron(e3[:, :, i], np.ones((2, 2))) * W4[:, :, i]
        delta2 = (y2 > 0) * e2
        delta1X = np.zeros_like(W1)
        for i in range(20):
            delta1X[:, :, i] = signal.convolve2d(x[:, :], np.rot90(delta2[:, :, i], 2), 'valid')

        dW1 = delta1X
        dW2 = delta5 @ y4.T
        dW3 = delta @ y5.T
        mmt1 = alpha * dW1 + beta * mmt1
        mmt2 = alpha * dW2 + beta * mmt2
        mmt3 = alpha * dW3 + beta * mmt3

        W1 = W1 + mmt1
        W2 = W2 + mmt2
        W3 = W3 + mmt3
    print(k)

# 测试
X_test = Images[2000:2500, :, :]
y_test = Labels[2000:2500]
N = X_test.shape[0]
acc = 0
for i in range(N):
    x = X_test[i, :, :]
    y1 = Conv(x, W1)
    y2 = relu(y1)
    y3 = Pool(y2)
    y4 = np.reshape(y3, (-1, 1))
    v5 = W2 @ y4
    y5 = relu(v5)
    v = W3 @ y5
    y = softMax(v)
    j = np.argmax(v)
    if y_test[i][0] == j:
        acc = acc + 1

acc = acc / N

print(acc)
