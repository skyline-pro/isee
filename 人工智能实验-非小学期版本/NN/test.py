import bp as BP
import DNN

layer = [3, 4, 2]
X = [
        [0,0,1],
        [0,1,1],
        [1,0,1],
        [1,1,1]
    ]
y = [[0,0], [0,1], [1,0], [1,0]]

layerNum = 3

dnn = DNN.DNN(layerNum , layer , 1000 , 0.0001)
dnn.fit(X , y)
dnn.predict(X[1])