from __future__ import print_function
import numpy as np
np.random.seed(1337)  # for reproducibility

import tensorflow as tf
from tensorflow.python.framework import graph_util

import keras.backend.tensorflow_backend as K
from keras.utils import np_utils

import posture_data
import posture_model

import os
import os.path as osp

sess = tf.Session()
K.set_session(sess)

batch_size = 8
nb_epoch = 12

def build_posture_model(data_list,
                        type_list,
                        dimensions=(17, 16),
                        classes=31,
                        model_path="./models/tensorflow_model/",
                        output_graph_name="output_graph.pb"):
    (rows, cols) = dimensions

    all_data = np.array(data_list, dtype="float")
    all_type = np.array(type_list, dtype="uint8")

    all_data = posture_data.regularize(all_data)

    (train_data, train_type), (test_data, test_type) = posture_data.split_train_and_test_data(all_data, all_type, 0.8)

    train_data = train_data.reshape(train_data.shape[0], 1, cols, rows).astype('float32')
    test_data = test_data.reshape(test_data.shape[0], 1, cols, rows).astype('float32')

    print('train_data shape:', train_data.shape)
    print(train_data.shape[0], 'train samples')
    print(test_data.shape[0], 'test samples')

    train_type = np_utils.to_categorical(train_type, classes)
    test_type = np_utils.to_categorical(test_type, classes)

    model = posture_model.create_posture_model(rows, cols, classes)

    model.fit(train_data, train_type, batch_size=batch_size, epochs=nb_epoch,
               verbose=1, validation_data=(test_data, test_type))

    score = model.evaluate(test_data, test_type, verbose=0)
    print('Test score:', score[0])
    print('Test accuracy:', score[1])

    # model.save_weights('./models/modelA.hdf5', overwrite=True)

    # Save graph
    output_node_names_of_input_network = ["conv2d_1_input"]
    output_node_names_of_final_network = 'output'

    num_output = len(output_node_names_of_input_network)
    pred = [None]*num_output
    pred_node_names = [None]*num_output

    for i in range(num_output):
        pred_node_names[i] = output_node_names_of_final_network + str(i)
        pred[i] = tf.identity(model.output[i], name=pred_node_names[i])

    print('Output nodes names are:', pred_node_names)

    # Write Graph
    output_graph_path = osp.join(model_path, output_graph_name)
    gd = sess.graph.as_graph_def()
    constant_graph = graph_util.convert_variables_to_constants(sess, gd, pred_node_names)
    tf.train.write_graph(constant_graph, model_path, output_graph_name, as_text=False)
    print('Saved the constant graph (ready for inference) at:', osp.join(model_path, output_graph_path))

    return output_graph_path
