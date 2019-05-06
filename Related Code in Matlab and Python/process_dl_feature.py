import numpy as np
import pickle   
import os
import scipy.io as scio

DL_FEATURE_DIR = "./DL_features/"
DL_MATLAB_DIR = "./DL_features_mat/"

def load_pickle(dir):  
    with open(dir, "rb") as fw:
        return pickle.load(fw)

for class_dir in os.listdir(DL_FEATURE_DIR):
    class_name = class_dir.split(".")[0]
    class_feature = load_pickle(os.path.join(DL_FEATURE_DIR, class_dir))
    for image_name, image_feature in class_feature:
        save_name = image_name.split(".")[0]
        scio.savemat(os.path.join(DL_MATLAB_DIR, save_name + ".mat"), {"dl_feature": image_feature.T})
    
    