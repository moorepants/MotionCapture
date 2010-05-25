function varargout = PCAgui(varargin)
% PCAGUI M-file for PCAgui.fig
%      PCAGUI, by itself, creates a new PCAGUI or raises the existing
%      singleton*.
%
%      H = PCAGUI returns the handle to a new PCAGUI or the handle to
%      the existing singleton*.
%
%      PCAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCAGUI.M with the given input arguments.
%
%      PCAGUI('Property','Value',...) creates a new PCAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCAgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCAgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCAgui

% Last Modified by GUIDE v2.5 22-Mar-2009 20:06:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCAgui_OpeningFcn, ...
                   'gui_OutputFcn',  @PCAgui_OutputFcn, ...
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


%% Open Functions
% --- Executes just before PCAgui is made visible.
function PCAgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCAgui (see VARARGIN)
handles.output = hObject;
%define playbackrate 
handles.playbackrate=[1/100    1/20    1/10   1/5    1   3/2        2    4      8     64  ;...
                       1        1        1     1     1    1         2    4      8     64  ;...
                       1       1/5     1/10  1/50  1/100 (1.5)/100 1/100 1/100 1/100 1/100;...
                       1        2       3      4     5    6         7    8      9     10  ];
%set playback rate to 1
set(handles.playBack_edit,'String',num2str(handles.playbackrate(1,5)));
%set rate
set(handles.plus_pushbutton,'UserData',handles.playbackrate(:,5));
set(handles.playBack_edit,'String',1);
%set playing forward!
set(handles.forward_radiobutton,'UserData',1);
set(handles.playBack_edit,'Enable','on');
set(handles.plus_pushbutton,'Enable','on');
set(handles.minus,'Enable','on');
%LDisableControls
set(handles.Li_slider,'Enable','off');
set(handles.Li_slider,'UserData',0);
set(handles.LframeNr_edit,'Enable','off');
%disable PCA components:
set(handles.Rcheckbox1,'Enable','off');
set(handles.Rcheckbox2,'Enable','off');
set(handles.Rcheckbox3,'Enable','off');
set(handles.Rcheckbox4,'Enable','off');
set(handles.Rcheckbox5,'Enable','off');
set(handles.Rcheckbox6,'Enable','off');
set(handles.Rcheckbox7,'Enable','off');
set(handles.Rcheckbox8,'Enable','off');
set(handles.Rcheckbox9,'Enable','off');
set(handles.Rcheckbox10,'Enable','off');
set(handles.Lcheckbox1,'Enable','off');
set(handles.Lcheckbox2,'Enable','off');
set(handles.Lcheckbox3,'Enable','off');
set(handles.Lcheckbox4,'Enable','off');
set(handles.Lcheckbox5,'Enable','off');
set(handles.Lcheckbox6,'Enable','off');
set(handles.Lcheckbox7,'Enable','off');
set(handles.Lcheckbox8,'Enable','off');
set(handles.Lcheckbox9,'Enable','off');
set(handles.Lcheckbox10,'Enable','off');
%DisableControls
set(handles.i_slider,'Enable','off');
set(handles.i_slider,'UserData',0);
set(handles.frameNr_edit,'Enable','off');
%set display
set(handles.both_pushbutton,'UserData',0)
set(handles.rider_pushbutton,'UserData',1)
set(handles.bicycle_pushbutton,'UserData',0)

%et(hObject,'toolbar','figure');
%Update (hObject and handles)
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = PCAgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function playBack_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playBack_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% RIGHT SIDE 

% --- Executes during object creation, after setting all properties.
function FileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function frameNr_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameNr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% LEFT SIDE 

% --- Executes during object creation, after setting all properties.
function Li_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Li_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function LframeNr_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LframeNr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function LFileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Viewing Pannel

% --- Executes on button press in minus.
function minus_Callback(hObject, eventdata, handles)
% hObject    handle to minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rate=get(handles.plus_pushbutton,'UserData');
rate=handles.playbackrate(:,(rate(4)-1));
set(handles.plus_pushbutton,'UserData',rate);
set(handles.playBack_edit,'String',num2str(rate(1)));
guidata(hObject, handles);

% --- Executes on button press in plus_pushbutton.
function plus_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plus_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rate=get(handles.plus_pushbutton,'UserData');
rate=handles.playbackrate(:,(rate(4)+1));
set(handles.plus_pushbutton,'UserData',rate);
set(handles.playBack_edit,'String',num2str(rate(1)));
guidata(hObject, handles);

function playBack_edit_Callback(hObject, eventdata, handles)
% hObject    handle to playBack_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plus_pushbutton,'UserData',str2double(get(hObject,'String')));
guidata(hObject, handles);

% --- Executes on button press in Repeat_radiobutton.
function Repeat_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to Repeat_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in bicycle_pushbutton.
function bicycle_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bicycle_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.bicycle_pushbutton,'UserData',1);
set(handles.rider_pushbutton,'UserData',0);
set(handles.both_pushbutton,'UserData',0);
if get(handles.i_slider,'UserData')==1                                      %is data loaded?
    cla(handles.PCA_axes)
    [m n]=size(handles.ABike);
    if get(handles.i_slider,'Value') >= n;
        set(handles.i_slider,'Value',n);
    end
    set(handles.i_slider,'Min',1);
    set(handles.i_slider,'Max',n);
    set(handles.i_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.frameNr_edit,'String',num2str(get(handles.i_slider,'Value')));
    axes(handles.PCA_axes);
    [handles]=firstplot(hObject,handles,1);
end   
if get(handles.Li_slider,'UserData')==1;
    cla(handles.LPCA_axes)
    [m n]=size(handles.LABike);
    if get(handles.Li_slider,'Value') >= n;
        set(handles.Li_slider,'Value',n);
    end
    set(handles.Li_slider,'Min',1);
    set(handles.Li_slider,'Max',n);
    set(handles.Li_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.LframeNr_edit,'String',num2str(get(handles.Li_slider,'Value')));
    axes(handles.LPCA_axes);
    [handles]=firstplot(hObject,handles, 2);
end    
guidata(hObject, handles);

% --- Executes on button press in rider_pushbutton.
function rider_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rider_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.rider_pushbutton,'UserData',1)
set(handles.bicycle_pushbutton,'UserData',0)
set(handles.both_pushbutton,'UserData',0)
if get(handles.i_slider,'UserData')==1 
    cla(handles.PCA_axes)
    [m n]=size(handles.ARider);
    if get(handles.i_slider,'Value') >= n;
        set(handles.i_slider,'Value',n);
    end
    set(handles.i_slider,'Min',1);
    set(handles.i_slider,'Max',n);
    set(handles.i_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.frameNr_edit,'String',num2str(get(handles.i_slider,'Value')));
    axes(handles.PCA_axes);
    [handles]=firstplot(hObject,handles, 1);
end
if get(handles.Li_slider,'UserData')==1;
    cla(handles.LPCA_axes)
    [m n]=size(handles.LARider);
    if get(handles.Li_slider,'Value') >= n;
        set(handles.Li_slider,'Value',n);
    end
    set(handles.Li_slider,'Min',1);
    set(handles.Li_slider,'Max',n);
    set(handles.Li_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.LframeNr_edit,'String',num2str(get(handles.Li_slider,'Value')));
    axes(handles.LPCA_axes);
    [handles]=firstplot(hObject,handles, 2);
end
guidata(hObject, handles);

% --- Executes on button press in both_pushbutton.
function both_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to both_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.both_pushbutton,'UserData',1)
set(handles.rider_pushbutton,'UserData',0)                                 %other buttons to 0
set(handles.bicycle_pushbutton,'UserData',0)
if get(handles.i_slider,'UserData')==1
    cla(handles.PCA_axes) ;                                                  %clear axes
    [m n]=size(handles.ABikeRider);
    if get(handles.i_slider,'Value') >= n;
        set(handles.i_slider,'Value',n);
    end
    set(handles.i_slider,'Min',1);
    set(handles.i_slider,'Max',n);
    set(handles.i_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.frameNr_edit,'String',num2str(get(handles.i_slider,'Value')));
    axes(handles.PCA_axes);
    [handles]=firstplot(hObject,handles,1);
