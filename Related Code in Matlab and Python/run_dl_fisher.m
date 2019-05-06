clear;
run('./src/vlfeat/toolbox/vl_setup');

GMM_DIR = './dl_gmm/';
IMAGE_DESCRIPTOR_DIR = './DL_features_mat/';
FISHER_DIR = './dl_fisher_vectors/';

% For encoding GMM models: note it if neccessary

load('all_dl_features.mat');

for k = [256]
    [means, covariances, priors] = vl_gmm(descriptors, k);
    save(strcat(GMM_DIR, 'means', int2str(k), '.mat'), 'means', '-v7.3');
    save(strcat(GMM_DIR, 'covariances', int2str(k), '.mat'), 'covariances', '-v7.3');
    save(strcat(GMM_DIR, 'priors', int2str(k), '.mat'), 'priors', '-v7.3');
    k
end

% For encoding fisher features

% file_list = dir(fullfile(IMAGE_DESCRIPTOR_DIR, '*.mat'));
% image_num = length(file_list);

% for k = [8, 32, 64, 128]
%     means_dir = strcat(GMM_DIR, 'means', int2str(k), '.mat');
%     covariances_dir = strcat(GMM_DIR, 'covariances', int2str(k), '.mat');
%     priors_dir = strcat(GMM_DIR, 'priors', int2str(k), '.mat');

%     load(means_dir)
%     load(covariances_dir)
%     load(priors_dir)

%     mkdir(strcat(FISHER_DIR, 'fisher', int2str(k)));
%     for i = randperm(image_num, int32(image_num*0.1))
%         image_name = file_list(i).name;
%         image_sift = fullfile(IMAGE_DESCRIPTOR_DIR, image_name);
%         load(image_sift)
        
%         encoding = vl_fisher(double(dl_feature), means, covariances, priors);

%         save(strcat(FISHER_DIR, 'fisher', int2str(k), '/', image_name, '.mat'), 'encoding', '-v7.3');
%         i
%     end
% end