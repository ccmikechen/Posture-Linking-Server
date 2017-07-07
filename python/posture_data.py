import os
import sys
import numpy as np
from random import shuffle

default_range = [(-2, 2), (-2, 2), (-2, 2), (0, 255), (0, 255), (0, 255), (0, 255), (-2, 2), (-2, 2), (-2, 2), (0, 255), (0, 255), (0, 255), (0, 255), (-2, 2), (-2, 2), (-2, 2), (-2, 2), (-2, 2), (-2, 2)]

def regularize(data_list, data_range=default_range):
    result = []
    for data in data_list:
        parsed_data = []
        for line in data:
            new_line = []
            for i in range(len(line)):
                (min, max) = data_range[i]
                new_line.append((line[i] - min) / (max - min))

            parsed_data.append(new_line)

        result.append(parsed_data)

    return np.array(result, dtype="float")

def split_train_and_test_data(all_data, all_type, proportion):
    random_list = range(len(all_data))
    shuffle(random_list)
    mid = int(len(all_data) * proportion)

    (train_data, train_type) = ([], [])
    for i in random_list[:mid]:
        train_data.append(all_data[i])
        train_type.append(all_type[i])

    train = (np.array(train_data, dtype="float"), np.array(train_type, dtype="uint8"))

    (test_data, test_type) = ([], [])
    for i in random_list[mid:]:
        test_data.append(all_data[i])
        test_type.append(all_type[i])

    test = (np.array(test_data, dtype="float"), np.array(test_type, dtype="uint8"))

    return (train, test)
