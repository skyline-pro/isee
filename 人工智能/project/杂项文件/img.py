import cv2
import os
import numpy as np
from img_process import signal_picture

file = './data/img/code_4877.png'
# 读取图片
img = cv2.imread(file)
# output = signal_picture(img)
img = cv2.pyrMeanShiftFiltering(img, sp=70, sr=50)
# 转换为灰度图
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
# 将灰度图二值化
ret1, img_inv1 = cv2.threshold(img_gray, 0, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
cv2.imshow('二值化', img_inv1)
kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))
ret2 = cv2.morphologyEx(img_inv1, cv2.MORPH_OPEN, kernel=kernel, iterations=1)
# ret3 = cv2.erode(ret2, kernel, iterations=1)
# cv2.imshow('close', ret3)
# 高斯降噪
kernel = 1 / 16 * np.array([[1, 2, 1], [2, 4, 2], [1, 2, 1]])
img_blur = cv2.filter2D(ret2, -1, kernel)
# 对高斯降噪后的图像再进行一次二值化
# ret2, img_inv2 = cv2.threshold(img_blur, 127, 255, cv2.THRESH_BINARY_INV)
ret2, img_inv2 = cv2.threshold(img_blur, 127, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
cv2.imshow('test', img_inv2)
if img_inv2[0][0] == 255:
    img_inv2 = ~img_inv2
retval, labels, stats, centroids = cv2.connectedComponentsWithStats(img_inv2, connectivity=8)
stats = stats[np.argsort(stats[:, 0])]
output = []
for i in range(1, retval):
    if stats[i][2] > 20:
        temp2 = img_inv2[stats[i][1]:stats[i][1] + stats[i][3], stats[i][0] + int(stats[i][2] / 2):stats[i][0] + stats[i][2]]
        temp1 = img_inv2[stats[i][1]:stats[i][1] + stats[i][3], stats[i][0]:stats[i][0] + int(stats[i][2] / 2) + 3]

        output.append(cv2.resize(temp1, (20, 20)))
        output.append(cv2.resize(temp2, (20, 20)))
    else:
        temp = img_inv2[stats[i][1]:stats[i][1] + stats[i][3], stats[i][0]:stats[i][0] + stats[i][2]]
        output.append(cv2.resize(temp, (20, 20)))
# for i in range(len(output)):
#     if output[i].shape[0] < 20 | output[i].shape[1] < 20:
#         cv2.copyMakeBorder(output[i], (20 - output[i].shape[1]) / 2, (20 - output[i].shape[1]) / 2, (20 - output[i].shape[0]) / 2, (20 - output[i].shape[0]) / 2, cv2.BORDER_CONSTANT, value=0)

# cv2.imshow('te',output[3])
for i in range(len(output)):
    cv2.imshow(str(i), output[i])
# 调用cv2的findContours来提取轮廓
# contours , hierarchy = cv2.findContours(img_inv1 , 2 , 2)
# cv2.drawContours(img, contours, -1, (0, 255, 0), 1)  # 第三个参数为线条颜色，第四个参数线条粗度
# cv2.namedWindow("im1_drawContour")
# cv2.imshow("im1_drawContour", img)
# cv2.waitKey(50)

if cv2.waitKey(0) == 27:
    cv2.destroyAllWindows()
