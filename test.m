function varargout = test(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

[filename1, pathname1] = uigetfile('*.bmp', 'Choose a carrier image');
global pathfile1;
global pathfre;
pathfile1=fullfile(pathname1, filename1);
pathfre = pathname1;
img=imread(pathfile1);
axes(handles.axes1);
image(img);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

[filename2, pathname2] = uigetfile('*.bmp', 'Choose a watermark image');
global pathfile2;
pathfile2=fullfile(pathname2, filename2);
img=imread(pathfile2);
axes(handles.axes2);
image(img);

%Watermark scrambling
function pushbutton6_Callback(hObject, eventdata, handles)
global pathfile2;
%global pathfile6;
global pathfre;
img = Arnold1(pathfile2);
%pathfile6=fullfile(pathfre, 'randwater.bmp');
pathfile2=fullfile(pathfre,'randwater.bmp');
imwrite(img,pathfile2);
axes(handles.axes2);
imshow(img);

%Watermark embedding
function pushbutton3_Callback(hObject, eventdata, handles)
global pathfile1;
global pathfile2;
global k1;
global k2;
img = dct(pathfile1,pathfile2,k1,k2);
axes(handles.axes3);
image(img);


%Watermark attack
function popupmenu2_Callback(hObject, eventdata, handles)
global pathfile3;
global pathfre;
var=get(handles.popupmenu2,'value');
axes(handles.axes4);

switch var
    case 1
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'No attack_DCT.bmp')); 
    case 2
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'WhiteNoise_attack_DCT.bmp')); 
    case 3
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Partial_cut_DCT.bmp')); 
    case 4
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Wavelet_compression_DCT.bmp')); 
    case 5
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Geometric_rotation_DCT.bmp')); 
    case 6
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Sobel_sharpen_DWT.bmp')); 
    case 7
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Gaussian_blur_DWT.bmp')); 
end
img = after_attack;
global pathfile5;
pathfile5=fullfile(pathfre, 'after_attack_DCT.bmp');
imwrite(after_attack,pathfile5);
axes(handles.axes4);
imshow(img)

%Watermark extraction
function pushbutton5_Callback(hObject, eventdata, handles)
global pathfile4;
global pathfile5;
global k1;
global k2;
idct(pathfile5,k1,k2);
img = imread(pathfile4);
axes(handles.axes5);
imshow(img)

%Watermark restoration
function pushbutton7_Callback(hObject, eventdata, handles)

global pathfile4;
global pathfre;
tmppath = fullfile(pathfre,'realmark.bmp');
img = Arnold2(pathfile4);
imwrite(img,tmppath);
axes(handles.axes5);
imshow(img);

function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu2_DeleteFcn(hObject, eventdata, handles)




%%%%%%%%%%%%%%%%gy

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathfile1;
global pathfile2;
img = dwt(pathfile1,pathfile2);
axes(handles.axes3);
image(img);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathfile4;
global pathfile3;
global pathfile2;
global pathfile1;

idwt(pathfile1,pathfile2,pathfile3);
img = imread(pathfile4);
axes(handles.axes5);
imshow(img)


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
global pathfile3;
global pathfre;
var=get(handles.popupmenu4,'value');
axes(handles.axes4);

switch var
    case 1
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'No attack_DWT.bmp')); 
    case 2
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'WhiteNoise_attack_DWT.bmp')); 
    case 3
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Partial_cut_DWT.bmp')); 
    case 4
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Wavelet_compression_DWT.bmp')); 
    case 5
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Geometric_rotation_DWT.bmp')); 
    case 6
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Sobel_sharpen_DWT.bmp')); 
    case 7
        after_attack = attack(var,pathfile3);
        imwrite(after_attack,fullfile(pathfre,'Gaussian_blur_DWT.bmp')); 
end
img = after_attack;
global pathfile5;
pathfile5=fullfile(pathfre, 'after_attack_DWT.bmp');
imwrite(after_attack,pathfile5);
axes(handles.axes4);
imshow(img)

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
