function varargout = tablasDatos(varargin)
% TABLASDATOS MATLAB code for tablasDatos.fig
%      TABLASDATOS, by itself, creates a new TABLASDATOS or raises the existing
%      singleton*.
%
%      H = TABLASDATOS returns the handle to a new TABLASDATOS or the handle to
%      the existing singleton*.
%
%      TABLASDATOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLASDATOS.M with the given input arguments.
%
%      TABLASDATOS('Property','Value',...) creates a new TABLASDATOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tablasDatos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tablasDatos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tablasDatos

% Last Modified by GUIDE v2.5 11-Jun-2019 15:33:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tablasDatos_OpeningFcn, ...
                   'gui_OutputFcn',  @tablasDatos_OutputFcn, ...
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


% --- Executes just before tablasDatos is made visible.
function tablasDatos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tablasDatos (see VARARGIN)

% Choose default command line output for tablasDatos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tablasDatos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tablasDatos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% %Cargamos los datos de la tablas
% load datos1.mat;
% load resultados.mat;
%Variables globales
global datosExcel datosOptimizacion datosSap2000 resultados
set(handles.uitable3,'Visible','on')
valor = get(hObject,'Value');

ds = resultados;

%Separando datos de entrada y salida
v = get(handles.popupmenu2,'Value');
if v == 1
    switch valor
        case 1
            set(handles.uitable3,'Data',table2cell(datosSap2000.coordenadas));        
            set(handles.uitable3,'ColumnName',datosSap2000.coordenadas.Properties.VariableNames);
        case 2
            set(handles.uitable3,'Data',table2cell(datosSap2000.conectividad));
            set(handles.uitable3,'ColumnName',datosSap2000.conectividad.Properties.VariableNames);
        case 3
            set(handles.uitable3,'Data',table2cell(datosSap2000.restricciones));
            set(handles.uitable3,'ColumnName',datosSap2000.restricciones.Properties.VariableNames);
        case 4
            set(handles.uitable3,'Data',table2cell(datosSap2000.cargas));
            set(handles.uitable3,'ColumnName',datosSap2000.cargas.Properties.VariableNames);
        case 5
            set(handles.uitable3,'Data',table2cell(datosSap2000.grupos));
            set(handles.uitable3,'ColumnName',datosSap2000.grupos.Properties.VariableNames);
        case 6
            set(handles.uitable3,'Data',table2cell(datosSap2000.patronCarga));
            set(handles.uitable3,'ColumnName',datosSap2000.patronCarga.Properties.VariableNames);
        case 7
            set(handles.uitable3,'Data',table2cell(datosSap2000.combCarga));
            set(handles.uitable3,'ColumnName',datosSap2000.combCarga.Properties.VariableNames);
        case 8
            set(handles.uitable3,'Data',table2cell(datosExcel.secciones));
            set(handles.uitable3,'ColumnName',datosExcel.secciones.Properties.VariableNames);
        case 9
            set(handles.uitable3,'Data',table2cell(datosExcel.material));
            set(handles.uitable3,'ColumnName',datosExcel.material.Properties.VariableNames);
        case 10
            set(handles.uitable3,'Data',table2cell(datosExcel.esbeltez));
            set(handles.uitable3,'ColumnName',datosExcel.esbeltez.Properties.VariableNames);
        case 11
            set(handles.uitable3,'Data',table2cell(datosExcel.viento));
            set(handles.uitable3,'ColumnName',datosExcel.viento.Properties.VariableNames);
        case 12
            set(handles.uitable3,'Data',table2cell(datosExcel.vientoElementos));
            set(handles.uitable3,'ColumnName',datosExcel.vientoElementos.Properties.VariableNames);
    end
