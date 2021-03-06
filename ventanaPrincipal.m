function varargout = ventanaPrincipal(varargin)
% VENTANAPRINCIPAL MATLAB code for ventanaPrincipal.fig
%      VENTANAPRINCIPAL, by itself, creates a new VENTANAPRINCIPAL or raises the existing
%      singleton*.
%
%      H = VENTANAPRINCIPAL returns the handle to a new VENTANAPRINCIPAL or the handle to
%      the existing singleton*.
%
%      VENTANAPRINCIPAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANAPRINCIPAL.M with the given input arguments.
%
%      VENTANAPRINCIPAL('Property','Value',...) creates a new VENTANAPRINCIPAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventanaPrincipal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventanaPrincipal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventanaPrincipal

% Last Modified by GUIDE v2.5 26-Aug-2019 15:51:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ventanaPrincipal_OpeningFcn, ...
                   'gui_OutputFcn',  @ventanaPrincipal_OutputFcn, ...
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


% --- Executes just before ventanaPrincipal is made visible.
function ventanaPrincipal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ventanaPrincipal (see VARARGIN)

% Choose default command line output for ventanaPrincipal
handles.output = hObject;

%Inicializamos algunas variables

%Inicializacom algunas funciones

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ventanaPrincipal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventanaPrincipal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ver_Callback(hObject, eventdata, handles)
% hObject    handle to ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function optimizacion_Callback(hObject, eventdata, handles)
% hObject    handle to optimizacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function resultados_Callback(hObject, eventdata, handles)
% hObject    handle to resultados (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function informeResultados_Callback(hObject, eventdata, handles)
ventanaInforme;


% --------------------------------------------------------------------
function parametrosPso_Callback(hObject, eventdata, handles)
% hObject    handle to parametrosPso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tablas_Callback(hObject, eventdata, handles)
tablasDatos;


% --------------------------------------------------------------------
function nuevo_Callback(hObject, eventdata, handles)
% hObject    handle to nuevo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function abrir_Callback(hObject, eventdata, handles)
%Variables globales
global datosSap2000 datosExcel datosOptimizacion datosEstructura datosOpt 
%Abrimos un archivo de datos matlab .m
[file, path] =  uigetfile({'*.mat'},'seleccione archivo');
name = fullfile(path,file);
load(name)

%habilitamos los botones inhabilitados
set(handles.pushbutton3,'Enable','on')
set(handles.pushbutton4,'Enable','on')


% --------------------------------------------------------------------
function guardarEntrada_Callback(hObject, eventdata, handles)
%Guardamos los datos de entrada en un archivo .mat
%Variables globales
global datosSap2000 datosExcel datosOptimizacion datosEstructura datosOpt 
[file,path] =  uiputfile({'datosEntrada.mat'},'Guardar');
name = fullfile(path,file);
save(name,'datosSap2000','datosExcel','datosOptimizacion','datosEstructura','datosOpt')


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Variables globales
global datosSap2000

% winopen('plantillaExcel.xlsx')
%Cargamos los datos excel del sap2000
datosSap2000 = importDataSap2000;
%save(file,'datosSap2000','-append')

%Habilatamos el siguiente boton de exportacion
set(handles.pushbutton3,'Enable','on')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%Variables globales
global datosExcel

%Cargamos los demas datos necesarios para la optimizacion
datosExcel = importDataUser;
set(handles.pushbutton4,'Enable','on')
%save(file,'datosExcel','-append')


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
%Ordenamos los datos de entrada
%Creamos algunas variables globales
global datosOptimizacion datosExcel datosSap2000 datosOpt datosEstructura
%funcion para tomar los datos de optimizacion
datosOptimizacion = importDataOpt(handles.edNPart, handles.edWmin, handles.edWmax, handles.edCmin, handles.edCmax, handles.edIteMax);

%Ordenamos los datos importados
[datosEstructura,datosOpt] = organizarDatos(datosSap2000, datosExcel, datosOptimizacion);

% Habilitamos los botones para el grafico
set(handles.pushbutton5,'Enable','on')
set(handles.togglebutton1,'Enable','on')
set(handles.togglebutton2,'Enable','on')
set(handles.pushbutton8,'Enable','on')
%Habilitamos el boton de guardar datos entrada
set(handles.guardarEntrada,'Enable','on')



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Variables globales de la interfaz
global datosOpt datosEstructura resultados gG

[ds] = mpso2(datosOpt, datosEstructura, gG)
resultados = ds;

%Habilitamos la opcion de guardar resultados
set(handles.guardarResultados,'enable','on')

set(handles.tablas,'Enable','on')
set(handles.informeResultados,'Enable','on')
%Abrimos la ventana informe
ventanaInforme;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
%Variables globales
global datosEstructura datosOpt coorsIni coorsFin gG etFrame etNodo
%Grafico de la Estructura
[coorsIni, coorsFin, gG] = graficas3D(datosEstructura, datosOpt.nvariables);

%Habilitamos el menu de grupos
g1 = {'All'};
g2 = strseq('',(1:datosOpt.nvariables));
gr = [g1;g2];
set(handles.popupmenu1,'String',gr)

set(handles.popupmenu1,'Enable','on')

%Creamos la etiqueta para los frames
etFrame = graficaEtiquetaFrame(datosEstructura, coorsIni, coorsFin);
set(etFrame,'Visible','off')

%Creamos las etiquetas de los nodos
etNodo = graficaEtiquetaNodo(datosEstructura);
set(etNodo,'Visible','off')


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function datosSalida_Callback(hObject, eventdata, handles)



function edNPart_Callback(hObject, eventdata, handles)
% hObject    handle to edNPart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edNPart as text
%        str2double(get(hObject,'String')) returns contents of edNPart as a double


% --- Executes during object creation, after setting all properties.
function edNPart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edNPart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edWmin_Callback(hObject, eventdata, handles)
% hObject    handle to edWmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edWmin as text
%        str2double(get(hObject,'String')) returns contents of edWmin as a double


% --- Executes during object creation, after setting all properties.
function edWmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edWmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edWmax_Callback(hObject, eventdata, handles)
% hObject    handle to edWmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edWmax as text
%        str2double(get(hObject,'String')) returns contents of edWmax as a double


% --- Executes during object creation, after setting all properties.
function edWmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edWmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edCmin_Callback(hObject, eventdata, handles)
% hObject    handle to edCmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edCmin as text
%        str2double(get(hObject,'String')) returns contents of edCmin as a double


% --- Executes during object creation, after setting all properties.
function edCmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edCmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edCmax_Callback(hObject, eventdata, handles)
% hObject    handle to edCmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edCmax as text
%        str2double(get(hObject,'String')) returns contents of edCmax as a double


% --- Executes during object creation, after setting all properties.
function edCmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edCmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edIteMax_Callback(hObject, eventdata, handles)
% hObject    handle to edIteMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edIteMax as text
%        str2double(get(hObject,'String')) returns contents of edIteMax as a double


% --- Executes during object creation, after setting all properties.
function edIteMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edIteMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function graficos_Callback(hObject, eventdata, handles)
% hObject    handle to graficos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
%Def var globales
global datosEstructura datosOpt gG
%Visualizacion de la estructura por grupos
v = get(hObject,'Value');
nvar = datosOpt.nvariables;
switch v
    case 1
        %En el caso de solo color
%         lt = zeros(size(datosEstructura.conectividad,1),1);        
        lt = [];
        for i = 1:nvar
            lt = [lt;gG{i}.Children(:,1)];            
        end
        set(lt,'Color','b','LineWidth',1)
    otherwise
        %1ro devolvemos a todos a un mismo color
        lt = [];
        for i = 1:nvar
            lt = [lt;gG{i}.Children(:,1)];
        end
        set(lt,'Color','b','LineWidth',1);
        %2do visibilizamos solo el grupo que queremos
        ngr = v-1;       
        lt = gG{ngr}.Children(:,1);
        set(lt,'Color','y','LineWidth',2);
end

%PARA OCULTAR Y MOSTRAR LOS DIFERENTES GRUPOS DE LA ESTRUCTURA
% switch v
%     case 1
%         for i = 1:nvar
%             gG{i}.Visible = 'on';
%         end
%     otherwise
%         %1ro ocultamos todos los grupos
%         for i = 1:nvar
%             gG{i}.Visible = 'off';
%         end
%         %2do visibilizamos solo el grupo que queremos
%         ngr = v-1;
%         gG{ngr}.Visible = 'on';
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        

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


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
valor = get(hObject,'Value');
%Variables globales
global datosEstructura coorsIni coorsFin etFrame
if valor == 1
    set(etFrame,'Visible','on')
else
    set(etFrame,'Visible','off')
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
valor = get(hObject,'Value');
%Variables globales
global datosEstructura etNodo
if valor == 1
    set(etNodo,'Visible','on')
else
    set(etNodo,'Visible','off')
end


% --------------------------------------------------------------------
function guardarResultados_Callback(hObject, eventdata, handles)
%guardarentrada resultados de la optimizacion
%Variables globales
global resultados
[file,path] =  uiputfile({'resultadosOptimizacion.mat'},'Guardar');
name = fullfile(path,file);
save(name,'resultados')


% --------------------------------------------------------------------
function salir_Callback(hObject, eventdata, handles)
close;
