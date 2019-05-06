clear;
run('./src/vlfeat/toolbox/vl_setup');

% Parameter setting
k_numClusters = 30;
IMAGE_SIFT_DIR = './sift/image_sift/';
CLASS_SIFT_DIR = './sift/class_sift/';

% Steps:
%   1. extract local descriptors
%   2. encode the local descriptors within each image into a feature vector

% The vl_sift command requires a single precision gray scale image.
% It also expects the range to be normalized in the [0,255] interval

% The matrix f has a column for each frame.
% A frame is a disk of center f(1:2), scale f(3) and orientation f(4)

file_list = dir(fullfile(IMAGE_SIFT_DIR, '*.mat'));
image_num = length(file_list);

for i = 1:image_num
    image_name = file_list(i).name;
    image_sift = fullfile(IMAGE_SIFT_DIR, image_name);
    load(image_sift)
    
    sift_size = size(d);
    if sift_size(2) > 500
        d = d(:, 1:500);
    end
    if i == 1
        sift_data = d;
    else
        sift_data = cat(2, sift_data, d);
    end 
    size(sift_data)
end
% [means, covariances, priors] = vl_gmm(data, numClusters);
% encoding = vl_fisher(d_a, means, covariances, priors);