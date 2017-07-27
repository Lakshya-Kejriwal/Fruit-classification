seg_folder = 'segmented_images';
image_folder = dir(seg_folder);
cd(seg_folder);
num = length(image_folder);
train_features_glcm1 = zeros(1,4);
train_labels = zeros(1,1);
label = 1;
for folders = 3:num
    images = dir(image_folder(folders).name);
    num_images = length(images);
    cd(image_folder(folders).name);
    fprintf('Evaluating features for %s\n' ,  image_folder(folders).name);
    for idx = 3:num_images
        seg_img = imread(images(idx).name);
        if ndims(seg_img) == 3
            img = rgb2gray(seg_img);
        end
        GLCM = graycomatrix(img); 
        stats = graycoprops(GLCM, 'all');
        features = struct2array(stats);
        train_features_glcm1 = [train_features_glcm1; features];
        train_labels = [train_labels; label];
    end
    cd ../;
    label = label + 1;
end
train_features_glcm1(1,:) = [];
glcm = train_features_glcm1;
train_labels(1,:) = [];

train_glcm = [glcm train_labels];
save ../glcm_data.mat glcm train_glcm train_labels;