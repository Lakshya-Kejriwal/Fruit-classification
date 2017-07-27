data = load('Training_Data.mat');
labels = load('Training_Data','train_labels');

labels = labels.train_labels;
features_name = {'glcm','ccv','ltp','glcm_ccv','glcm_ltp','ccv_ltp','glcm_ccv_ltp'};

acc_data = zeros(7,6);
X = 10:10:60;

for i=1:7

    train_data = [];
    train_labels = [];
    test_data = [];
    test_labels = [];

    %change to trainsvm for training with svm
    classifier = 'trainsvm';
    
    features = features_name{i};
    train_features = load('Training_Data.mat',features);
    train_features = struct2array(train_features);
    
    classifier = strcat(classifier,'_',features);
    trainer = str2func(classifier);
    
    temp_acc = [];

    num_classes = size(unique(labels));
    
    fprintf('%s\n',features);

    for num=10:10:60
        for class=1:num_classes
            idx = find(labels==class);
            train_idx = idx(1:num);
            temp_data = train_features(train_idx,:);
            train_data = [train_data; temp_data];
            train_labels = [train_labels; labels(train_idx)];
            test_idx = idx(num-9:num);
            test_idx = test_idx + 10;
            temp_data = train_features(test_idx,:);
            test_data = [test_data; temp_data];
            test_labels = [test_labels; labels(test_idx)];
        end
        trainingData = [train_data train_labels];
        %For plotting grpah of fineknn
        %[trainedClassifier, validationAccuracy] = trainer(trainingData,1,'Euclidean','Equal');
        
        %For plotting grpah of cosineknn
        %[trainedClassifier, validationAccuracy] = trainer(trainingData,10,'Cosine','Equal');
        
        %For plotting grpah of weightedknn
        %[trainedClassifier, validationAccuracy] = trainer(trainingData,3,'Cityblock','SquaredInverse');
        
        %For plotting grpah of svm
        [trainedClassifier, validationAccuracy] = trainer(trainingData);
        
        predicted_labels = trainedClassifier.predictFcn(test_data);

        accuracy = sum(test_labels == predicted_labels) / numel(test_labels);
        accuracyPercentage = 100*accuracy;
        temp_acc = [temp_acc; accuracyPercentage];
        fprintf('%f\n',accuracyPercentage);
        %fprintf('%f\n',validationAccuracy);
    end
    
    acc_data(i,:) = temp_acc;
end

plotGraph(X, acc_data);

