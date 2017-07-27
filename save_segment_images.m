train_folder = 'tropical-fruits-DB-1024x768';
image_folder = dir(train_folder);
mkdir segmented_images;
cd(train_folder);
num = length(image_folder);
classes = [];
names = cell(num-3,1);
for folders = 3:num
    images = dir(image_folder(folders).name);
    num_images = length(images);
    mkdir(strcat('../segmented_images/',image_folder(folders).name));
    classes(folders-2) = folders-2;
    names{folders-2} = image_folder(folders).name;
    cd(image_folder(folders).name);
    for idx = 3:num_images
        img = imread(images(idx).name);
        try
            seg_img = SegmentImage(img,3);
            imwrite(seg_img,strcat('../../segmented_images/',image_folder(folders).name,'/',images(idx).name),'jpg');
        catch
            idx = idx - 1;
            continue
        end
    end
    cd ../;
end
mapObj = containers.Map(classes,names);
save ../MAP.mat mapObj;