end
if get(handles.Li_slider,'UserData')==1;
    cla(handles.LPCA_axes)
    [m n]=size(handles.LABikeRider);
    if get(handles.Li_slider,'Value') >= n;
        set(handles.Li_slider,'Value',n);
    end
    set(handles.Li_slider,'Min',1);
    set(handles.Li_slider,'Max',n);
    set(handles.Li_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
    set(handles.LframeNr_edit,'String',num2str(get(handles.Li_slider,'Value')));
    axes(handles.LPCA_axes);
    [handles]=firstplot(hObject,handles, 2);
end
guidata(hObject, handles);

%% Play/Stop Pannel

%Executes on button press in play_button and stop_button.
function animate_callback(hObject, eventdata, handles)
tag = get(hObject,'tag');
% hObject    handle to play_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch tag
    case 'play_button'
        set(handles.stop_button,'UserData',0)
        tic
        %[handles]=firstplot(handles,1)
        while get(handles.stop_button,'UserData')== 0                       %play button on
            rate=get(handles.plus_pushbutton,'UserData');
            t2=toc;
            pause([rate(3)-(t2)]);
            tic
            if get(handles.i_slider,'UserData')== 1                         % is data loaded for PCA_axes
                handles=guidata(hObject);
                if get(handles.both_pushbutton,'UserData')==1
                    [o n]=size(handles.ABikeRider);
                elseif get(handles.rider_pushbutton,'UserData')==1
                    [o n]=size(handles.ARider);
                else [o n]=size(handles.ABike);
                end    
                handles=guidata(hObject);                
                timeplot(hObject,handles,1)
                handles=guidata(hObject);
                %right slider update for next motion
                rightslidervalue=get(handles.i_slider,'Value')+(get(handles.forward_radiobutton,'Value')-get(handles.backward_radiobutton,'Value'))*rate(2);   % update slider
                if rightslidervalue<=1;
                    if get(handles.Repeat_radiobutton,'Value')== get(handles.Repeat_radiobutton,'Max')
                        set(handles.frameNr_edit,'String',n);
                        set(handles.i_slider,'Value',n);
                    else
                        set(handles.frameNr_edit,'String',1);
                        set(handles.i_slider,'Value',1);
                    end                
                elseif rightslidervalue>=n;
                    if get(handles.Repeat_radiobutton,'Value')== get(handles.Repeat_radiobutton,'Max')
                        set(handles.frameNr_edit,'String',1);
                        set(handles.i_slider,'Value',1);
                    else
                        set(handles.frameNr_edit,'String',n);
                        set(handles.i_slider,'Value',n);
                    end
                else
                    set(handles.i_slider,'Value',rightslidervalue);
                    set(handles.frameNr_edit,'String',rightslidervalue); 	% update slider_text
                end   
            end            
            if get(handles.Li_slider,'UserData')== 1                        % is data loaded for LPCA_axes
                handles=guidata(hObject);
                if get(handles.both_pushbutton,'UserData')==1
                    [p m]=size(handles.LABikeRider);
                elseif get(handles.rider_pushbutton,'UserData')==1
                    [p m]=size(handles.LARider);
                else [p m]=size(handles.LABike);
                end  
                handles=guidata(hObject);                
                timeplot(hObject,handles,2)
                guidata(hObject, handles);
                %Left slider updatefor next motion
                leftslidervalue= get(handles.Li_slider,'Value')+(get(handles.forward_radiobutton,'Value')-get(handles.backward_radiobutton,'Value'))*rate(2);
                if leftslidervalue <=1;
                    if get(handles.Repeat_radiobutton,'Value')== get(handles.Repeat_radiobutton,'Max')
                        set(handles.LframeNr_edit,'String',m);
                        set(handles.Li_slider,'Value',m);
                    else
                        set(handles.LframeNr_edit,'String',1);
                        set(handles.Li_slider,'Value',1);
                    end
                elseif leftslidervalue >=m;
                    if get(handles.Repeat_radiobutton,'Value')== get(handles.Repeat_radiobutton,'Max')
                        set(handles.LframeNr_edit,'String',1);
                        set(handles.Li_slider,'Value',1);
                    else
                        set(handles.LframeNr_edit,'String',m);
                        set(handles.Li_slider,'Value',m);
                    end
                else
                    set(handles.Li_slider,'Value',leftslidervalue);
                    set(handles.LframeNr_edit,'String',leftslidervalue);  % update slider_text
                end
            end
            %update everything
            guidata(hObject,handles);
        end

    case 'stop_button'
        set(handles.stop_button,'UserData',1);
        guidata(hObject,handles);
end




%% Right Hand Side 

%% Right Control_Pannel

% --- Executes on slider movement.
function i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider= get(handles.i_slider,'Value');
set(handles.i_slider,'Value',round(slider));
set(handles.frameNr_edit,'String',num2str(get(hObject,'Value')));
guidata(hObject, handles);

function frameNr_edit_Callback(hObject, eventdata, handles)
% hObject    handle to frameNr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.i_slider,'Value',str2double(get(hObject,'String')));
guidata(hObject, handles);

%% Right Files Pannel

% --- Executes on button press in addFile_pushbutton.
function addFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[input_file,pathname] = uigetfile( ...
       {'*.mat', 'Mat Files (*.mat)'; ...
        '*.*', 'All Files (*.*)'}, ...
        'Select files', ... 
        'MultiSelect', 'on');

% if file selection is cancelled, pathname should be zero
% and nothing should happen
if pathname == 0
    return
end
% gets the current data file names inside the listbox
inputFileNames = get(handles.FileListBox,'String');
%if they only select one file, then the data will not be a cell
if iscell(input_file) == 0
    %add the most recent data file selected to the cell containing
    %all the data file names
    inputFileNames{length(inputFileNames)+1} = ...
        fullfile(pathname,input_file);
% else, data will be in cell format
else
    % stores full file path into inputFileNames
    for n = 1:length(input_file)
        inputFileNames{length(inputFileNames)+1} = fullfile(pathname,input_file{n});
    end
end
% updates the gui to display all filenames in the listbox
set(handles.FileListBox,'String',inputFileNames);
% make sure first file is always selected so it doesn't go out of range
% the GUI will break if this value is out of range
set(handles.FileListBox,'Value',1);
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in loadData_pushbutton.
function loadData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% hhandles    structure with handles and user data (see GUIDATA)
% get the selected file from the listbox
inputFileName = get(handles.FileListBox,'String');
selectionNumber = get(handles.FileListBox,'Value');
% if no files are selected then nothing happens
if isempty(inputFileName)
    return
end 
% disables the button while data is processing
DisableButtons(handles);
DisableControls(handles);
% wipe the GUI clean
ClearData(hObject,handles);
% refresh the figure to reflect changes
%refresh(PCAgui); 
% gets the filename and the extension
[path,fileName,ext,ignore]=fileparts(inputFileName{selectionNumber});
%loads data into handles structure
load(inputFileName{selectionNumber})
handles.x=xn;
handles.y=yn;
handles.z=zn;
handles.xb=xb;
handles.yb=yb;
handles.zb=zb;
handles.t=t;
handles.V=V;
handles.rr=rr;
handles.rf=rf;
handles.uBikeRider=uBikeRider;
handles.uBike=uBike;
handles.uRider=uRider;
handles.bike=bike;
handles.Gearing=gearing;
handles.condition=condition;
handles.ARider=ARider;
handles.vRider=vRider;
handles.URider=uRider;
handles.ABike=ABike;
handles.vBike=vBike;
handles.uBike=uBike;
handles.ABikeRider=ABikeRider;
handles.vBikeRider=vBikeRider;
handles.uBikeRider=uBikeRider;
handles.gBikeRider=gBikeRider;
handles.gBike=gBike;
handles.gRider=gRider;
    %which rider?
nr=(textscan(fileName,'%d',1)); 
if nr{1} >=3000 
    handles.rider=('Jason');
elseif nr{1}>=2000 
    handles.rider=('Victor');
else handles.rider=('Jodi');
end
SetExperimentData(hObject,handles);
set(handles.Rcheckbox1,'Enable','on')
set(handles.Rcheckbox2,'Enable','on')
set(handles.Rcheckbox3,'Enable','on')
set(handles.Rcheckbox4,'Enable','on')
set(handles.Rcheckbox5,'Enable','on')
set(handles.Rcheckbox6,'Enable','on')
set(handles.Rcheckbox7,'Enable','on')
set(handles.Rcheckbox8,'Enable','on')
set(handles.Rcheckbox9,'Enable','on')
set(handles.Rcheckbox10,'Enable','on')
%set slider
if get(handles.bicycle_pushbutton,'UserData')==1
    [m n]=size(ABike);
