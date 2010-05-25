function varargout = eventgui(varargin)
% EVENTGUI M-file for eventgui.fig
%      EVENTGUI, by itself, creates a new EVENTGUI or raises the existing
%      singleton*.
%
%      H = EVENTGUI returns the handle to a new EVENTGUI or the handle to
%      the existing singleton*.
%
%      EVENTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EVENTGUI.M with the given input arguments.
%
%      EVENTGUI('Property','Value',...) creates a new EVENTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eventgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eventgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eventgui

% Last Modified by GUIDE v2.5 11-Mar-2009 18:48:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eventgui_OpeningFcn, ...
                   'gui_OutputFcn',  @eventgui_OutputFcn, ...
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


% --- Executes just before eventgui is made visible.
function eventgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eventgui (see VARARGIN)

% Choose default command line output for eventgui
handles.output = hObject;

figure(handles.figure1)
handles.y = str2double(get(handles.ylevel,'String'));
handles.cp = plot(0,handles.y,'.r');
set(handles.cp,'MarkerSize',24);
axis([0 1 0 1]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eventgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eventgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

while 1
  for x=0:0.01:1
    set(handles.cp,'Xdata',x);
    %y = str2double(get(handles.ylevel,'String'));
    chandles = guidata(hObject);
    set(handles.cp,'Ydata',chandles.y);
    pause(0.1)
  end
end

% Update handles structure
guidata(hObject, handles);


function ylevel_Callback(hObject, eventdata, handles)
% hObject    handle to ylevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ylevel as text
%        str2double(get(hObject,'String')) returns contents of ylevel as a double
handles.y = str2double(get(handles.ylevel,'String'));
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ylevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ylevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


