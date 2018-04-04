function varargout = modal_dimensiones(varargin)
% MODAL_DIMENSIONES MATLAB code for modal_dimensiones.fig
%      MODAL_DIMENSIONES, by itself, creates a new MODAL_DIMENSIONES or raises the existing
%      singleton*.
%
%      H = MODAL_DIMENSIONES returns the handle to a new MODAL_DIMENSIONES or the handle to
%      the existing singleton*.
%
%      MODAL_DIMENSIONES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_DIMENSIONES.M with the given input arguments.
%
%      MODAL_DIMENSIONES('Property','Value',...) creates a new MODAL_DIMENSIONES or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_dimensiones_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_dimensiones_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_dimensiones

% Last Modified by GUIDE v2.5 03-Apr-2018 23:03:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_dimensiones_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_dimensiones_OutputFcn, ...
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

% --- Executes just before modal_dimensiones is made visible.
function modal_dimensiones_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_dimensiones (see VARARGIN)

% Choose default command line output for modal_dimensiones
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_dimensiones wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_dimensiones_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function dimx_Callback(hObject, eventdata, handles)
% hObject    handle to dimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimx as text
%        str2double(get(hObject,'String')) returns contents of dimx as a double


% --- Executes during object creation, after setting all properties.
function dimx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dimy_Callback(hObject, eventdata, handles)
% hObject    handle to dimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimy as text
%        str2double(get(hObject,'String')) returns contents of dimy as a double


% --- Executes during object creation, after setting all properties.
function dimy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dimz_Callback(hObject, eventdata, handles)
% hObject    handle to dimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dimz as text
%        str2double(get(hObject,'String')) returns contents of dimz as a double


% --- Executes during object creation, after setting all properties.
function dimz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(handles.dimx,'value');
handles.output = get(handles.dimy,'value');
handles.output = get(handles.dimz,'value');
disp(get(handles.dimx,'value'));
% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