elseif get(handles.rider_pushbutton,'UserData')==1
    [m n]=size(ARider);
else [m n]=size(ABikeRider);
end
set(handles.i_slider,'Min',1);
set(handles.i_slider,'Max',n);
set(handles.i_slider,'Value',1);
set(handles.i_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
set(handles.frameNr_edit,'String',num2str(get(handles.i_slider,'Value')));
%fill figures
axes(handles.PCA_axes);
cla(handles.PCA_axes,'reset');
[handles]=firstplot(hObject,handles, 1);
% data is done processing, so re-enable the buttons
EnableButtons(handles);
EnableControls(handles);
guidata(hObject, handles);


% --- Executes on button press in deleteFile_pushbutton.
function deleteFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputFileNames = get(handles.FileListBox,'String');
%get the values for the selected file names
option = get(handles.FileListBox,'Value');
%is there is nothing to delete, nothing happens
if (isempty(option) == 1 || option(1) == 0 )
    return
end
 
%erases the contents of highlighted item in data array
inputFileNames(option) = [];
 
%updates the gui, erasing the selected item from the listbox
set(handles.FileListBox,'String',inputFileNames);
 
%moves the highlighted item to an appropiate value or else will get error
if option(end) > length(inputFileNames)
    set(handles.FileListBox,'Value',length(inputFileNames));
end
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in clearData_pushbutton.
function clearData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clearData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DisableControls(handles); % disables the inputs
ClearData(hObject,handles); % calls the ClearData m-file
% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in FileListBox.
function FileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Right Functions

function DisableControls(handles)
set(handles.i_slider,'Enable','off');
set(handles.i_slider,'UserData',0);
set(handles.frameNr_edit,'Enable','off');

function EnableControls(handles)
set(handles.i_slider,'Enable','on');
set(handles.i_slider,'UserData',1);
set(handles.frameNr_edit,'Enable','on');

function DisableButtons(handles)
set(handles.addFile_pushbutton,'Enable','off');
set(handles.loadData_pushbutton,'Enable','off');
set(handles.clearData_pushbutton,'Enable','off');
set(handles.deleteFile_pushbutton,'Enable','off');

function EnableButtons(handles)
set(handles.addFile_pushbutton,'Enable','on');
set(handles.loadData_pushbutton,'Enable','on');
set(handles.clearData_pushbutton,'Enable','on');
set(handles.deleteFile_pushbutton,'Enable','on');

% Resest the GUI to original settings
function ClearData(hObject,handles)
% erase the data
handles.x = {};
handles.y = {};
handles.z = {};
handles.V={};
handles.bike={};
handles.Gearing={};
handles.condition={};
handles.rider= {};
handles.gBikeRider=[0;0;0;0;0;0;0;0;0;0];
handles.gBike=[0;0;0;0;0;0;0;0;0;0];
handles.gRider=[0;0;0;0;0;0;0;0;0;0];
SetExperimentData(hObject,handles);
set(handles.Rcheckbox1,'Value',1,'Enable','off');
set(handles.Rcheckbox2,'Value',1,'Enable','off');
set(handles.Rcheckbox3,'Value',1,'Enable','off');
set(handles.Rcheckbox4,'Value',1,'Enable','off');
set(handles.Rcheckbox5,'Value',1,'Enable','off');
set(handles.Rcheckbox6,'Value',1,'Enable','off');
set(handles.Rcheckbox7,'Value',1,'Enable','off');
set(handles.Rcheckbox8,'Value',1,'Enable','off');
set(handles.Rcheckbox9,'Value',1,'Enable','off');
set(handles.Rcheckbox10,'Value',1,'Enable','off');
% clear all the graphs
cla(handles.PCA_axes,  'reset');
guidata(hObject, handles);

function SetExperimentData(hObject,handles)
set(handles.Rider_text,'String',handles.rider)
set(handles.Experiment_text,'String',handles.condition)
set(handles.Bicycle_text,'String',handles.bike)
set(handles.Gear_text,'String',handles.Gearing);
set(handles.Speed_text,'String',handles.V);
set(handles.playBack_edit,'String',num2str(handles.playbackrate(1,5)));
if(get(handles.both_pushbutton,'UserData')==1)
    g1=handles.gBikeRider;
elseif get(handles.bicycle_pushbutton,'UserData')==1
    g1=handles.gBike;
else g1=handles.gRider;
end
set(handles.R1_text,'String',(g1(1)));
set(handles.R2_text,'String',(g1(2)));
set(handles.R3_text,'String',(g1(3)));
set(handles.R4_text,'String',(g1(4)));
set(handles.R5_text,'String',(g1(5)));
set(handles.R6_text,'String',(g1(6)));
set(handles.R7_text,'String',(g1(7)));
set(handles.R8_text,'String',(g1(8)));
set(handles.R9_text,'String',(g1(9)));
set(handles.R10_text,'String',(g1(10)));
guidata(hObject, handles);


%% links op het scherm

%% Left Control Pannel

% --- Executes on slider movement.
function Li_slider_Callback(hObject, eventdata, handles)
% hObject    handle to i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider= get(handles.Li_slider,'Value');
set(handles.Li_slider,'Value',round(slider));
set(handles.LframeNr_edit,'String',num2str(get(hObject,'Value')));
guidata(hObject, handles);

function LframeNr_edit_Callback(hObject, eventdata, handles)
% hObject    handle to frameNr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Li_slider,'Value',str2double(get(hObject,'String')));
guidata(hObject, handles);

%% Left Files Panel

% --- Executes on button press in addFile_pushbutton.
function LaddFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[input_file,pathname] = uigetfile( ...
       {'*.mat', 'Mat Files (*.mat)'; ...
        '*.*', 'All Files (*.*)'}, ...
        'Select files', ... 
        'MultiSelect', 'on');

% if file selection is cancelled, pathname should be zero
% and nothing should happen
if pathname == 0
    return
end
% gets the current data file names inside the listbox
inputFileNames = get(handles.LFileListBox,'String');
%if they only select one file, then the data will not be a cell
if iscell(input_file) == 0
    %add the most recent data file selected to the cell containing
    %all the data file names
    inputFileNames{length(inputFileNames)+1} = ...
        fullfile(pathname,input_file);
% else, data will be in cell format
else
    % stores full file path into inputFileNames
    for n = 1:length(input_file)
        inputFileNames{length(inputFileNames)+1} = fullfile(pathname,input_file{n});
    end
end
% updates the gui to display all filenames in the listbox
set(handles.LFileListBox,'String',inputFileNames);
% make sure first file is always selected so it doesn't go out of range
% the GUI will break if this value is out of range
set(handles.LFileListBox,'Value',1);
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in loadData_pushbutton.
function LloadData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% hhandles    structure with handles and user data (see GUIDATA)
% get the selected file from the listbox
inputFileName = get(handles.LFileListBox,'String');
selectionNumber = get(handles.LFileListBox,'Value');
% if no files are selected then nothing happens
if isempty(inputFileName)
    return
end 
% disables the button while data is processing
LDisableButtons(handles);
LDisableControls(handles);
% wipe the GUI clean
LClearData(hObject,handles);
% refresh the figure to reflect changes
%refresh(PCAgui4); 
% gets the filename and the extension
[path,fileName,ext,ignore]=fileparts(inputFileName{selectionNumber});
%loads data into handles structure
load(inputFileName{selectionNumber})
handles.Lx=xn;
handles.Ly=yn;
handles.Lz=zn;
handles.Lxb=xb;
handles.Lyb=yb;
handles.Lzb=zb;
handles.Lt=t;
handles.LV=V;
handles.Lrr=rr;
handles.Lrf=rf;
handles.LuBikeRider=uBikeRider;
handles.LuBike=uBike;
handles.LuRider=uRider;
handles.Lbike=bike;
handles.LGearing=gearing;
handles.Lcondition=condition;
handles.LARider=ARider;
handles.LvRider=vRider;
handles.LURider=uRider;
handles.LABike=ABike;
handles.LvBike=vBike;
handles.LuBike=uBike;
handles.LABikeRider=ABikeRider;
handles.LvBikeRider=vBikeRider;
handles.LuBikeRider=uBikeRider;
handles.LgBikeRider=gBikeRider;
handles.LgBike=gBike;
handles.LgRider=gRider;
    %which rider?
