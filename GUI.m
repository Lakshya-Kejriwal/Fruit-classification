function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 27-Mar-2017 23:40:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
handles.sliderValue = 2;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Image File');
I = imread([pathname,filename]);
%I = imresize(I,[256,256]);
I2 = imresize(I,[300,400]);
axes(handles.axes1);
imshow(I2);title('Query Image');
handles.imageData = I;
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
seg_img = SegmentImage(handles.imageData,handles.sliderValue);
%seg_img = imresize(seg_img,[256,256]);
I2 = imresize(seg_img,[300,400]);
axes(handles.axes2);
imshow(I2);title('Segmented Image');
handles.seg_img = seg_img;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
k_value = round(get(hObject, 'Value'));
set(hObject, 'Value', k_value);
sliderValue = get(handles.slider1,'Value');
set(handles.text2,'String',num2str(sliderValue));
handles.sliderValue = sliderValue;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ndims(handles.imageData) == 3
   img = rgb2gray(handles.imageData);
end

handles.trainFeatures = [];
feat_name = '';
set(handles.text8,'String','Evaluating...');

if(get(handles.checkbox1,'Value')==1 && get(handles.checkbox2,'Value')==0 && get(handles.checkbox3,'Value')==0)
    GLCM = graycomatrix(img); 
    stats = graycoprops(GLCM, 'all');
    features = struct2array(stats);
    handles.trainFeatures = features;
    feat_name = 'GLCM';
elseif(get(handles.checkbox1,'Value')==0 && get(handles.checkbox2,'Value')==1 && get(handles.checkbox3,'Value')==0)
    CCV = getCCV(handles.imageData); 
    features = reshape(CCV.',1,[]);
    handles.trainFeatures = features;
    feat_name = 'CCV';    
elseif(get(handles.checkbox1,'Value')==0 && get(handles.checkbox2,'Value')==0 && get(handles.checkbox3,'Value')==1)
    thresh = 255*graythresh(handles.seg_img);
    [ltp_upper, ltp_lower] = getLTP(img,thresh);
    hist = histogram(ltp_upper(:),255);
    high = hist.Values;
    hist = histogram(ltp_lower(:),255);
    lower = hist.Values;
    features = [high lower];
    handles.trainFeatures = features;
    feat_name = 'LTP';
elseif(get(handles.checkbox1,'Value')==1 && get(handles.checkbox2,'Value')==1 && get(handles.checkbox3,'Value')==0)
    GLCM = graycomatrix(img); 
    stats = graycoprops(GLCM, 'all');
    features1 = struct2array(stats);
    CCV = getCCV(handles.imageData); 
    features2 = reshape(CCV.',1,[]);
    handles.trainFeatures = [features1 features2];
    feat_name = 'GLCM+CCV';
elseif(get(handles.checkbox1,'Value')==1 && get(handles.checkbox2,'Value')==0 && get(handles.checkbox3,'Value')==1)
    GLCM = graycomatrix(img); 
    stats = graycoprops(GLCM, 'all');
    features1 = struct2array(stats);
    thresh = 255*graythresh(handles.seg_img);
    [ltp_upper, ltp_lower] = getLTP(img, thresh);
    hist = histogram(ltp_upper(:),255);
    high = hist.Values;
    hist = histogram(ltp_lower(:),255);
    lower = hist.Values;
    features2 = [high lower];
    handles.trainFeatures = [features1 features2];
    feat_name = 'GLCM+LTP';
elseif(get(handles.checkbox1,'Value')==0 && get(handles.checkbox2,'Value')==1 && get(handles.checkbox3,'Value')==1)
    CCV = getCCV(handles.seg_img); 
    features1 = reshape(CCV.',1,[]);
    thresh = 255*graythresh(handles.seg_img);
    [ltp_upper, ltp_lower] = getLTP(img, thresh);
    hist = histogram(ltp_upper(:),255);
    high = hist.Values;
    hist = histogram(ltp_lower(:),255);
    lower = hist.Values;
    features2 = [high lower];
    handles.trainFeatures = [features1 features2];
    feat_name = 'CCV+LTP';
elseif(get(handles.checkbox1,'Value')==1 && get(handles.checkbox2,'Value')==1 && get(handles.checkbox3,'Value')==1)
    GLCM = graycomatrix(img); 
    stats = graycoprops(GLCM, 'all');
    features1 = struct2array(stats);
    CCV = getCCV(handles.seg_img); 
    features2 = reshape(CCV.',1,[]);
    thresh = 255*graythresh(handles.seg_img);
    [ltp_upper, ltp_lower] = getLTP(img, thresh);
    hist = histogram(ltp_upper(:),255);
    high = hist.Values;
    hist = histogram(ltp_lower(:),255);
    lower = hist.Values;
    features3 = [high lower];    
    handles.trainFeatures = [features1 features2 features3];
    feat_name = 'GLCM+CCV+LTP';
end
seg_img = imresize(handles.seg_img,[256,256]);
I2 = imresize(seg_img,[300,400]);
axes(handles.axes2);
imshow(I2);title('Segmented Image');
set(handles.text8,'String',feat_name);
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDA)
set(handles.text11,'String','Processing');
drawnow();

features = get(handles.text8,'String');
features = lower(features);
features = strrep(features,'+','_');

data = load('Training_Data.mat',features);
labels = load('Training_Data.mat','train_labels');
mapObj = load('MAP.mat','mapObj');
%classifier = load('classifier.mat','trainedClassifier');

data = struct2array(data);
labels = struct2array(labels);
mapObj = struct2array(mapObj);

training_data = [data labels];

radio_btn = get(handles.uibuttongroup1,'SelectedObject');
classifier = get(radio_btn, 'String');

if(strcmp(classifier,'Fine KNN'))
    func = strcat('trainknn','_',features);
    trainer = str2func(func);
    model = trainer(training_data,1,'Euclidean','Equal');
    class = model.predictFcn(handles.trainFeatures);
elseif(strcmp(classifier,'Cosine KNN'))
    func = strcat('trainknn','_',features);
    trainer = str2func(func);
    model = trainer(training_data,10,'Cosine','Equal');
    class = model.predictFcn(handles.trainFeatures);
elseif(strcmp(classifier,'Weighted KNN'))
    func = strcat('trainknn','_',features);
    trainer = str2func(func);
    model = trainer(training_data,3,'Cityblock','SquaredInverse');
    class = model.predictFcn(handles.trainFeatures);
elseif(strcmp(classifier,'SVM'))
    func = strcat('trainsvm','_',features);
    trainer = str2func(func);
    model = trainer(training_data);
    class = model.predictFcn(handles.trainFeatures);
end

%class = classifier.trainedClassifier.predictFcn(handles.trainFeatures);
name = mapObj(class);

set(handles.text11,'String',name);


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
radio_btn = get(handles.uibuttongroup1,'SelectedObject');
classifier = get(radio_btn, 'String');
set(handles.text10,'String',classifier);
