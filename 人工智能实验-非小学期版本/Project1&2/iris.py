import numpy as np
from sklearn import datasets
from sklearn.metrics import accuracy_score
import sklearn.model_selection as ms
from sklearn.linear_model import LogisticRegression
from matplotlib import pyplot as plt


iris = datasets.load_iris()
X = iris["data"][:,3:]
y = (iris["target"] == 2).astype(int)

X_train , X_test , y_train , y_test = ms.train_test_split(X , y , test_size=0.1)

lr = LogisticRegression()

lr.fit(X_train , y_train)

lr_test_pridect = lr.predict_proba(np.arange(0,3,0.01).reshape(300,1))



print(accuracy_score(lr.predict(X_test) , y_test))



plt.plot(np.arange(0,3,0.01), lr_test_pridect[:,1] )
plt.show()