nr=(textscan(fileName,'%d',1)); 
if nr{1} >=3000 
    handles.Lrider=('Jason');
elseif nr{1}>=2000 
    handles.Lrider=('Victor');
else handles.Lrider=('Jodi');
end
LSetExperimentData(hObject,handles);
set(handles.Lcheckbox1,'Enable','on');
set(handles.Lcheckbox2,'Enable','on');
set(handles.Lcheckbox3,'Enable','on');
set(handles.Lcheckbox4,'Enable','on');
set(handles.Lcheckbox5,'Enable','on');
set(handles.Lcheckbox6,'Enable','on');
set(handles.Lcheckbox7,'Enable','on');
set(handles.Lcheckbox8,'Enable','on');
set(handles.Lcheckbox9,'Enable','on');
set(handles.Lcheckbox10,'Enable','on');
%set slider
if get(handles.bicycle_pushbutton,'UserData')==1
    [m n]=size(ABike);
elseif get(handles.rider_pushbutton,'UserData')==1
    [m n]=size(ARider);
else [m n]=size(ABikeRider);
end
set(handles.Li_slider,'Min',1);
set(handles.Li_slider,'Max',n);
set(handles.Li_slider,'Value',1);
set(handles.Li_slider,'SliderStep',[1/(n-1) 10/(n-1)]);
set(handles.LframeNr_edit,'String',num2str(get(handles.Li_slider,'Value')));
%fill figures
axes(handles.LPCA_axes);
cla(handles.LPCA_axes,'reset');
[handles]=firstplot(hObject,handles, 2);
% data is done processing, so re-enable the buttons
LEnableButtons(handles);
LEnableControls(handles);
guidata(hObject, handles);

% --- Executes on button press in deleteFile_pushbutton.
function LdeleteFile_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inputFileNames = get(handles.LFileListBox,'String');
%get the values for the selected file names
option = get(handles.LFileListBox,'Value'); 
%is there is nothing to delete, nothing happens
if (isempty(option) == 1 || option(1) == 0 )
    return
end
%erases the contents of highlighted item in data array
inputFileNames(option) = [];
%updates the gui, erasing the selected item from the listbox
set(handles.LFileListBox,'String',inputFileNames);
%moves the highlighted item to an appropiate value or else will get error
if option(end) > length(inputFileNames)
    set(handles.LFileListBox,'Value',length(inputFileNames));
end
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in LclearData_pushbutton.
function LclearData_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clearData_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LDisableControls(handles); % disables the inputs
LClearData(hObject,handles); % calls the ClearData m-file
% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in LFileListBox.
function LFileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to LFileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Left Functions

function LDisableControls(handles)
set(handles.Li_slider,'Enable','off');
set(handles.Li_slider,'UserData',0);
set(handles.LframeNr_edit,'Enable','off');

function LEnableControls(handles)
set(handles.Li_slider,'Enable','on');
set(handles.Li_slider,'UserData',1);
set(handles.LframeNr_edit,'Enable','on');

function LDisableButtons(handles)
set(handles.LaddFile_pushbutton,'Enable','off');
set(handles.LloadData_pushbutton,'Enable','off');
set(handles.LclearData_pushbutton,'Enable','off');
set(handles.LdeleteFile_pushbutton,'Enable','off');

function LEnableButtons(handles)
%set(handles.figure1,'Pointer','arrow');
set(handles.LaddFile_pushbutton,'Enable','on');
set(handles.LloadData_pushbutton,'Enable','on');
set(handles.LclearData_pushbutton,'Enable','on');
set(handles.LdeleteFile_pushbutton,'Enable','on');

% Resest the GUI to original settings
function LClearData(hObject,handles)
% erase the data
handles.Lx = {};
handles.Ly = {};
handles.Lz = {};
handles.LV={};
handles.Lbike={};
handles.LGearing={};
handles.Lcondition={};
handles.Lrider= {};
handles.LgBikeRider=[0;0;0;0;0;0;0;0;0;0];
handles.LgBike=[0;0;0;0;0;0;0;0;0;0];
handles.LgRider=[0;0;0;0;0;0;0;0;0;0];
LSetExperimentData(hObject,handles);
set(handles.Lcheckbox1,'Value',1,'Enable','off');
set(handles.Lcheckbox2,'Value',1,'Enable','off');
set(handles.Lcheckbox3,'Value',1,'Enable','off');
set(handles.Lcheckbox4,'Value',1,'Enable','off');
set(handles.Lcheckbox5,'Value',1,'Enable','off');
set(handles.Lcheckbox6,'Value',1,'Enable','off');
set(handles.Lcheckbox7,'Value',1,'Enable','off');
set(handles.Lcheckbox8,'Value',1,'Enable','off');
set(handles.Lcheckbox9,'Value',1,'Enable','off');
set(handles.Lcheckbox10,'Value',1,'Enable','off');
% clear all the graphs
cla(handles.LPCA_axes,  'reset');
guidata(hObject, handles);

function LSetExperimentData(hObject,handles)
set(handles.LRider_text,'String',handles.Lrider)
set(handles.LExperiment_text,'String',handles.Lcondition)
set(handles.LBicycle_text,'String',handles.Lbike)
set(handles.LGear_text,'String',handles.LGearing);
set(handles.LSpeed_text,'String',handles.LV);
if(get(handles.both_pushbutton,'UserData')==1)
    g1=handles.LgBikeRider;
elseif get(handles.bicycle_pushbutton,'UserData')==1
    g1=handles.LgBike;
else
    g1=handles.LgRider;
end
set(handles.L1_text,'String',(g1(1)));
set(handles.L2_text,'String',(g1(2)));
set(handles.L3_text,'String',(g1(3)));
set(handles.L4_text,'String',(g1(4)));
set(handles.L5_text,'String',(g1(5)));
set(handles.L6_text,'String',(g1(6)));
set(handles.L7_text,'String',(g1(7)));
set(handles.L8_text,'String',(g1(8)));
set(handles.L9_text,'String',(g1(9)));
set(handles.L10_text,'String',(g1(10)));
guidata(hObject, handles);

%% Plotting 

