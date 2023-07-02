import json
import os

label_dir = './data/true_label.json'
img_dir = './data/img/code_'
labels = json.load(open(label_dir))
counter = 0
for i in range(len(labels)):
    dst = img_dir+str(i)+'.png'
    str1 = labels[str(i)].upper()
    if len(str1) != 4:
        counter += 1
        os.remove(dst)
        print('the length of ' + str(i) + ' is not 4')
    elif (str1[0] < 'A') | (str1[0] > 'Z'):
        counter += 1
        os.remove(dst)
        print('the 1st char of ' + str(i))
    elif (str1[1] < 'A') | (str1[1] > 'Z'):
        counter += 1
        os.remove(dst)
        print('the 2nd char of ' + str(i))
    elif (str1[2] < 'A') | (str1[2] > 'Z'):
        counter += 1
        os.remove(dst)
        print('the 3th char of ' + str(i))
    elif (str1[3] < 'A') | (str1[3] > 'Z'):
        counter += 1
        os.remove(dst)
        print('the 4th char of ' + str(i))
    else:
        continue
print(counter)
