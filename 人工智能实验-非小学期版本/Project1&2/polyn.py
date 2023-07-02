import numpy as np 
from sklearn.preprocessing import PolynomialFeatures
from matplotlib import pyplot as plt 

m = 100
X = 6* np.random.rand(m,1) - 3
y = 0.5 * X**2 + X + 2 + np.random.randn(m,1)
plt.scatter(X,y,label="Origin Data")

ploy_features = PolynomialFeatures(degree=2 , include_bias=False)
X_ploy = ploy_features.fit_transform(X)

X_ploy = np.c_[np.ones(100 , float) , X_ploy]
temp = np.dot(X_ploy.T , X_ploy)
ans = np.dot(np.linalg.inv(temp),X_ploy.T)
ans = np.dot(ans , y)

test_X_ploy = np.arange(-3,3,0.01)
test_y = ans[0] + ans[1]*test_X_ploy + ans[2]*test_X_ploy**2
plt.plot(test_X_ploy,test_y , color = 'red' ,label='Predict result')
plt.xlabel('x')
plt.ylabel('y')
plt.legend(loc='upper left')

plt.show()