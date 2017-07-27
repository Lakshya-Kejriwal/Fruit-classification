seg_folder = 'segmented_images';
image_folder = dir(seg_folder);
cd(seg_folder);
num = length(image_folder);
train_features_iccv = zeros(1,108);
train_labels = zeros(1,1);
label = 1;
for folders = 3:num
    images = dir(image_folder(folders).name);
    num_images = length(images);
    cd(image_folder(folders).name);
    fprintf('Evaluating features for %s\n' ,  image_folder(folders).name);
    for idx = 3:num_images
        seg_img = imread(images(idx).name);
        CCV = getCCV(seg_img); 
        features = reshape(CCV.',1,[]);
        train_features_iccv = [train_features_iccv; features];
        train_labels = [train_labels; label];
    end
    cd ../;
    label = label + 1;
end
train_features_iccv(1,:) = [];
ccv = train_features_iccv;
train_labels(1,:) = [];

train_ccv = [ccv train_labels];
save ../ccv_data.mat ccv train_ccv train_labels;