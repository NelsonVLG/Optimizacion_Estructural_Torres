function varargout = ventanaInforme(varargin)
% VENTANAINFORME MATLAB code for ventanaInforme.fig
%      VENTANAINFORME, by itself, creates a new VENTANAINFORME or raises the existing
%      singleton*.
%
%      H = VENTANAINFORME returns the handle to a new VENTANAINFORME or the handle to
%      the existing singleton*.
%
%      VENTANAINFORME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANAINFORME.M with the given input arguments.
%
%      VENTANAINFORME('Property','Value',...) creates a new VENTANAINFORME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventanaInforme_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventanaInforme_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventanaInforme

% Last Modified by GUIDE v2.5 09-Sep-2019 19:36:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ventanaInforme_OpeningFcn, ...
                   'gui_OutputFcn',  @ventanaInforme_OutputFcn, ...
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


% --- Executes just before ventanaInforme is made visible.
function ventanaInforme_OpeningFcn(hObject, eventdata, handles, varargin)

global resultados
%diseño factible
if resultados.nroFaltaPoblacion(resultados.pesoMinimo(1,1),1) == 0
   set(handles.text3,'String','El diseño actual es factible')
   set(handles.text4,'String','Cumple con todas las restricciones')
   set(handles.text6,'String',resultados.pesoMinimo(1,2))
   %set(handles.text6,'String','Peso de la estructura')
else
    set(handles.text5,'String','')
    set(handles.text6,'String','')
end
%

% Choose default command line output for ventanaInforme
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ventanaInforme wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventanaInforme_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close;
tablasDatos;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close;
