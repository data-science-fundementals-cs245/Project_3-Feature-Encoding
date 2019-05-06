clear;
run('./src/vlfeat/toolbox/vl_setup');

GMM_DIR = './gmm/';
IMAGE_SIFT_DIR = './sift/image_sift/';
CLASS_SIFT_DIR = './sift/class_sift/';
FISHER_DIR = './fisher_vectors/';

% For encoding GMM models: note it if neccessary
load('all_sift.mat');

% for k = [256]
%     [means, covariances, priors] = vl_gmm(sift_data, k);
%     save(strcat(GMM_DIR, 'means', int2str(k), '.mat'), 'means', '-v7.3');
%     save(strcat(GMM_DIR, 'covariances', int2str(k), '.mat'), 'covariances', '-v7.3');
%     save(strcat(GMM_DIR, 'priors', int2str(k), '.mat'), 'priors', '-v7.3');
%     k
% end

% For encoding fisher features

file_list = dir(fullfile(IMAGE_SIFT_DIR, '*.mat'));
image_num = length(file_list);

for k = [128, 256]
    means_dir = strcat(GMM_DIR, 'means', int2str(k), '.mat');
    covariances_dir = strcat(GMM_DIR, 'covariances', int2str(k), '.mat');
    priors_dir = strcat(GMM_DIR, 'priors', int2str(k), '.mat');

    load(means_dir)
    load(covariances_dir)
    load(priors_dir)

    mkdir(strcat(FISHER_DIR, 'fisher', int2str(k)));
    for i = 1:image_num
        image_name = file_list(i).name;
        image_sift = fullfile(IMAGE_SIFT_DIR, image_name);
        load(image_sift)
        
        encoding = vl_fisher(d, means, covariances, priors);

        save(strcat(FISHER_DIR, 'fisher', int2str(k), '/', image_name, '.mat'), 'encoding', '-v7.3');
        i
    end
end