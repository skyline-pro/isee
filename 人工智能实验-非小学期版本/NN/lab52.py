import bp as BP

layer = [3, 4, 1]
X = [
        [0,0,1],
        [0,1,1],
        [1,0,1],
        [1,1,1]
    ]
y = [[0], [1], [1], [0]]
#  设置最大的迭代次数，以及最大误差值
bp = BP.BP(layer, 100000, 0.0001 , 0.1)
bp.fitSGD(X, y)
bp.predict(X)