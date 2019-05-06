clear;
run('./src/vlfeat/toolbox/vl_setup');

KMEANS_DIR = './kmeans/';
IMAGE_SIFT_DIR = './sift/image_sift/';
CLASS_SIFT_DIR = './sift/class_sift/';
VLAD_DIR = './vlad_vectors/';

% For encoding GMM models: note it if neccessary
load('all_sift.mat');

file_list = dir(fullfile(IMAGE_SIFT_DIR, '*.mat'));
image_num = length(file_list);

for k = [128, 256]
    centers = vl_kmeans(sift_data, k);
    save(strcat(KMEANS_DIR, 'centers', int2str(k), '.mat'), 'centers', '-v7.3');
    k
    mkdir(strcat(VLAD_DIR, 'VLAD', int2str(k)));
    for i = 1:image_num
        image_name = file_list(i).name;
        image_sift = fullfile(IMAGE_SIFT_DIR, image_name);
        load(image_sift)

        kdtree = vl_kdtreebuild(centers);
        nn = vl_kdtreequery(kdtree, centers, d);

        data_size = size(d);
        assignments = zeros(k, data_size(2));
        assignments(sub2ind(size(assignments), nn, 1:length(nn))) = 1;
        
        encoding = vl_vlad(d, centers, assignments);
        save(strcat(VLAD_DIR, 'VLAD', int2str(k), '/', image_name, '.mat'), 'encoding', '-v7.3');
        i
    end
end