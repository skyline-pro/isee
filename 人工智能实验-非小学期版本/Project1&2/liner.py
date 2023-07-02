from cgi import test
from turtle import color
import numpy as np
from matplotlib import pyplot as plt

x = 2*np.random.rand(100,1)
y = 4 + 3*x + np.random.randn(100,1)
plt.scatter(x,y,label="Origin Data")

x = np.c_[np.ones(100 , float) , x]
temp = np.dot(x.T , x)
ans = np.dot(np.linalg.inv(temp),x.T)
ans = np.dot(ans , y)   
test_x = np.arange(-0.25,2.25,0.01)
test_y = ans[0] + ans[1]*test_x
plt.plot(test_x,test_y , color = 'red' ,label='Predict result')
plt.xlabel('x')
plt.ylabel('y')
plt.legend(loc='upper left')

plt.show()