%function for makeing an initial plot
    function [handles]=firstplot(hObject,handles,nr) %% this function plots the markers and the lines
        %for which axis is the data required?
        if nr==1
            c=[ get(handles.Rcheckbox1,'Value');
                get(handles.Rcheckbox2,'Value');
                get(handles.Rcheckbox3,'Value');
                get(handles.Rcheckbox4,'Value');
                get(handles.Rcheckbox5,'Value');
                get(handles.Rcheckbox6,'Value');
                get(handles.Rcheckbox7,'Value');
                get(handles.Rcheckbox8,'Value');
                get(handles.Rcheckbox9,'Value');
                get(handles.Rcheckbox10,'Value')];

            n=get(handles.i_slider,'Value');

            %plot rider
            if (get(handles.rider_pushbutton,'UserData') == 1);

                [x,y,z] = pcaPlotData(handles.ARider(:,n),handles.vRider,handles.uRider,c);

                handles.handlepuntr= plot3(x(1,[1:20]), y(1,[1:20]), z(1,[1:20]),'o','MarkerFaceColor',[0 0 1],'MarkerSize',8);   
                hold on
                handles.handlerlba = plot3(x(1,[1 2 3 4 9 10 11 15 14 13]),y(1,[1 2 3 4 9 10 11 15 14 13]), z(1,[1 2 3 4 9 10 11 15 14 13]),'c');
                handles.handlela   = plot3(x(1,[11 19 18 17]), y(1,[11 19 18 17]), z(1,[11 19 18 17]),'c');
                handles.handlell   = plot3(x(1,[5 6 7 8 9]), y(1,[5 6 7 8 9]), z(1,[5 6 7 8 9]),'c');
                axis([-1.5 0.5 (-handles.uRider(29)-1) (-handles.uRider(29)+1) -mean(handles.rr) (2.2-mean(handles.rr))]);
                
            %plot bicycle
            elseif (get(handles.bicycle_pushbutton,'UserData') == 1);
                [x,y,z] = pcaPlotData(handles.ABike(:,n),handles.vBike,handles.uBike,c);
                %frame
                handles.frontfork   = plot3(x(1,[1 13  7]), y(1,[ 1 13  7]), z(1,[ 1 13  7]), 'r','LineWidth',2);
                hold on
                handles.handlebar  = plot3(x(1,[3 18  9]), y(1,[ 3 18  9]), z(1,[ 3 18  9]), 'r','LineWidth',2);
                handles.stem       = plot3(x(1,[13 18]), y(1,[13 18]), z(1,[13 18]), 'r','LineWidth',2);
                handles.rearfork   = plot3(x(1,[17 5 6 11 17 13  6 17]), y(1,[17  5  6 11 17 13  6 17]), z(1,[17  5  6 11 17 13  6 17]), 'r','LineWidth',2);
                %wheels
                Sf=[(x(1,12)-x(1,20)) (y(1,12)-y(1,20)) (z(1,12)-z(1,20))];
                Pf=[(x(1,12)-x(1, 7)) (y(1,12)-y(1, 7)) (z(1,12)-z(1, 7))];
                R= cross(Sf,Pf);
                Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
                R=R/Rnorm;
                theta=0:pi/20:2*pi;
                qx= x(1,12)*ones(1,41)+ handles.rf(n)*cos(theta)*R(1) + sin(theta)*Sf(1);
                qy= y(1,12)*ones(1,41)+ handles.rf(n)*cos(theta)*R(2) + sin(theta)*Sf(2);
                qz= z(1,12)*ones(1,41)+ handles.rf(n)*cos(theta)*R(3) + sin(theta)*Sf(3);
                handles.frontwheel =plot3(qx, qy, qz,'r','LineWidth',4);
                Sr=[(x(1,16)-x(1,19)) (y(1,16)-y(1,19)) (z(1,16)-z(1,19))];
                Pr=[(x(1,16)-x(1,17)) (y(1,16)-y(1,17)) (z(1,16)-z(1,17))];
                Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
                Rr=Pr/Rrnorm;
                sx= x(1,16)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(1) + sin(theta)*Sr(1);
                sy= y(1,16)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(2) + sin(theta)*Sr(2);
                sz= z(1,16)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(3) + sin(theta)*Sr(3);
                handles.rearwhweel = plot3(sx, sy,sz,'r','LineWidth',4);
                axis([-(handles.uBike(12)+0.5) -(handles.uBike(12)-1.5) (-handles.uBike(32)-1) (-handles.uBike(32)+1) -0.2 1.8]);

            %plot bicycle and rider
            else 
                [x,y,z] = pcaPlotData(handles.ABikeRider(:,n),handles.vBikeRider,handles.uBikeRider,c);
                %rider
                handles.handlepuntr= plot3(x(1,[1:20]), y(1,[1:20]), z(1,[1:20]),'o','MarkerFaceColor',[0 0 1],'MarkerSize',8);
                hold on
                handles.handlerlba = plot3(x(1,[1 2 3 4 9 10 11 15 14 13]),y(1,[1 2 3 4 9 10 11 15 14 13]), z(1,[1 2 3 4 9 10 11 15 14 13]),'c');
                handles.handlela   = plot3(x(1,[11 19 18 17]), y(1,[11 19 18 17]), z(1,[11 19 18 17]),'c');
                handles.handlell   = plot3(x(1,[5 6 7 8 9]), y(1,[5 6 7 8 9]), z(1,[5 6 7 8 9]),'c');
                %frame
                handles.frontfork   = plot3(x(1,[21 33 27]), y(1,[21 33 27]), z(1,[21 33 27]), 'r','LineWidth',2);
                handles.handlebar  = plot3(x(1,[23 38 29]), y(1,[23 38 29]), z(1,[23 38 29]), 'r','LineWidth',2);
                handles.stem       = plot3(x(1,[33 38]), y(1,[33 38]), z(1,[33 38]), 'r','LineWidth',2);
                handles.rearfork   = plot3(x(1,[37 25 26 31 37 33 26 37]), y(1,[37 25 26 31 37 33 26 37]), z(1,[37 25 26 31 37 33 26 37]), 'r','LineWidth',2);
                %wheels
                Sf=[(x(1,32)-x(1,40)) (y(1,32)-y(1,40)) (z(1,32)-z(1,40))];
                Pf=[(x(1,32)-x(1,27)) (y(1,32)-y(1,27)) (z(1,32)-z(1,27))];
                R= cross(Sf,Pf);
                Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
                R=R/Rnorm;
                theta=0:pi/20:2*pi;
                qx= x(1,32)*ones(1,41)+ handles.rf(n)*cos(theta)*R(1) + sin(theta)*Sf(1);
                qy= y(1,32)*ones(1,41)+ handles.rf(n)*cos(theta)*R(2) + sin(theta)*Sf(2);
                qz= z(1,32)*ones(1,41)+ handles.rf(n)*cos(theta)*R(3) + sin(theta)*Sf(3);
                handles.frontwheel =plot3(qx, qy, qz,'r','LineWidth',4);
                Sr=[(x(1,36)-x(1,39)) (y(1,36)-y(1,39)) (z(1,36)-z(1,39))];
                Pr=[(x(1,36)-x(1,37)) (y(1,36)-y(1,37)) (z(1,36)-z(1,37))];
                Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
                Rr=Pr/Rrnorm;
                sx= x(1,36)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(1) + sin(theta)*Sr(1);
                sy= y(1,36)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(2) + sin(theta)*Sr(2);
                sz= z(1,36)*ones(1,41)+ handles.rr(n)*cos(theta)*Rr(3) + sin(theta)*Sr(3);
                handles.rearwhweel = plot3(sx, sy,sz,'r','LineWidth',4);

                axis([-(handles.uBikeRider(32)+0.5) -(handles.uBikeRider(32)-1.5) (-handles.uBikeRider(72)-1) (-handles.uBikeRider(72)+1) -0.2 2]);


            end
        else
            c=[ get(handles.Lcheckbox1,'Value');
                get(handles.Lcheckbox2,'Value');
                get(handles.Lcheckbox3,'Value');
                get(handles.Lcheckbox4,'Value');
                get(handles.Lcheckbox5,'Value');
                get(handles.Lcheckbox6,'Value');
                get(handles.Lcheckbox7,'Value');
                get(handles.Lcheckbox8,'Value');
                get(handles.Lcheckbox9,'Value');
                get(handles.Lcheckbox10,'Value')];
            n=get(handles.Li_slider,'Value');
 %plot rider
            if (get(handles.rider_pushbutton,'UserData') == 1);
                [x,y,z] = pcaPlotData(handles.LARider(:,n),handles.LvRider,handles.LuRider,c);
                %rider
                handles.Lhandlepuntr= plot3(x(1,[1:20]), y(1,[1:20]), z(1,[1:20]),'o','MarkerFaceColor',[0 0 1],'MarkerSize',8);   
                hold on
                handles.Lhandlerlba = plot3(x(1,[1 2 3 4 9 10 11 15 14 13]),y(1,[1 2 3 4 9 10 11 15 14 13]), z(1,[1 2 3 4 9 10 11 15 14 13]),'c');
                handles.Lhandlela   = plot3(x(1,[11 19 18 17]), y(1,[11 19 18 17]), z(1,[11 19 18 17]),'c');
                handles.Lhandlell   = plot3(x(1,[5 6 7 8 9]), y(1,[5 6 7 8 9]), z(1,[5 6 7 8 9]),'c');
                axis([-1.5 0.5 (-handles.LuRider(29)-1) (-handles.LuRider(29)+1) -mean(handles.Lrr) (2.2-mean(handles.Lrr))]);
                
            %plot bicycle
            elseif (get(handles.bicycle_pushbutton,'UserData') == 1);
                [x,y,z] = pcaPlotData(handles.LABike(:,n),handles.LvBike,handles.LuBike,c);
                %frame
                handles.Lfrontfork   = plot3(x(1,[1 13  7]), y(1,[ 1 13  7]), z(1,[ 1 13  7]), 'r','LineWidth',2);
                hold on
                handles.Lhandlebar  = plot3(x(1,[3 18  9]), y(1,[ 3 18  9]), z(1,[ 3 18  9]), 'r','LineWidth',2);
                handles.Lstem       = plot3(x(1,[13 18]), y(1,[13 18]), z(1,[13 18]), 'r','LineWidth',2);
                handles.Lrearfork   = plot3(x(1,[17 5 6 11 17 13  6 17]), y(1,[17  5  6 11 17 13  6 17]), z(1,[17  5  6 11 17 13  6 17]), 'r','LineWidth',2);
                %wheels
                Sf=[(x(1,12)-x(1,20)) (y(1,12)-y(1,20)) (z(1,12)-z(1,20))];
                Pf=[(x(1,12)-x(1, 7)) (y(1,12)-y(1, 7)) (z(1,12)-z(1, 7))];
                R= cross(Sf,Pf);
                Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
                R=R/Rnorm;
                theta=0:pi/20:2*pi;
                qx= x(1,12)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(1) + sin(theta)*Sf(1);
                qy= y(1,12)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(2) + sin(theta)*Sf(2);
                qz= z(1,12)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(3) + sin(theta)*Sf(3);
                handles.Lfrontwheel =plot3(qx, qy, qz,'r','LineWidth',4);
                Sr=[(x(1,16)-x(1,19)) (y(1,16)-y(1,19)) (z(1,16)-z(1,19))];
                Pr=[(x(1,16)-x(1,17)) (y(1,16)-y(1,17)) (z(1,16)-z(1,17))];
                Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
                Rr=Pr/Rrnorm;
                sx= x(1,16)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(1) + sin(theta)*Sr(1);
                sy= y(1,16)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(2) + sin(theta)*Sr(2);
                sz= z(1,16)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(3) + sin(theta)*Sr(3);
                handles.Lrearwhweel = plot3(sx, sy,sz,'r','LineWidth',4);
                axis([-(handles.LuBike(12)+0.5) -(handles.LuBike(12)-1.5) (-handles.LuBike(32)-1) (-handles.LuBike(32)+1) -0.2 1.8]);

            %plot bicycle and rider
            else 
                [x,y,z] = pcaPlotData(handles.LABikeRider(:,n),handles.LvBikeRider,handles.LuBikeRider,c);
                %rider
                handles.Lhandlepuntr= plot3(x(1,[1:20]), y(1,[1:20]), z(1,[1:20]),'o','MarkerFaceColor',[0 0 1],'MarkerSize',8);
                hold on
                handles.Lhandlerlba = plot3(x(1,[1 2 3 4 9 10 11 15 14 13]),y(1,[1 2 3 4 9 10 11 15 14 13]), z(1,[1 2 3 4 9 10 11 15 14 13]),'c');
                handles.Lhandlela   = plot3(x(1,[11 19 18 17]), y(1,[11 19 18 17]), z(1,[11 19 18 17]),'c');
                handles.Lhandlell   = plot3(x(1,[5 6 7 8 9]), y(1,[5 6 7 8 9]), z(1,[5 6 7 8 9]),'c');
                %frame
                handles.Lfrontfork   = plot3(x(1,[21 33 27]), y(1,[21 33 27]), z(1,[21 33 27]), 'r','LineWidth',2);
                handles.Lhandlebar  = plot3(x(1,[23 38 29]), y(1,[23 38 29]), z(1,[23 38 29]), 'r','LineWidth',2);
                handles.Lstem       = plot3(x(1,[33 38]), y(1,[33 38]), z(1,[33 38]), 'r','LineWidth',2);
                handles.Lrearfork   = plot3(x(1,[37 25 26 31 37 33 26 37]), y(1,[37 25 26 31 37 33 26 37]), z(1,[37 25 26 31 37 33 26 37]), 'r','LineWidth',2);
                %wheels
                Sf=[(x(1,32)-x(1,40)) (y(1,32)-y(1,40)) (z(1,32)-z(1,40))];
                Pf=[(x(1,32)-x(1,27)) (y(1,32)-y(1,27)) (z(1,32)-z(1,27))];
                R= cross(Sf,Pf);
                Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
                R=R/Rnorm;
                theta=0:pi/20:2*pi;
                qx= x(1,32)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(1) + sin(theta)*Sf(1);
                qy= y(1,32)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(2) + sin(theta)*Sf(2);
                qz= z(1,32)*ones(1,41)+ handles.Lrf(n)*cos(theta)*R(3) + sin(theta)*Sf(3);
                handles.Lfrontwheel =plot3(qx, qy, qz,'r','LineWidth',4);
                Sr=[(x(1,36)-x(1,39)) (y(1,36)-y(1,39)) (z(1,36)-z(1,39))];
                Pr=[(x(1,36)-x(1,37)) (y(1,36)-y(1,37)) (z(1,36)-z(1,37))];
                Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
                Rr=Pr/Rrnorm;
                sx= x(1,36)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(1) + sin(theta)*Sr(1);
                sy= y(1,36)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(2) + sin(theta)*Sr(2);
                sz= z(1,36)*ones(1,41)+ handles.Lrr(n)*cos(theta)*Rr(3) + sin(theta)*Sr(3);
                handles.Lrearwhweel = plot3(sx, sy,sz,'r','LineWidth',4);
                axis([-(handles.LuBikeRider(32)+0.5) -(handles.LuBikeRider(32)-1.5) (-handles.LuBikeRider(72)-1) (-handles.LuBikeRider(72)+1) -0.2 2]);
            end
        end
        if (get(handles.D2_radiobutton,'Value') == get(handles.D2_radiobutton,'Max')); %%2D plot
            if (get(handles.Side_radiobutton,'Value') == get(handles.Side_radiobutton,'Max')); %side view?
                AZ=0;          
            else %front View
                AZ=270;
            end
            if (get(handles.top_radiobutton,'Value') == get(handles.top_radiobutton,'Max')); %top view?
                EL=90;
            else %horizontal view
                EL=0;
            end
        else %%3D view
            AZ = -50;
            EL = 30;
        end
        view(AZ,EL)
        guidata(hObject, handles);


