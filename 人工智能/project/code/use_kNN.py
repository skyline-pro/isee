import cv2
import numpy as np
import sklearn.model_selection as ms

from dataset import load_data , single_picture
from kNN import classify

img, label_temp = load_data()
img_size = img.shape
# label_temp = label_temp.reshape(label_temp.shape[1], label_temp.shape[0])
img = np.array(img).reshape(img_size[0], img_size[1] * img_size[2])
label = []
for i in range(img_size[0]):
    label.append(chr(ord('A') + np.argwhere(label_temp[:, i] == 1)[0][0]))
print('y')
label = np.array(label)

trainData, testData, trainLabel, testLabel = ms.train_test_split(img , label , test_size=0.1)
# 两个counter用于计算100个测试集中正确的个数
falseNum = 0
trueNum = 0
# 使用测试集验证正确性
for i in range(testData.shape[0]):
    ans = classify(testData[i], trainData, trainLabel, k=4)
    if ans != testLabel[i]:
        # print('False')
        falseNum = falseNum + 1
    else:
        # print('True')
        trueNum = trueNum + 1

print('正确率为%.2lf%%' % (trueNum / (trueNum + falseNum) * 100))
