seg_folder = 'segmented_images';
image_folder = dir(seg_folder);
cd(seg_folder);
num = length(image_folder);
train_features_ltp = zeros(1,510);
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
        thresh = 255*graythresh(seg_img);
        [ltp_upper, ltp_lower] = getLTP(img, thresh);
        hist = histogram(ltp_upper(:),255);
        high = hist.Values;
        hist = histogram(ltp_lower(:),255);
        lower = hist.Values;
        features = [high lower];
        train_features_ltp = [train_features_ltp; features];
        train_labels = [train_labels; label];
    end
    cd ../;
    label = label + 1;
end
train_features_ltp(1,:) = [];
ltp = train_features_ltp;
train_labels(1,:) = [];

train_ltp = [ltp train_labels];
save ../ltp_data.mat ltp train_ltp train_labels;
