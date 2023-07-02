import bp as BP
import numpy as np
import matplotlib.pyplot as plt


layer = [3, 4, 1]
X = [
        [0,0,1],
        [0,1,1],
        [1,0,1],
        [1,1,1]
    ]
y = [[0], [1], [1], [0]]

epoch = 20000
bp = BP.BP(layer, epoch, 0.0001 , 0)
bp.fitSGD(X,y)
ys = bp.predict(X)
bp1 = BP.BP(layer, epoch, 0.0001 , 0.1)
bp1.fitMomentum(X,y)
bp2 = BP.BP(layer, epoch, 0.0001 , 0.2)
bp2.fitMomentum(X,y)
bp3 = BP.BP(layer, epoch, 0.0001 , 0.3)
bp3.fitMomentum(X,y)
bp4 = BP.BP(layer, epoch, 0.0001 , 0.4)
bp4.fitMomentum(X,y)


plt.plot(range(epoch) , bp.MSE , color = 'red' , label="No momentum")
plt.plot(range(epoch) , bp1.MSEMomentum , color = 'blue' , label="beta = 0.1")
plt.plot(range(epoch) , bp2.MSEMomentum , color = 'green' , label="beta = 0.2")
plt.plot(range(epoch) , bp3.MSEMomentum , color = 'gray' , label="beta = 0.3")
plt.plot(range(epoch) , bp4.MSEMomentum , color = 'orange' , label="beta = 0.4")
plt.legend()
plt.show()