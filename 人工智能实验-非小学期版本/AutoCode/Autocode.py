from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import *
from tensorflow.keras.layers import *
from tensorflow.keras.optimizers import *
from tensorflow.keras.callbacks import ModelCheckpoint
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf

gpus = tf.config.experimental.list_physical_devices(device_type='GPU')
print(gpus)

# 数据处理
(xTrain, _), (xTest, _) = mnist.load_data()  # 加载训练数据与测试数据并且丢弃标签
xTrain = xTrain.astype('float32') / 255.
xTest = xTest.astype('float32') / 255.
xTrain = np.reshape(xTrain, (len(xTrain), 28, 28, 1))
xTest = np.reshape(xTest, (len(xTest), 28, 28, 1))

# 添加噪声
noiseFactor = 0.
xTrainNoise = xTrain + noiseFactor * np.random.normal(loc=0.0, scale=1.0, size=xTrain.shape)
xTestNoise = xTest + noiseFactor * np.random.normal(loc=0.0, scale=1.0, size=xTest.shape)
xTrainNoise = np.clip(xTrainNoise, 0., 1.)
xTestNoise = np.clip(xTestNoise, 0., 1.)
print(xTest.shape)
print(xTestNoise.shape)

# 搭建模型
inputImg = Input(shape=(28, 28, 1))  # 定义输入层大小

x = Conv2D(4, (3, 3), activation='relu', padding='same')(inputImg)
x = AveragePooling2D((2, 2), padding='same')(x)
x = Conv2D(4, (3, 3), activation='relu', padding='same')(x)
x = AveragePooling2D((2, 2), padding='same')(x)
x = Conv2D(4, (3, 3), activation='relu', padding='same')(x)
encoded = AveragePooling2D((2, 2), padding='same')(x)

x = Conv2D(4, (3, 3), activation='relu', padding='same')(encoded)
x = UpSampling2D((2, 2))(x)
x = Conv2D(4, (3, 3), activation='relu', padding='same')(x)
x = UpSampling2D((2, 2))(x)
x = Conv2D(4, (3, 3), activation='relu')(x)
x = UpSampling2D((2, 2))(x)
decoded = Conv2D(1, (3, 3), activation='sigmoid', padding='same')(x)

learning_rate = 1e-4
autoencoder = Model(inputImg, decoded)
autoencoder.compile(optimizer=Adam(lr=learning_rate), loss='mse')  # mse,mae,msle

# 训练
filepath = "Auto-{epoch:02d}-{val_loss:.2f}.hdf5"
model_checkpoint = ModelCheckpoint(filepath, monitor='val_loss', verbose=1, save_best_only=True, period=2)

history = autoencoder.fit(xTrainNoise, xTrain,
                          epochs=10,
                          batch_size=10,
                          shuffle=True,
                          validation_data=(xTestNoise, xTest),
                          callbacks=[model_checkpoint], )

# 画出训练过程
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('Model loss')
plt.ylabel('Loss')
plt.xlabel('Epoch')
plt.legend(['Train', 'Test'], loc='upper left')
plt.show()

# 典型结果测试、可视化、计算误差
Inx_N = 3
for inx in range(Inx_N):
    test_inp = xTestNoise[inx , ]
    test_inp = np.reshape(test_inp, (1,) + test_inp.shape)
    results = autoencoder.predict(test_inp, batch_size=1)
    Error = np.linalg.norm(xTest[inx , ] - results) / np.linalg.norm(xTestNoise[inx , ])
    print(Error)
