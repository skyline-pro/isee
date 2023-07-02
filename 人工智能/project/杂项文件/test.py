import cv2
import matplotlib.pyplot as plt
import time
import numpy as np
import pandas as pd
import os

filePath1 = r'F://data/yzm/'  # 验证码路径
filePath2 = r'F://data/yzm_split/'  # 切割后的验证码的存放路径

n = 0
fileNames1 = os.listdir(filePath1)
fileNames2 = os.listdir(filePath2)


def getIndex(file_name):
    fileNameIndex = file_name.split('_')[0]
    return fileNameIndex


n = int(max(list(map(getIndex, fileNames2))))
for fileName in fileNames1:
    filePathIm = r'F://data/yzm/{0}'.format(fileName)
    im1 = cv2.imread(filePathIm)  # 读入图片
    im_gray1 = cv2.cvtColor(im1, cv2.COLOR_BGR2GRAY)  # 将图片转成灰度图
    # 报错 error: (-215:Assertion failed) 原因是文件路径错误
    ret1, im_inv1 = cv2.threshold(im_gray1, 127, 255, cv2.THRESH_BINARY_INV)  # 二值化
    # 应用高斯模糊对图片进行降噪，高斯模糊的本质是用高斯核和图像做卷积
    kernel1 = 1 / 16 * np.array([[1, 2, 1], [2, 4, 2], [1, 2, 1]])
    im_blur1 = cv2.filter2D(im_inv1, -1, kernel1)

    # 降噪后再做一轮二值化处理
    ret2, im_inv2 = cv2.threshold(im_blur1, 127, 255, cv2.THRESH_BINARY)

    # 把最开始的图片切割成单个字符
    # 第一步 用opencv的findContours来提取轮廓 （cv2.findContours()函数接受的参数为二值图）
    im2, contours, hierarchy = cv2.findContours(im_inv2, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    # 第一个参数是寻找轮廓的图像，第二个参数表示轮廓的检索模式，第三个参数method为轮廓的近似办法
    cv2.drawContours(im1, contours, -1, (0, 255, 0), 1)  # 第三个参数为线条颜色，第四个参数线条粗度
    cv2.namedWindow("im1_drawContour")
    cv2.imshow("im1_drawContour", im1)
    cv2.waitKey(50)

    dfContourShape = pd.DataFrame(columns=('X', 'Y', 'W', 'H'))
    for i in range(len(contours)):
        # cv2.drawContours(cv2.imread(filepath1) , contours, i, (0, 255, 0), 1)   # i 表示绘制第i条轮廓
        x, y, w, h = cv2.boundingRect(contours[i])  # 用一个最小的矩形，把找到的形状包起来
        dfContourShape = dfContourShape.append([{'X': x, 'Y': y, 'W': w, 'H': h}], ignore_index=True)
        im3 = cv2.rectangle(im1, (x, y), (x + w, y + h), (0, 0, 255), 2)
        # cv2.namedWindow("im3")
        # cv2.imshow("im3", im3)
        # cv2.waitKey(50)
        # cv2.destroyAllWindows()
    result = []
    for i in range(len(dfContourShape)):
        x = dfContourShape['X'][i]
        y = dfContourShape['Y'][i]
        w = dfContourShape['W'][i]
        h = dfContourShape['H'][i]
        wMax = max(dfContourShape['W'])
        wMin = min(dfContourShape['W'])
        if len(dfContourShape) == 1:
            boxLeft = np.int0([[x, y], [x + w / 4, y], [x + w / 4, y + h], [x, y + h]])
            boxMidLeft = np.int0([[x + w / 4, y], [x + w * 2 / 4, y], [x + w * 2 / 4, y + h], [x + w / 4, y + h]])
            boxMidRight = np.int0(
                [[x + w * 2 / 4, y], [x + w * 3 / 4, y], [x + w * 3 / 4, y + h], [x + w * 2 / 4, y + h]])
            boxRight = np.int0([[x + w * 3 / 4, y], [x + w, y], [x + w, y + h], [x + w * 3 / 4, y + h]])
            result.extend([boxLeft, boxMidLeft, boxMidRight, boxRight])
        elif len(dfContourShape) == 2:  # 两种情况
            # 如果一个轮廓的宽度是另一个的2倍以上，这个轮廓大概率是包含3个字符的轮廓
            if wMax >= wMin * 2:
                if w == wMax:
                    box_left = np.int0([[x, y], [x + w / 3, y], [x + w / 3, y + h], [x, y + h]])
                    box_mid = np.int0([[x + w / 3, y], [x + w * 2 / 3, y], [x + w * 2 / 3, y + h], [x + w / 3, y + h]])
                    box_right = np.int0([[x + w * 2 / 3, y], [x + w, y], [x + w, y + h], [x + w * 2 / 3, y + h]])
                    result.append(box_left)
                    result.append(box_mid)
                    result.append(box_right)
                else:
                    box = np.int0([[x, y], [x + w, y], [x + w, y + h], [x, y + h]])
                    result.append(box)
            # 如果两个轮廓，较宽的宽度小于较窄的2倍，大概率这是两个包含2个字符的轮廓
            else:
                box_left = np.int0([[x, y], [x + w / 2, y], [x + w / 2, y + h], [x, y + h]])
                box_right = np.int0([[x + w / 2, y], [x + w, y], [x + w, y + h], [x + w / 2, y + h]])
                result.append(box_left)
                result.append(box_right)
        elif len(dfContourShape) == 3:
            if w == wMax:
                # w_max是所有 contonur 的宽度中最宽的值
                box_left = np.int0([[x, y], [x + w / 2, y], [x + w / 2, y + h], [x, y + h]])
                box_right = np.int0([[x + w / 2, y], [x + w, y], [x + w, y + h], [x + w / 2, y + h]])
                result.append(box_left)
                result.append(box_right)
            else:
                box = np.int0([[x, y], [x + w, y], [x + w, y + h], [x, y + h]])
                result.append(box)
        elif len(dfContourShape) == 4:
            box = np.int0([[x, y], [x + w, y], [x + w, y + h], [x, y + h]])
            result.append(box)
        elif len(dfContourShape) == 5:
            if w != wMin:
                box = np.int0([[x, y], [x + w, y], [x + w, y + h], [x, y + h]])
                result.append(box)
        else:
            print('分割轮廓数大于 5 切换验证码!')
    if len(result) != 4:
        print('len(result) != 4 .....\nlen(result) != 4 .....\nlen(result) != 4 .....')

    for box in result:
        cv2.drawContours(cv2.imread(filePathIm), [box], 0, (0, 0, 255), 1)
        cv2.namedWindow("im1")
        cv2.imshow("im1", im1)
        cv2.waitKey(100)  # 100毫秒
        time.sleep(3)
        cv2.destroyAllWindows()
        roi = im_inv2[box[0][1]:box[3][1], box[0][0]:box[1][0]]
        roiStd = cv2.resize(roi, (30, 30))
        # 将字符图片统一调整为30x30的图片大小
        # 为防止文件重名，使用时间戳命名文件名
        n += 1
        fileSavePath = '{0}_{1}img_{2}.png'.format(filePath2, n,
                                                   time.strftime('%Y%m%d%H%M%S', time.localtime(time.time())))
        print(fileSavePath)
        cv2.imwrite(fileSavePath, roiStd)

