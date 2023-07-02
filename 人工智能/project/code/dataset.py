import cv2
import os
import numpy as np
import json
import h5py

# 原始图片路径
img_dir = './data/img/'
# 标签文件路径
label_dir = './data/true_label.json'
# 切分后图片存储路径
split_dir = './data/split/'
# hdf5数据集路径
hdf5_dir = './data/h5/'
dataset_dir = './data/h5/dataset.h5'

dictionary = {'A': 0, 'B': 1, 'C': 2, 'D': 3, 'E': 4, 'F': 5, 'G': 6,
              'H': 7, 'I': 8, 'J': 9, 'K': 10, 'L': 11, 'M': 12, 'N': 13,
              'O': 14, 'P': 15, 'Q': 16, 'R': 17, 'S': 18, 'T': 19, 'U': 20,
              'V': 21, 'W': 22, 'X': 23, 'Y': 24, 'Z': 25}


def single_picture(pic):
    # 彩色域去噪
    img = cv2.pyrMeanShiftFiltering(pic, sp=70, sr=50)
    # 转换为灰度图
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # 将灰度图二值化
    ret1, img_inv1 = cv2.threshold(img_gray, 0, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    # 进行闭运算
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))
    ret2 = cv2.morphologyEx(img_inv1, cv2.MORPH_OPEN, kernel=kernel, iterations=1)
    # 高斯降噪
    kernel = 1 / 16 * np.array([[1, 2, 1], [2, 4, 2], [1, 2, 1]])
    img_blur = cv2.filter2D(img_inv1, -1, kernel)
    ret2, img_inv2 = cv2.threshold(img_blur, 127, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    if img_inv2[0][0] == 255:
        img_inv2 = ~img_inv2
    # 基于连通域的方法对图像进行切割
    retval, labels, stats, centroids = cv2.connectedComponentsWithStats(img_inv2, connectivity=8)
    stats = stats[np.argsort(stats[:, 0])]
    output = []
    for i in range(1, retval):
        if stats[i][2] > 20:
            # 出现粘连时，没有完全从正中切开，而是选择了将中间的几列像素切到两个字母中
            temp1 = img_inv2[stats[i][1]:stats[i][1] + stats[i][3], stats[i][0]:stats[i][0] + int(stats[i][2] / 2) + 1]
            temp2 = img_inv2[stats[i][1]:stats[i][1] + stats[i][3],
                    stats[i][0] + int(stats[i][2] / 2):stats[i][0] + stats[i][2]]
            output.append(cv2.resize(temp1, (20, 20)))
            output.append(cv2.resize(temp2, (20, 20)))
        else:
            temp = img_inv2[stats[i][1]:stats[i][1] + stats[i][3], stats[i][0]:stats[i][0] + stats[i][2]]
            output.append(cv2.resize(temp, (20, 20)))
    for i in range(len(output)):
        ret, output[i] = cv2.threshold(output[i], 0, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
    if len(output) == 4:
        return output
    else:
        return []


def create_data(length):
    haze = []
    gt = []
    if length >= 4000:
        length = 4000
    imgs = os.listdir(img_dir)[length:]
    labels = json.load(open(label_dir))
    for img in imgs:
        # 读取图片，获得分割后的图片
        pic = cv2.imread(img_dir + img)
        outputs = single_picture(pic)
        # 根据图片名称获得对应的标签
        (file_name, extension) = os.path.splitext(img)
        num = file_name.split('_')[1]
        label = labels[num].upper()
        print(num)
        for i in range(len(outputs)):
            haze.append(outputs[i])
            gt.append(dictionary[label[i]])
            temp_dir = split_dir + label[i]
            if not os.path.exists(temp_dir):
                os.makedirs(temp_dir)
            # if not cv2.imwrite(temp_dir + '/' + label[i] + num + '.jpg', outputs[i]):
            #     print("ERROR")
    haze = np.asarray(haze)
    gt = np.asarray(gt)
    if not os.path.exists(hdf5_dir):
        os.mkdir(hdf5_dir)
    with h5py.File(dataset_dir, 'w') as hf:
        hf.create_dataset('img', data=haze)
        hf.create_dataset('label', data=gt)


def load_data():
    with h5py.File(dataset_dir, 'r') as hf:
        img = np.array(hf.get('img'))
        temp = np.array(hf.get('label'))
    # 将标签转换为one-hot类型
    label = np.zeros((26, len(temp)))
    for i in range(len(temp)):
        label[temp[i]][i] = 1
    # print(len(img))
    # print(len(label[0]))
    return img, label


if __name__ == '__main__':
    create_data(4000)
    load_data()
