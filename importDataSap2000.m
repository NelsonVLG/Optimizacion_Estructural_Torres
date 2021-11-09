function [datosSap2000] = importDataSap2000
% Guardar en una archivo .mat los datos de extraidos de un excel sacado de
% sap2000
%% Abrir un excel previamente exportado de sap2000
[nombreArchivo, pathArchivo] =  uigetfile({'*.xlsx'},'seleccione archivo Excel');
%direccion completa como nombre de archivo leido
nombreArchivo = strcat(pathArchivo,nombreArchivo);
%Inicializamos un struct para guardar los datos extraidos
tablasExcel = struct;
% Extraer todos los datos necesarios de ese excel
%% Procedimiento para realizar un loop para leer todo lo que necesitamos de las hojas excel
%Definimos los datos necesarios para la correcta importacion
nombreHojas = {'Connectivity - Frame','Groups 2 - Assignments',...
               'Joint Coordinates','Joint Loads - Force',...
               'Joint Restraint Assignments','Load Pattern Definitions'...
               'Combination Definitions'};
nombreCampos = {'conectividad','grupos','coordenadas','cargas',...
                'restricciones','patronCarga','combCarga'};
camposNecesarios = {{'Frame','JointI','JointJ'},{'GroupName','ObjectType','ObjectLabel'},...
    {'Joint','GlobalX','GlobalY','GlobalZ'},{'Joint','LoadPat','F1','F2','F3'},...
    {'Joint','U1','U2','U3'},{'LoadPat','DesignType','SelfWtMult'},...
    {'ComboName','CaseName','ScaleFactor'}};
tiposVariables = {{'double','double','double'},{'double','char','double'},...
    {'double','double','double','double'},{'double','char','double','double','double'},...
    {'double','char','char','char'},{'char','char','double'},{'char','char','double'}};
    
numHojas = size(nombreHojas,2);
for i=1:numHojas
    hoja = nombreHojas{i};
    opts = detectImportOptions(nombreArchivo, 'sheet', hoja);
    opts.VariableNamesRange = 'A2';
    opts.DataRange = 'A4';    
    opts = setvartype(opts,camposNecesarios{i},tiposVariables{i});
    T = readtable(nombreArchivo, opts);    
    %creando nueva tabla solo con los datos neceasarios
    tNew = table();
    numCamp = size(camposNecesarios{i},2);
    for j=1:numCamp
        tNew.(camposNecesarios{i}{j}) = T.(camposNecesarios{i}{j});     
        %tNew.(camposNecesarios{i}{j}) = str2double(tNew.(camposNecesarios{i}{j}));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    newNombreHoja = nombreCampos{i};
    tablasExcel.(newNombreHoja) = tNew;
end

% Correccion de datos leidos
%GRUPOS
tbl = tablasExcel.grupos;
% Convertir a categórico ya que supongo que esto es valores recurrentes
tbl.ObjectType = categorical(tbl.ObjectType);
% Indice filas con las variables correctas en la columna
idx = tbl.ObjectType == 'Frame';
% crear tabla basada en el índice
newtbl = tbl(idx,:);
newtbl.ObjectType = [];
tablasExcel.grupos = newtbl;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datosSap2000 = tablasExcel;

%USAR COMO EJEMPLO
%el archivo excel tablaSap200.xlsx o cualquier otro que sea exportado
%directamente de sap y que se haya modelado con todas las especificacion
%necesarias (min=>7campos)

%AYUDAS
% Importacion de datos de excel
% Primero definir las opciones de importacion y escoger la hoja que se
% importara
% opts=detectImportOptions(nombreArchivo, 'sheet','Combination Definitions');
% opts.VariableNamesRange = 'A2';%propiedad modificada una vez ya leida la hoja excel
% opts.DataRange = 'A4';
% T = readtable(nombreArchivo,opts);
%para cambiar el tipo de alguna columna de la tabla antes de la importacion
% opts = setvartype(opts,{'Joint'},'double');


    
    
