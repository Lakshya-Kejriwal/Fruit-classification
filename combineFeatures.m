glcm_data = load('glcm_data.mat');
ccv_data = load('ccv_data.mat');
ltp_data = load('ltp_data.mat');

train_labels = glcm_data.train_labels;

glcm = glcm_data.glcm;
train_glcm = glcm_data.train_glcm;

ccv = ccv_data.ccv;
train_ccv = ccv_data.train_ccv;

ltp = ltp_data.ltp;
train_ltp = ltp_data.train_ltp;

glcm_ccv = [glcm ccv];
glcm_ltp = [glcm ltp];
ccv_ltp = [ccv ltp];
glcm_ccv_ltp = [glcm_ccv ltp];

train_glcm_ccv = [glcm_ccv train_labels];
train_glcm_ltp = [glcm_ltp train_labels];
train_ccv_ltp = [ccv_ltp train_labels];
train_glcm_ccv_ltp = [glcm_ccv_ltp train_labels];

save Training_Data.mat glcm ccv ltp glcm_ccv glcm_ltp ccv_ltp glcm_ccv_ltp train_glcm train_ccv train_ltp train_glcm_ccv train_glcm_ltp train_ccv_ltp train_glcm_ccv_ltp train_labels;