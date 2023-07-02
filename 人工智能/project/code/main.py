import os
import cv2
import json

import h5py
import numpy as np
from kNN import classify
from dataset import single_picture, load_data
from libsvm.svmutil import svm_load_model, svm_predict

test_dir = './data/test/'
label_dir = './data/true_label.json'
# 使用的方法的参数，有三个选项
method = 'svm'


def use_kNN(pic_kNN):
    img_kNN, label_temp = load_data()
    img_size = img_kNN.shape
    pic_size = pic_kNN.shape
    pic_kNN = np.array(pic_kNN).reshape(pic_size[0], pic_size[1] * pic_size[2])
    img_kNN = np.array(img_kNN).reshape(img_size[0], img_size[1] * img_size[2])
    label_kNN = []
    for i_kNN in range(img_size[0]):
        label_kNN.append(chr(ord('A') + np.argwhere(label_temp[:, i_kNN] == 1)[0][0]))
    label_kNN = np.array(label_kNN)
    ans_kNN = []
    for i in range(len(pic_kNN)):
        ans_kNN.append(classify(pic_kNN[i], img_kNN, label_kNN, k=4))
        print(ans_kNN)
    return ans_kNN


if __name__ == '__main__':
    imgs = os.listdir(test_dir)
    label = json.load(open(label_dir))
    i = 0

    pic = cv2.imread(test_dir + 'code_5.png')
    # pic = cv2.imread('./data/img/code_18.png')
    cv2.imshow('picture', pic)
    split = single_picture(pic)
    if method == 'svm':
        split = np.array(split).reshape(4, 400)
        model = svm_load_model('svm_model')
        ans, sn, si = svm_predict(np.zeros(len(split)), split, model)
        yzm = []
        for i in ans:
            yzm.append(chr(ord('A') + int(i)))
        print(yzm)
    elif method == 'kNN':
        os.system("python use_kNN.py")
    elif method == 'cnn':
        os.system("python cnn.py")
    while 1:
        if cv2.waitKey(1) & 0xFF == ord('q'):
            cv2.destroyAllWindows()
            break
