function varargout = redDotWorks(varargin)
% REDDOTWORKS M-file for redDotWorks.fig
%      REDDOTWORKS, by itself, creates a new REDDOTWORKS or raises the existing
%      singleton*.
%
%      H = REDDOTWORKS returns the handle to a new REDDOTWORKS or the handle to
%      the existing singleton*.
%
%      REDDOTWORKS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REDDOTWORKS.M with the given input arguments.
%
%      REDDOTWORKS('Property','Value',...) creates a new REDDOTWORKS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before redDotWorks_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to redDotWorks_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help redDotWorks

% Last Modified by GUIDE v2.5 14-Mar-2009 18:21:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @redDotWorks_OpeningFcn, ...
                   'gui_OutputFcn',  @redDotWorks_OutputFcn, ...
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


% --- Executes just before redDotWorks is made visible.
function redDotWorks_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to redDotWorks (see VARARGIN)

% Choose default command line output for redDotWorks
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes redDotWorks wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = redDotWorks_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the y input and store it as handles.y
handles.y = str2double(get(handles.yInput,'String'));
% set the plot axes
axes(handles.redDotGraph);
% plot the red dot and save its handle as handles.redDot
handles.redDot = plot(0,handles.y,'.r');
% make the marker a bit bigger
set(handles.redDot,'MarkerSize',24);
% fix the axes sizes and box the figure
axis([0 1 0 1]);
box on
% update the handles
guidata(hObject,handles);
% continously animate the x location of the dot
while 1
  for x=0:0.01:1
    % update the x position  
    set(handles.redDot,'Xdata',x);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%SOLUTION 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % grab the current handles in case it has changed
    chandles = guidata(handles.figure1);
    % update the y position
    set(handles.redDot,'Ydata',chandles.y);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%SOLUTION 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % update the y position
%     set(handles.redDot,'Ydata',str2double(get(handles.yInput,'String')));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % wait a little bit before the next plot
    pause(0.1)
  end
end

function yInput_Callback(hObject, eventdata, handles)
% hObject    handle to yInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yInput as text
%        str2double(get(hObject,'String')) returns contents of yInput as a double

% store the new y value
handles.y = str2double(get(hObject,'String'));
% update the handles
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function yInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


