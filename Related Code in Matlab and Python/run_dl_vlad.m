clear;
run('./src/vlfeat/toolbox/vl_setup');

KMEANS_DIR = './dl_kmeans/';
IMAGE_DESCRIPTOR_DIR = './DL_features_mat/';
VLAD_DIR = './dl_vlad_vectors/';

% For encoding GMM models: note it if neccessary
load('all_sift.mat');

file_list = dir(fullfile(IMAGE_DESCRIPTOR_DIR, '*.mat'));
image_num = length(file_list);

for k = [4, 16]
    centers = vl_kmeans(sift_data, k);
    save(strcat(KMEANS_DIR, 'centers', int2str(k), '.mat'), 'centers', '-v7.3');
    k
    mkdir(strcat(VLAD_DIR, 'VLAD', int2str(k)));
    for i = randperm(image_num, int32(image_num*0.1))
        image_name = file_list(i).name;
        image_sift = fullfile(IMAGE_DESCRIPTOR_DIR, image_name);
        load(image_sift)
        
        dl_feature = double(dl_feature);
        
        kdtree = vl_kdtreebuild(centers);
        nn = vl_kdtreequery(kdtree, centers, dl_feature);

        data_size = size(dl_feature);
        assignments = zeros(k, data_size(2));
        assignments(sub2ind(size(assignments), nn, 1:length(nn))) = 1;
        
        encoding = vl_vlad(dl_feature, centers, assignments);
        save(strcat(VLAD_DIR, 'VLAD', int2str(k), '/', image_name, '.mat'), 'encoding', '-v7.3');
        i
    end
end