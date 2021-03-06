function varargout = AlgorithmExplore(varargin)
% ALGORITHMEXPLORE MATLAB code for AlgorithmExplore.fig
%      ALGORITHMEXPLORE, by itself, creates a new ALGORITHMEXPLORE or raises the existing
%      singleton*.
%
%      H = ALGORITHMEXPLORE returns the handle to a new ALGORITHMEXPLORE or the handle to
%      the existing singleton*.
%
%      ALGORITHMEXPLORE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALGORITHMEXPLORE.M with the given input arguments.
%
%      ALGORITHMEXPLORE('Property','Value',...) creates a new ALGORITHMEXPLORE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AlgorithmExplore_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AlgorithmExplore_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AlgorithmExplore


global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX;
SELECT_ALG     = 1;  % top popup menu option 
INSERTION_SORT = 2;  % Insertion Sort                   (done)
SELECTION_SORT = 3;  % Selection Sort                   (done)
BUBBLE_SORT    = 4;  % Bubble Sort                      (done)
MERGE_SORT     = 5;  % Merge Sort                       (recursive done)
QUICKSORT      = 6;  % Quicksort
QUICKSORT_3    = 7;  % Quicksort (3-way partition)
RADIX_SORT     = 8;  % Radix sort
TREE_SORT      = 9;  % Tree sort
QUICKSORT_MEX  = 10; % Quicksort (compiled C program)


% Last Modified by GUIDE v2.5 19-Apr-2013 21:27:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlgorithmExplore_OpeningFcn, ...
                   'gui_OutputFcn',  @AlgorithmExplore_OutputFcn, ...
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

% --- Executes just before AlgorithmExplore is made visible.
function AlgorithmExplore_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlgorithmExplore (see VARARGIN)

% Choose default command line output for AlgorithmExplore
handles.output = hObject;
handles.BAR_OR_SCATTER = 'bar';
handles.PLOTTING = false;
handles.STOP_PLOTTING = false;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AlgorithmExplore wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AlgorithmExplore_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Go.
function Go_Callback(hObject, eventdata, handles)
% hObject    handle to Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.PLOTTING
    return
end 
global SELECT_ALG INSERTION_SORT SELECTION_SORT BUBBLE_SORT MERGE_SORT ...
       QUICKSORT QUICKSORT_3 RADIX_SORT TREE_SORT QUICKSORT_MEX;
axes(handles.axes1);
cla;
%MAKE CLEAR BUTTON
popup_sel_index = get(handles.popAlgs, 'Value');
handles.STOP_PLOTTING = false;
handles.PLOTTING = true;
guidata(hObject,handles);
SetSize = str2num(get(handles.SetSizeEdit,'String'));
class(SetSize);
list = randi(SetSize,1,SetSize);
switch popup_sel_index
    case SELECT_ALG
        
    case INSERTION_SORT
        InsertionSort(list,true,handles.axes1);
    case SELECTION_SORT
        SelectionSort(list,true,handles.axes1);
    case BUBBLE_SORT
        BubbleSort(list,true,handles.axes1);
    case MERGE_SORT
        MergeSort(list,true,handles.axes1);
    case QUICKSORT
        Quicksort(list,true,handles.axes1);
    case QUICKSORT_3
        Quicksort3(list,true,handles.axes1);
    case RADIX_SORT
        RadixSort(list,true,handles.axes1);
    case TREE_SORT
        TreeSort(list,true,handles.axes1);
    case QUICKSORT_MEX
        QuicksortMEX(list,true,handles.axes1);
end
handles.PLOTTING = false;
guidata(hObject,handles);
% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});



function SetSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to SetSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SetSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of SetSizeEdit as a double


% --- Executes during object creation, after setting all properties.
function SetSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SetSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popAlgs.
function popAlgs_Callback(hObject, eventdata, handles)
% hObject    handle to popAlgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlgs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlgs


% --- Executes during object creation, after setting all properties.
function popAlgs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Hyperlink.
function Hyperlink_Callback(hObject, eventdata, handles)
% hObject    handle to Hyperlink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

web('-new')
web('http://www.sorting-algorithms.com/')



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.PLOTTING == true
    handles.STOP_PLOTTING = true;
    % the 'go' button callback should set PLOTTING to false when the sort
    % algorithm falls through, but I'll set it here anyway in case the sort
    % algorithm is interrupted/crashes:
    handles.PLOTTING = false;
    disp('User requested to stop plotting.');
    %set(hObject, 'String', 'Close');
    guidata(hObject, handles); % update 'handles' structure for other controls
else
    close(gcf);
end %if


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes1);