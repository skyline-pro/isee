import numpy as np
from scipy import signal


def Pool(x):
    (xrow, xcol, numFilters) = x.shape
    y = np.zeros((int(xrow / 2), int(xcol / 2), numFilters))

    for k in range(numFilters):
        filter = np.ones((2, 2)) / (2 * 2)  # pooling 相当于与[1/4 1/4; 1/4 1/4]的filter做卷积；
        image = signal.convolve2d(x[:, :, k], filter, 'valid')

        y[:, :, k] = image[::2, ::2]

    return y


def ReLU(x):
    return np.maximum(0, x)


def Sigmoid(x):
    return 1.0 / (1.0 + np.exp(-x))


def Softmax(x):
    x = np.subtract(x, np.max(x))  # prevent overflow
    ex = np.exp(x)

    return ex / np.sum(ex)


def Conv(x, W):
    (wrow, wcol, numFilters) = W.shape
    (xrow, xcol) = x.shape

    yrow = xrow - wrow + 1
    ycol = xcol - wcol + 1

    y = np.zeros((yrow, ycol, numFilters))

    for k in range(numFilters):
        filter = W[:, :, k]
        filter = np.rot90(np.squeeze(filter), 2)  # 由conv2函数决定，需要先做镜像
        y[:, :, k] = signal.convolve2d(x, filter, 'valid')

    return y