else
    switch valor
        case 1
            set(handles.uitable3,'Data',table2cell(ds.secciones));        
            set(handles.uitable3,'ColumnName',ds.secciones.Properties.VariableNames);
        case 2
            set(handles.uitable3,'Data',ds.cargasResultados.envolvente.elementoFuerza);
            set(handles.uitable3,'ColumnName',{' Elemento ' ' Fmin ' 'Fmax'})
        case 3
            set(handles.uitable3,'Data',ds.cargasResultados.envolvente.desplazamientos);
            set(handles.uitable3,'ColumnName',{' Gsl ' ' U1 ' 'U2' 'U3'})
        case 4
            set(handles.uitable3,'Data',ds.poblacion);             
            nom = strseq('A',(1:size(ds.poblacion,2))');
            set(handles.uitable3,'ColumnName',nom)
        case 5
            set(handles.uitable3,'Data',ds.pesoPoblacion);
            set(handles.uitable3,'ColumnName',{' Peso '})
        case 6
            set(handles.uitable3,'Data',ds.pbest);             
            nom = strseq('A',(1:size(ds.pbest,2))');
            set(handles.uitable3,'ColumnName',nom)
        case 7
            set(handles.uitable3,'Data',ds.gbest);             
            nom = strseq('A',(1:size(ds.gbest,2))');
            set(handles.uitable3,'ColumnName',nom)
        case 8
            set(handles.uitable3,'Data',ds.pesoIteracion)
            set(handles.uitable3,'ColumnName',{' PesoPorIteracion '})
        case 9
            set(handles.uitable3,'Data',ds.nroFaltaPoblacion);
            set(handles.uitable3,'ColumnName',{' NdeFaltas '})
        case 10
            set(handles.uitable3,'Data',ds.pesoMinimo);             
            set(handles.uitable3,'ColumnName',{' Particula' 'PesoMinimo '})
    end
end

%Habilitamos el boton para exportar tabla
set(handles.pushbutton1,'Enable','on')

% switch valor
%     case 1
%         set(handles.uitable3,'Data',datosSap2000.coordenadas);        
%         set(handles.uitable3,'ColumnName',{'Joint' 'x' 'y' 'z'})
%     case 2
%         set(handles.uitable3,'Data',datosSap2000.conectividad);
%         set(handles.uitable3,'ColumnName',{'Frame' 'JointI' 'JointJ'})
%     case 3
%         set(handles.uitable3,'Data',datosEstructura.restricciones);
%         set(handles.uitable3,'ColumnName',{'Joint' 'U1' 'U2' 'U3'})
%     case 4
%         set(handles.uitable3,'Data',datosEstructura.coordenadas);
%     case 5
%         set(handles.uitable3,'Data',datosEstructura.grupos);
%         set(handles.uitable3,'ColumnName',{'GroupName' 'Element'})
%     case 6
%         set(handles.uitable3,'Data',table2cell(datosEstructura.patronCarga));
%         set(handles.uitable3,'ColumnName',datosEstructura.patronCarga.Properties.VariableNames);
%     case 7
%         set(handles.uitable3,'Data',table2cell(datosEstructura.combCarga));
%         set(handles.uitable3,'ColumnName',datosEstructura.combCarga.Properties.VariableNames);
%     case 8
%         set(handles.uitable3,'Data',table2cell(datosEstructura.secciones));
%         set(handles.uitable3,'ColumnName',datosEstructura.secciones.Properties.VariableNames);
%     case 9
%         set(handles.uitable3,'Data',table2cell(datosEstructura.material));
%         set(handles.uitable3,'ColumnName',datosEstructura.material.Properties.VariableNames);
%     case 10
%         set(handles.uitable3,'Data',table2cell(datosEstructura.esbeltez));
%         set(handles.uitable3,'ColumnName',datosEstructura.esbeltez.Properties.VariableNames);
%     case 11
%         set(handles.uitable3,'Data',table2cell(datosEstructura.viento));
%         set(handles.uitable3,'ColumnName',datosEstructura.viento.Properties.VariableNames);
%     case 12
%         set(handles.uitable3,'Data',table2cell(datosEstructura.vientoElementos));
%         set(handles.uitable3,'ColumnName',datosEstructura.vientoElementos.Properties.VariableNames);
% end

%Para volver editable las tablas
% dd = get(handles.uitable3,'Data');
% tam = size(dd,2);
% set(handles.uitable3,'ColumnEditable',true(1, tam))


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Exportamos la tabla a un excel
nomVar = (get(handles.uitable3,'ColumnName'))';
datosTabla = get(handles.uitable3,'Data');
%Comprobar si no son cell para no tener errores 
if ~iscell(datosTabla)
    datosTabla = num2cell(datosTabla);
end

T = cell2table(datosTabla,'VariableNames',nomVar);
%Proc para exportar a un excel
[file,path] =  uiputfile({'Libro1.xlsx'},'Exportar tabla como');
name = fullfile(path,file);
writetable(T,name,'Sheet',1);
winopen(name);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close;



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
valor1 = get(hObject,'Value');
set(handles.popupmenu1,'Value',1);
if valor1 == 1    
    tablas = {'Coordenadas';'Conectividad';'Restricciones';'Cargas';'Grupos';...
        'Patrones de carga';'Combinaciones de carga';'Secciones';...
        'Material';'Limitez de esbeltez';'Cargas de viento';...
        'Viento sobre los elementos'};
else    
    tablas = {'Secciones';'Fuerza elementos';'Desplazamientos';'Poblacion';...
        'Peso poblacion';'pbest';'gbest';'Peso por iteracion';'Numero de faltas';'Peso Minimo'};
end
set(handles.popupmenu1,'String',tablas)



% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
