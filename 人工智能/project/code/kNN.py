import numpy as np


def classify(inX, dataSet, labels, k):
    # 对于二维数组，shape[0]代表行数，shape[1]代表列数
    dataSize = dataSet.shape[0]
    # 将待测试数据集复制后与数据集做差
    diffSet = np.tile(inX, np.array([dataSize, 1])) - dataSet
    diffSet = np.square(diffSet)
    # 进行行方向求和,sum函数的参数axis代表求和方向，0时列方向求和，1时行方向求和
    sumSet = diffSet.sum(axis=1)
    # 将求和结果从小到大排序并且返回索引
    arrayIndex = sumSet.argsort()
    # 创建一个空字典
    dictionary = {}
    # 利用一个循环得到最近的k个值
    for i in range(k):
        # 如果第i个值已经在字典中了，就将其的值+1
        if labels[arrayIndex[i]] in dictionary:
            dictionary[labels[arrayIndex[i]]] = dictionary.get(labels[arrayIndex[i]]) + 1
        # 如果不存在于字典中，则将其加入字典并把值赋为1
        else:
            dictionary[labels[arrayIndex[i]]] = 1
    # 提取出字典中的key和value
    key = np.array(list(dictionary.keys()))
    value = np.array(list(dictionary.values()))
    # 将value排序并返回脚标
    keyIndex = value.argsort()

    # 返回最大脚标对应的key
    return key[keyIndex[-1]]
