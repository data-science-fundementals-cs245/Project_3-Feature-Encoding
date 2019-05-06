import scipy.io as scio
import os 
import numpy as np
import h5py
from sklearn.svm import SVC
from sklearn.model_selection import GridSearchCV
import sklearn.decomposition as sk_decomposition 

ROOT_DIR = "./dl_fisher_vectors/"

class_names = [ 'antelope.mat', 'bat.mat', 'beaver.mat', 'blue+whale.mat', 'bobcat.mat',
                'buffalo.mat', 'chihuahua.mat', 'chimpanzee.mat', 'collie.mat', 'cow.mat',
                'dalmatian.mat', 'deer.mat', 'dolphin.mat', 'elephant.mat', 'fox.mat',
                'german+shepherd.mat', 'giant+panda.mat', 'giraffe.mat', 'gorilla.mat',
                'grizzly+bear.mat', 'hamster.mat', 'hippopotamus.mat', 'horse.mat', 'humpback+whale.mat',
                'killer+whale.mat', 'leopard.mat', 'lion.mat', 'mole.mat', 'moose.mat',
                'mouse.mat', 'otter.mat', 'ox.mat', 'persian+cat.mat', 'pig.mat', 'polar+bear.mat',
                'rabbit.mat', 'raccoon.mat', 'rat.mat', 'rhinoceros.mat', 'seal.mat', 
                'sheep.mat', 'siamese+cat.mat', 'skunk.mat', 'spider+monkey.mat', 'squirrel.mat', 
                'tiger.mat', 'walrus.mat', 'weasel.mat', 'wolf.mat', 'zebra.mat']

# for FISHER_DIR in os.listdir(ROOT_DIR):
FISHER_DIR = "fisher16"
print("Loading for fisher vectors: %s" %FISHER_DIR)

whole_data = []
lable_data = []

for i, sample_file in enumerate(os.listdir(os.path.join(ROOT_DIR, FISHER_DIR))):
    sample_f = h5py.File(os.path.join(ROOT_DIR, FISHER_DIR, sample_file)) 
    sample_name = sample_file.split("_")[0] + ".mat"
    for k, v in sample_f.items():
        tmp = np.array(v)
        if i == 0:
            whole_data = tmp
        else:
            whole_data = np.concatenate([whole_data, tmp])
    lable_data.append(class_names.index(sample_name))

lable_data = np.array(lable_data)
data_length = whole_data.shape[0]

# Dimension Reduction
if whole_data.shape[1] > 2048:
    PCA_DIMS = 2048

    pca = sk_decomposition.PCA(n_components=PCA_DIMS, whiten=False, svd_solver='auto')
    whole_data = pca.fit_transform(whole_data)
    print("PCA Dimension Redcution Finished")
# Dimension Reduction

print(whole_data.shape)
print(lable_data.shape)

shuffle_index = np.random.permutation(data_length)
lable_data = lable_data[shuffle_index]
whole_data = whole_data[shuffle_index]

train_data = whole_data[:int(data_length*0.6)]
train_label = lable_data[:int(data_length*0.6)]
test_data = whole_data[int(data_length*0.6)+1:]
test_label = lable_data[int(data_length*0.6)+1:]

svc = SVC(kernel='rbf', class_weight='balanced', )
c_range = np.logspace(-2, 10, 4, base=2)
gamma_range = np.logspace(-5, 3, 5, base=2)
param_grid = [{'kernel': ['rbf'], 'C': c_range, 'gamma': gamma_range}]
grid = GridSearchCV(svc, param_grid, cv=3, n_jobs=4)
clf = grid.fit(train_data, train_label)
acc = grid.score(test_data, test_label)
print("Fisher Vectors SVM accuracy: %f" %acc)