from __future__ import print_function
import numpy as np
np.random.seed(1337)  # for reproducibility

from keras.models import Sequential
from keras.layers import Dense, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import np_utils

# number of convolutional filters to use
nb_filters = 32
# size of pooling area for max pooling
nb_pool = 2
# convolution kernel size
nb_conv = 3

def create_posture_model(rows, cols, classes):
    model = Sequential()
    model.add(Conv2D(nb_filters, kernel_size=(nb_conv, nb_conv),
                     activation='relu',
                     input_shape=(1, cols, rows)))
    model.add(Conv2D(nb_filters * 2, (nb_conv, nb_conv), activation='relu'))
#    model.add(MaxPooling2D(pool_size=(nb_pool, nb_pool)))
    model.add(Flatten())
    model.add(Dense(nb_filters * 4, activation='relu'))
    model.add(Dense(classes, activation='softmax'))

    model.compile(loss='categorical_crossentropy', optimizer='adadelta', metrics=['accuracy'])

    return model