%function for updating the plot
function timeplot(hObject,handles, nr) %% this function updates the graph
if nr==1                                                                   %for which graph is the data required?
    c=[ get(handles.Rcheckbox1,'Value');
        get(handles.Rcheckbox2,'Value');
        get(handles.Rcheckbox3,'Value');
        get(handles.Rcheckbox4,'Value');
        get(handles.Rcheckbox5,'Value');
        get(handles.Rcheckbox6,'Value');
        get(handles.Rcheckbox7,'Value');
        get(handles.Rcheckbox8,'Value');
        get(handles.Rcheckbox9,'Value');
        get(handles.Rcheckbox10,'Value')];
    n=get(handles.i_slider,'Value');
    axes(handles.PCA_axes);
    handles=guidata(hObject);
%rider only
    if (get(handles.rider_pushbutton,'UserData')==1);    
       [x,y,z] = pcaPlotData(handles.ARider(:,n),handles.vRider,handles.uRider,c);
       timeplotrider(hObject,handles,x,y,z);
%rider and bicycle       
    elseif(get(handles.both_pushbutton,'UserData') == 1); 
        [x,y,z] = pcaPlotData(handles.ABikeRider(:,n),handles.vBikeRider,handles.uBikeRider,c);
        timeplotboth(hObject,handles,x, y, z);
%bicycle only    
    else [x,y,z] = pcaPlotData(handles.ABike(:,n),handles.vBike,handles.uBike,c);
        timeplotbike(hObject,handles,x,y,z);
    end     
else
    c=[ get(handles.Lcheckbox1,'Value');
        get(handles.Lcheckbox2,'Value');
        get(handles.Lcheckbox3,'Value');
        get(handles.Lcheckbox4,'Value');
        get(handles.Lcheckbox5,'Value');
        get(handles.Lcheckbox6,'Value');
        get(handles.Lcheckbox7,'Value');
        get(handles.Lcheckbox8,'Value');
        get(handles.Lcheckbox9,'Value');
        get(handles.Lcheckbox10,'Value')];
    n=get(handles.Li_slider,'Value');
    axes(handles.LPCA_axes);
    handles=guidata(hObject);
    %rider only
    if (get(handles.rider_pushbutton,'UserData')==1);
       [x,y,z] = pcaPlotData(handles.LARider(:,n),handles.LvRider,handles.LuRider,c);
       Ltimeplotrider(hObject,handles,x,y,z);
%rider and bicycle       
    elseif(get(handles.both_pushbutton,'UserData') == 1); 
        [x,y,z] = pcaPlotData(handles.LABikeRider(:,n),handles.LvBikeRider,handles.LuBikeRider,c);
        Ltimeplotboth(hObject,handles,x, y, z);
%bicycle only    
    else [x,y,z] = pcaPlotData(handles.LABike(:,n),handles.LvBike,handles.LuBike,c);
        Ltimeplotbike(hObject,handles,x,y,z);
    end
