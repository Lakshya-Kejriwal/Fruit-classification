# Fruit-classification

This is general machine learning application for classifiying different fruits. 

### Classifiers used

Experimented with the following classifiers:

- SVM
- K-nearest neighbours

### Features Used

The following features are used:

-GLCM
-CCV
-LTP

### Prerequisites

- Matlab R2017a

### Instructions

-Open the `save_segment_images.m` file and the change the `train_folder` to give the full path of the folder containing the training images.

-Run the `save_segment_images.m` file which will save all the segmented images in a separate folder that can be used later. (Note: You can change the value of k for k-means segmentation on line 14)

-In order to evaluate the features on segmented images run the `EvaluateGLCMFeatures.m`, `EvaluateCCVFeatures.m` and `EvaluateLTPFeatures.m` files.

-Run `combineFeatures.m` file to generate different combination of Image features.

-All the features data will be saved in `Training_Data.mat` that can be used later. (Note: You can use the data inside this mat file for detailed classification using the Classification Toolbox by importing different features data)

-Open `plotData.m` file and change the classifier to trainknn for knn classifier and trainsvm for svm classifier. Also, uncomment one line from 47-57 according to the classifier you wish to plot the data for.
