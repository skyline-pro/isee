import numpy as np
import kNN
def createDataSet():
    group = np.array([[1.0,1.1] , [1.0,1.0] , [0,0] , [0,0.1]])
    labels = ['A' , 'A' , 'B' , 'B']
    return group , labels
group , labels = createDataSet()
print('点(0,0)的分类结果为%s' %(kNN.classify([0,0] , group , labels , 3)))
print('点(0.8,0.7)的分类结果为%s' %(kNN.classify([0.8,0.7] , group , labels , 3)))