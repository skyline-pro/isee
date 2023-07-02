import numpy as np


# label_new里保存了15561个单个字母的标签，0代表A，25代表Z
# img_nwe里保存了15561个对应字母图片，每个像素点代表一个特征，用字典表示
def transform(label, img):
    label_new = []
    img_new = []
    label_col = np.size(label, 1)
    for i in range(label_col):
        label_new.append(max(np.where(label[:, i] == 1)[0]))
        img_one = {}
        index = 1
        for j in range(20):
            for k in range(20):
                img_one[index] = img[i, j, k]
                index += 1
        img_new.append(img_one)
    return [label_new, img_new]
