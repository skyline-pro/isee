from libsvm.svmutil import svm_train, svm_predict, svm_save_model, svm_load_model

from dataset import load_data
import numpy as np
# from libsvm323.python.svmutil import *
# from libsvm323.python.svm import *
from transform import transform
import sklearn.model_selection as ms

[img, label] = load_data()  # 载入数据

# 训练集放14001个
trainData = img[1:14000, :, :]
trainLabel = label[:, 1:14000]

# 测试集放1516个
testLabel = label[:, 14001:15516]
testData = img[14001:15516, :, :]

# 数据转换，转换成svm_train匹配得数据结构
[label_new, img_new] = transform(trainLabel, trainData);

pass
c_r = {}  # 调参，正则化参数
g_r = {}  # 调参，核函数中的gamma函数

# 下面是调整正则化参数的
'''for i in range(16):
    c_change=str(2**(i-8))
    model=svm_train(label_new,img_new, '-s 0 -t 1 -c '+c_change+' -g 2.8')
    #训练模型
    print("-----result-----")
    [label_test,img_test]=transform(testLabel,testData)
    label_r,ac_r,value_r=svm_predict(label_test,img_test,model)
    print('惩罚系数为：{}'.format(c_change),'准确率为：{}'.format(ac_r))
    c_r['惩罚系数为'+c_change+"  对应的准确率为"]=ac_r[0]'''

# 下面是调整gama函数的
'''for i in range(16):
    g_change=str(2**(i-8))
    model=svm_train(label_new,img_new, '-s 0 -t 1 -c 8 -g '+g_change)
    #训练模型
    print("-----result-----")
    [label_test,img_test]=transform(testLabel,testData)
    label_r,ac_r,value_r=svm_predict(label_test,img_test,model)
    print('gama系数为:{}'.format(g_change),'准确率为：{}'.format(ac_r))
    c_r['gama系数为'+g_change+"  对应的准确率为"]=ac_r[0]
    '''
# 输出调参数据
'''for i in c_r.keys():
    print(i,c_r[i],'%')'''

# 模型训练
# model = svm_train(label_new, img_new, '-s 0 -t 1 -c 8 -g 2.8')
# svm_save_model('svm_model' , model)
model = svm_load_model('svm_model')

[label_test, img_test] = transform(testLabel, testData)
label_r, ac_r, value_r = svm_predict(label_test, img_test, model)
print(ac_r)
