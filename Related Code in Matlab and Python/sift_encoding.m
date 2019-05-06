clear;
run('./src/vlfeat/toolbox/vl_setup');

% Steps:
%   1. extract local descriptors
%   2. encode the local descriptors within each image into a feature vector

% The vl_sift command requires a single precision gray scale image.
% It also expects the range to be normalized in the [0,255] interval

% image = single(vl_imreadgray('./images/paradise.jpg')*255);

% The matrix f has a column for each frame.
% A frame is a disk of center f(1:2), scale f(3) and orientation f(4)

% [f, d] = vl_sift(image);
% d = double(d);
% data = cat(data, d);

% numClusters = 30;
% [means, covariances, priors] = vl_gmm(data, numClusters);
% encoding = vl_fisher(d_a, means, covariances, priors);

IMAGE_DIR = './images/JPEGImages/';
IMAGE_SIFT_DIR = './sift/image_sift/';
CLASS_SIFT_DIR = './sift/class_sift/';

class_list = dir(fullfile(IMAGE_DIR));
class_length = length(class_list);

for i = 1:class_length
    class_name = class_list(i).name;
    if class_name == "." || class_name == ".."
        continue
    end
    class_dir = fullfile(IMAGE_DIR, class_name);
    file_list = dir(fullfile(class_dir, '*.jpg'));
    image_num = length(file_list);
    
    chosen_class_index = reshape(randsample(image_num, int32(image_num/10)), 1, []);

    for j = chosen_class_index
        image_name = file_list(j).name;

        image = single(vl_imreadgray(fullfile(class_dir,image_name))*255);
        [f, d] = vl_sift(image);
        d = double(d);
        
        save(strcat(IMAGE_SIFT_DIR, image_name, '.mat'), 'd', '-v7.3');

        if j == chosen_class_index(1)
            data = d;
        else
            data = cat(2, data, d);
        end 
        size(data)
    end
    save(strcat(CLASS_SIFT_DIR, class_name, '.mat'), 'data', '-v7.3');
end