end
%plot setup
if (get(handles.D2_radiobutton,'Value') == get(handles.D2_radiobutton,'Max')); %%2D plot
    if (get(handles.Side_radiobutton,'Value') == get(handles.Side_radiobutton,'Max')); %side view?
        AZ=0;
    else %front View
        AZ=270;
    end
    if (get(handles.top_radiobutton,'Value') == get(handles.top_radiobutton,'Max')); %top view?
        EL=90;
    else %horizontal view
        EL=0;
    end
else %%3D view
    AZ = -50;
    EL = 30;
end
view(AZ,EL);
guidata(hObject, handles);

function [x,y,z] = pcaPlotData(a,V,u,c);
comp = diag(c);
P = u + V*comp*a;
l = max(size(V))/3;
x = P(1:l,:);
x=-x';
y = P(l+1:2*l,:);
y=-y';
z = P(2*l+1:3*l,:);
z=-z';

%% RIGHT PLOTS

function timeplotboth(hObject,handles,x, y, z)
    handles=guidata(hObject);
%rider    
set(handles.handlepuntr,'XData',x(1,[1:20]));
set(handles.handlerlba,'XData',x(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.handlela, 'XData',x(1,[11 19 18 17]));
set(handles.handlell, 'XData',x(1,[5 6 7 8 9]));

set(handles.handlepuntr,'YData',y(1,[1:20]));
set(handles.handlerlba,'YData',y(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.handlela, 'YData',y(1,[11 19 18 17]));
set(handles.handlell, 'YData',y(1,[5 6 7 8 9]));

set(handles.handlepuntr,'ZData',z(1,[1:20]));
set(handles.handlerlba,'ZData',z(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.handlela, 'ZData',z(1,[11 19 18 17]));
set(handles.handlell, 'ZData',z(1,[5 6 7 8 9]));

%bicycle frame
set(handles.frontfork,'XData',x(1,[21 33 27]));
set(handles.handlebar,'XData',x(1,[23 38 29]));
set(handles.stem,'XData',x(1,[33 38]));
set(handles.rearfork,'XData',x(1,[37 25 26 31 37 33 26 37]));

set(handles.frontfork,'YData',y(1,[21 33 27]));
set(handles.handlebar,'YData',y(1,[23 38 29]));
set(handles.stem,'YData',y(1,[33 38]));
set(handles.rearfork,'YData',y(1,[37 25 26 31 37 33 26 37]));

set(handles.frontfork,'ZData',z(1,[21 33 27]));
set(handles.handlebar,'ZData',z(1,[23 38 29]));
set(handles.stem,'ZData',z(1,[33 38]));
set(handles.rearfork,'ZData',z(1,[37 25 26 31 37 33 26 37]));

%wheels
Sf=[(x(1,32)-x(1,40)) (y(1,32)-y(1,40)) (z(1,32)-z(1,40))];
Pf=[(x(1,32)-x(1,27)) (y(1,32)-y(1,27)) (z(1,32)-z(1,27))];
R= cross(Sf,Pf);
Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
R=R/Rnorm;
theta=0:pi/20:2*pi; %steps in angle to make wheel
qx= x(1,32)*ones(1,41)+ handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(1) + sin(theta)*Sf(1);
qy= y(1,32)*ones(1,41)+ handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(2) + sin(theta)*Sf(2);
qz= z(1,32)*ones(1,41)+ handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(3) + sin(theta)*Sf(3);
set(handles.frontwheel,'XData',qx);
set(handles.frontwheel,'YData',qy);
set(handles.frontwheel,'ZData',qz);
Sr=[(x(1,36)-x(1,39)) (y(1,36)-y(1,39)) (z(1,36)-z(1,39))];
Pr=[(x(1,36)-x(1,37)) (y(1,36)-y(1,37)) (z(1,36)-z(1,37))];
Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
Rr=Pr/Rrnorm;
sx= x(1,36)*ones(1,41)+ handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(1) + sin(theta)*Sr(1);
sy= y(1,36)*ones(1,41)+ handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(2) + sin(theta)*Sr(2);
sz= z(1,36)*ones(1,41)+ handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(3) + sin(theta)*Sr(3);
set(handles.rearwhweel,'XData',sx);
set(handles.rearwhweel,'YData',sy);
set(handles.rearwhweel,'ZData',sz);
guidata(hObject, handles);

    function timeplotbike(hObject,handles,x,y,z)
        handles=guidata(hObject);
%bike
        set(handles.frontfork,'XData',x(1,[1 13 7]));
        set(handles.handlebar,'XData',x(1,[3 18 9]));
        set(handles.stem,'XData',x(1,[13 18]));
        set(handles.rearfork,'XData',x(1,[17 5 6 11 17 13 6 17]));

        set(handles.frontfork,'YData',y(1,[1 13 7]));
        set(handles.handlebar,'YData',y(1,[3 18 9]));
        set(handles.stem,'YData',y(1,[13 18]));
        set(handles.rearfork,'YData',y(1,[17 5 6 11 17 13 6 17]));

        set(handles.frontfork,'ZData',z(1,[1 13 7]));
        set(handles.handlebar,'ZData',z(1,[3 18 9]));
        set(handles.stem,'ZData',z(1,[13 18]));
        set(handles.rearfork,'ZData',z(1,[17 5 6 11 17 13 6 17]));
%wheels
        Sf=[(x(1,12)-x(1,20)) (y(1,12)-y(1,20)) (z(1,12)-z(1,20))];
        Pf=[(x(1,12)-x(1,7)) (y(1,12)-y(1,7)) (z(1,12)-z(1,7))];
        R= cross(Sf,Pf);
        Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
        R=R/Rnorm;
        theta=0:pi/20:2*pi;
        qx= x(1,12)*ones(1,41)+handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(1) + sin(theta)*Sf(1);
        qy= y(1,12)*ones(1,41)+handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(2) + sin(theta)*Sf(2);
        qz= z(1,12)*ones(1,41)+handles.rf(get(handles.i_slider,'Value'))*cos(theta)*R(3) + sin(theta)*Sf(3);
        set(handles.frontwheel,'XData',qx);
        set(handles.frontwheel,'YData',qy);
        set(handles.frontwheel,'ZData',qz);
        Sr=[(x(1,16)-x(1,19)) (y(1,16)-y(1,19)) (z(1,16)-z(1,19))];
        Pr=[(x(1,16)-x(1,17)) (y(1,16)-y(1,17)) (z(1,16)-z(1,17))];
        Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
        Rr=Pr/Rrnorm;
        sx= x(1,16)*ones(1,41)+handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(1) + sin(theta)*Sr(1);
        sy= y(1,16)*ones(1,41)+handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(2) + sin(theta)*Sr(2);
        sz= z(1,16)*ones(1,41)+handles.rr(get(handles.i_slider,'Value'))*cos(theta)*Rr(3) + sin(theta)*Sr(3);
        set(handles.rearwhweel,'XData',sx);
        set(handles.rearwhweel,'YData',sy);
        set(handles.rearwhweel,'ZData',sz);
guidata(hObject, handles);

        function timeplotrider(hObject,handles,x,y,z)
            handles=guidata(hObject);
            %Rider
            set(handles.handlepuntr,'XData',x(1,[1:20]));
            set(handles.handlerlba,'XData',x(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.handlela, 'XData',x(1,[11 19 18 17]));
            set(handles.handlell, 'XData',x(1,[5 6 7 8 9]));

            set(handles.handlepuntr,'YData',y(1,[1:20]));
            set(handles.handlerlba,'YData',y(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.handlela, 'YData',y(1,[11 19 18 17]));
            set(handles.handlell, 'YData',y(1,[5 6 7 8 9]));

            set(handles.handlepuntr,'ZData',z(1,[1:20]));
            set(handles.handlerlba,'ZData',z(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.handlela, 'ZData',z(1,[11 19 18 17]));
            set(handles.handlell, 'ZData',z(1,[5 6 7 8 9]));
guidata(hObject, handles);

%% LEFT PLOTS

function Ltimeplotboth(hObject,handles,x, y, z)
    handles=guidata(hObject);
%rider    
set(handles.Lhandlepuntr,'XData',x(1,[1:20]));
set(handles.Lhandlerlba,'XData',x(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.Lhandlela, 'XData',x(1,[11 19 18 17]));
set(handles.Lhandlell, 'XData',x(1,[5 6 7 8 9]));

set(handles.Lhandlepuntr,'YData',y(1,[1:20]));
set(handles.Lhandlerlba,'YData',y(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.Lhandlela, 'YData',y(1,[11 19 18 17]));
set(handles.Lhandlell, 'YData',y(1,[5 6 7 8 9]));

set(handles.Lhandlepuntr,'ZData',z(1,[1:20]));
set(handles.Lhandlerlba,'ZData',z(1,[1 2 3 4 9 10 11 15 14 13]));
set(handles.Lhandlela, 'ZData',z(1,[11 19 18 17]));
set(handles.Lhandlell, 'ZData',z(1,[5 6 7 8 9]));

%bicycle frame
set(handles.Lfrontfork,'XData',x(1,[21 33 27]));
set(handles.Lhandlebar,'XData',x(1,[23 38 29]));
set(handles.Lstem,'XData',x(1,[33 38]));
set(handles.Lrearfork,'XData',x(1,[37 25 26 31 37 33 26 37]));

set(handles.Lfrontfork,'YData',y(1,[21 33 27]));
set(handles.Lhandlebar,'YData',y(1,[23 38 29]));
set(handles.Lstem,'YData',y(1,[33 38]));
set(handles.Lrearfork,'YData',y(1,[37 25 26 31 37 33 26 37]));

set(handles.Lfrontfork,'ZData',z(1,[21 33 27]));
set(handles.Lhandlebar,'ZData',z(1,[23 38 29]));
set(handles.Lstem,'ZData',z(1,[33 38]));
set(handles.Lrearfork,'ZData',z(1,[37 25 26 31 37 33 26 37]));

%wheels
Sf=[(x(1,32)-x(1,40)) (y(1,32)-y(1,40)) (z(1,32)-z(1,40))];
Pf=[(x(1,32)-x(1,27)) (y(1,32)-y(1,27)) (z(1,32)-z(1,27))];
R= cross(Sf,Pf);
Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
R=R/Rnorm;
theta=0:pi/20:2*pi; %steps in angle to make wheel
qx= x(1,32)*ones(1,41)+ handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(1) + sin(theta)*Sf(1);
qy= y(1,32)*ones(1,41)+ handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(2) + sin(theta)*Sf(2);
qz= z(1,32)*ones(1,41)+ handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(3) + sin(theta)*Sf(3);
set(handles.Lfrontwheel,'XData',qx);
set(handles.Lfrontwheel,'YData',qy);
set(handles.Lfrontwheel,'ZData',qz);
Sr=[(x(1,36)-x(1,39)) (y(1,36)-y(1,39)) (z(1,36)-z(1,39))];
Pr=[(x(1,36)-x(1,37)) (y(1,36)-y(1,37)) (z(1,36)-z(1,37))];
Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
Rr=Pr/Rrnorm;
sx= x(1,36)*ones(1,41)+ handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(1) + sin(theta)*Sr(1);
sy= y(1,36)*ones(1,41)+ handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(2) + sin(theta)*Sr(2);
sz= z(1,36)*ones(1,41)+ handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(3) + sin(theta)*Sr(3);
set(handles.Lrearwhweel,'XData',sx);
set(handles.Lrearwhweel,'YData',sy);
set(handles.Lrearwhweel,'ZData',sz);
guidata(hObject, handles);

    function Ltimeplotbike(hObject,handles,x,y,z)
        handles=guidata(hObject);
%bike
        set(handles.Lfrontfork,'XData',x(1,[1 13 7]));
        set(handles.Lhandlebar,'XData',x(1,[3 18 9]));
        set(handles.Lstem,'XData',x(1,[13 18]));
        set(handles.Lrearfork,'XData',x(1,[17 5 6 11 17 13 6 17]));

        set(handles.Lfrontfork,'YData',y(1,[1 13 7]));
        set(handles.Lhandlebar,'YData',y(1,[3 18 9]));
        set(handles.Lstem,'YData',y(1,[13 18]));
        set(handles.Lrearfork,'YData',y(1,[17 5 6 11 17 13 6 17]));

        set(handles.Lfrontfork,'ZData',z(1,[1 13 7]));
        set(handles.Lhandlebar,'ZData',z(1,[3 18 9]));
        set(handles.Lstem,'ZData',z(1,[13 18]));
        set(handles.Lrearfork,'ZData',z(1,[17 5 6 11 17 13 6 17]));
%wheels
        Sf=[(x(1,12)-x(1,20)) (y(1,12)-y(1,20)) (z(1,12)-z(1,20))];
        Pf=[(x(1,12)-x(1,7)) (y(1,12)-y(1,7)) (z(1,12)-z(1,7))];
        R= cross(Sf,Pf);
        Rnorm = sqrt(R(1)^2+R(2)^2+R(3)^2);
        R=R/Rnorm;
        theta=0:pi/20:2*pi;
        qx= x(1,12)*ones(1,41)+handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(1) + sin(theta)*Sf(1);
        qy= y(1,12)*ones(1,41)+handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(2) + sin(theta)*Sf(2);
        qz= z(1,12)*ones(1,41)+handles.Lrf(get(handles.Li_slider,'Value'))*cos(theta)*R(3) + sin(theta)*Sf(3);
        set(handles.Lfrontwheel,'XData',qx);
        set(handles.Lfrontwheel,'YData',qy);
        set(handles.Lfrontwheel,'ZData',qz);
        Sr=[(x(1,16)-x(1,19)) (y(1,16)-y(1,19)) (z(1,16)-z(1,19))];
        Pr=[(x(1,16)-x(1,17)) (y(1,16)-y(1,17)) (z(1,16)-z(1,17))];
        Rrnorm = sqrt(Pr(1)^2+Pr(2)^2+Pr(3)^2);
        Rr=Pr/Rrnorm;
        sx= x(1,16)*ones(1,41)+handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(1) + sin(theta)*Sr(1);
        sy= y(1,16)*ones(1,41)+handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(2) + sin(theta)*Sr(2);
        sz= z(1,16)*ones(1,41)+handles.Lrr(get(handles.Li_slider,'Value'))*cos(theta)*Rr(3) + sin(theta)*Sr(3);
        set(handles.Lrearwhweel,'XData',sx);
        set(handles.Lrearwhweel,'YData',sy);
        set(handles.Lrearwhweel,'ZData',sz);
guidata(hObject, handles);

        function Ltimeplotrider(hObject,handles,x,y,z)
            handles=guidata(hObject);
            %Rider
            set(handles.Lhandlepuntr,'XData',x(1,[1:20]));
            set(handles.Lhandlerlba,'XData',x(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.Lhandlela, 'XData',x(1,[11 19 18 17]));
            set(handles.Lhandlell, 'XData',x(1,[5 6 7 8 9]));

            set(handles.Lhandlepuntr,'YData',y(1,[1:20]));
            set(handles.Lhandlerlba,'YData',y(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.Lhandlela, 'YData',y(1,[11 19 18 17]));
            set(handles.Lhandlell, 'YData',y(1,[5 6 7 8 9]));

            set(handles.Lhandlepuntr,'ZData',z(1,[1:20]));
            set(handles.Lhandlerlba,'ZData',z(1,[1 2 3 4 9 10 11 15 14 13]));
            set(handles.Lhandlela, 'ZData',z(1,[11 19 18 17]));
            set(handles.Lhandlell, 'ZData',z(1,[5 6 7 8 9]));
guidata(hObject, handles);

%% CHECKBOXES
% --- Executes on button press in checkbox1.
function Rcheckbox1_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox2.
function Rcheckbox2_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox3.
function Rcheckbox3_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox4.   
function Rcheckbox4_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox5.
function Rcheckbox5_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox6.
function Rcheckbox6_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox7.    
function Rcheckbox7_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox8.
function Rcheckbox8_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox9.
function Rcheckbox9_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox10.
function Rcheckbox10_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox1.
function Lcheckbox1_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox2.
function Lcheckbox2_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox3.
function Lcheckbox3_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox4.   
function Lcheckbox4_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox5.
function Lcheckbox5_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox6.
function Lcheckbox6_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox7.    
function Lcheckbox7_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox8.
function Lcheckbox8_Callback(hObject, eventdata, handles)
    
% --- Executes on button press in checkbox9.
function Lcheckbox9_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox10.
function Lcheckbox10_Callback(hObject, eventdata, handles)
        
%% Close program

        
        


% --- Executes on button press in close_pushbutton.
function close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)

