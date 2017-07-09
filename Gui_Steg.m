function varargout = Gui_Steg(varargin)
% GUI_STEG MATLAB code for Gui_Steg.fig
%      GUI_STEG, by itself, creates a new GUI_STEG or raises the existing
%      singleton*.
%
%      H = GUI_STEG returns the handle to a new GUI_STEG or the handle to
%      the existing singleton*.
%
%      GUI_STEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_STEG.M with the given input arguments.
%
%      GUI_STEG('Property','Value',...) creates a new GUI_STEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_Steg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_Steg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui_Steg

% Last Modified by GUIDE v2.5 12-Feb-2013 00:26:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui_Steg_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui_Steg_OutputFcn, ...
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


% --- Executes just before Gui_Steg is made visible.
function Gui_Steg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui_Steg (see VARARGIN)

% Choose default command line output for Gui_Steg
handles.output = hObject;


a=ones(256,256);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui_Steg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_Steg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filename, pathname] = uigetfile('*.*', 'Pick a Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       axes(handles.axes1);
       handles.InputImage=InputImage;
       imshow(InputImage);
       
    end
 
    % Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Datahiding.
function Datahiding_Callback(hObject, eventdata, handles)
% hObject    handle to Datahiding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
original=handles.InputImage;
target=handles.InputImage;
fid = fopen('message.txt','r');
F = fread(fid);
s = char(F');
fclose(fid);

sz1=size(original);
size1=sz1(1)*sz1(2);
sz2=size(F);
size2=sz2(1);


if size2> size1 
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is Small');
    i=1;j=1;k=1;
        while k<=size2
        a=F(k);
        o1=original(i,j,1);
        o2=original(i,j,2);
        o3=original(i,j,3);
        
        [r1,r2,r3]=hidetext(o1,o2,o3,a); 
        
        target(i,j,1)=r1;
        target(i,j,2)=r2;
        target(i,j,3)=r3;
        
            if(i<sz1(1))
                i=i+1;
            else
                i=1;
                j=j+1;
            end
            k=k+1;
        end
        width=sz1(1);
        txtsz=size2;
        n=size(original);
        target(n(1),n(2),1)=txtsz;% Text Size
        target(n(1),n(2),2)=width;% Image's Width
        
        
        %save secret.mat target;% txtsz width;
        imwrite(target,'secret.bmp','bmp');
       
       axes(handles.axes2),imshow(target)
    
    end
    

helpdlg('data hided succesfully in secret.bmp');


% --- Executes on button press in DataRetrive.
function DataRetrive_Callback(hObject, eventdata, handles)
% hObject    handle to DataRetrive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 target=handles.Stego;
        n=size(target);
        txtsz=target(n(1),n(2),1);% Text Size
        width=target(n(1),n(2),2);% Image's Width

      
        
      
            
        i=1;j=1;k=1;
        while k<=txtsz
        
        r1=target(i,j,1);
        r2=target(i,j,2);
        r3=target(i,j,3);
        
        R(k)=findtext(r1,r2,r3);
                
                if(i<width)
                    i=i+1;
                else
                    i=1;
                    j=j+1;
                end
                k=k+1;
        end
        
        fid = fopen('secret.txt','wb');
        fwrite(fid,char(R),'char');
        fclose(fid);
   
 helpdlg('data Retrived succesfully in secret.txt');



% --- Executes on button press in message.
function message_Callback(hObject, eventdata, handles)
% hObject    handle to message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('message.txt');

% --- Executes on button press in browsestegoimage.
function browsestegoimage_Callback(hObject, eventdata, handles)
% hObject    handle to browsestegoimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  [filename, pathname] = uigetfile('*.*', 'Pick a Image');
    if isequal(filename,0) || isequal(pathname,0)
       warndlg('User pressed cancel')
    else
       InputImage=imread(strcat(pathname,filename));
       axes(handles.axes1);
       handles.Stego=InputImage;
       imshow(InputImage);
       
    end
 
    % Update handles structure
guidata(hObject, handles);
% --- Executes on button press in openretrievedmessage.
function openretrievedmessage_Callback(hObject, eventdata, handles)
% hObject    handle to openretrievedmessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open('secret.txt');
% --- Executes on button press in Deletemessage.
function Deletemessage_Callback(hObject, eventdata, handles)
% hObject    handle to Deletemessage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
