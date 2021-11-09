function [datosEstructura,varargout] = organizarDatos(datosSap2000, varargin)
% function [datosEstructura,datosOpt] = organizarDatos(datosSap2000, datosExcel, datosOpt)
%funcion para organizar todos los datos que seran necesarios
%Nro de parametros de entrada
nin = nargin - 1;
%Empezamos a organizar todos los datos
%% Datos Analisis y diseño
%Por ahora vamos a ordenar los datos del sap2000 de forma que sea igual a
%como estaba anteriormente en forma de matrices
%Inicializamos struct para guardar datos
estructura = struct;

%Coordenadas
estructura.coordenadas = table2array(datosSap2000.coordenadas);

%Conectividad
estructura.conectividad = table2array(datosSap2000.conectividad);

%Restricciones
restric = datosSap2000.restricciones{:,2:4};
conver = ismember(restric,'Yes');
estructura.restricciones = [datosSap2000.restricciones.Joint,conver];

% Cargas
[patronesCarga,~,jp] = unique(datosSap2000.cargas.LoadPat);
nroPatron = size(patronesCarga,1);
%Obtamos por un struct para el mejor control de las cargas
cargasT = struct;
%cargaT = cell(nroPatron,1);
%para los demas casos de carga
for cont=1:nroPatron
    pos = find(jp==cont);
    cargas = datosSap2000.cargas(pos,:);
    cargas.LoadPat = [];
    cargasT.(patronesCarga{cont}) = table2array(cargas);
end
estructura.cargas = cargasT;

% Grupos
datosSap2000.grupos = sortrows(datosSap2000.grupos,'ObjectLabel');
estructura.grupos = table2array(datosSap2000.grupos);

% Patrones de carga
estructura.patronCarga = datosSap2000.patronCarga;

% Combinaciones de carga
estructura.combCarga = datosSap2000.combCarga;

% Algunos datos necesarios para toda la estructura
% numero de elementos
estructura.nroElementos = size(estructura.conectividad,1);
% numero de nodos
estructura.nroNodos = size(estructura.coordenadas,1);
% longitud de todos los elementos
estructura.longitudElementos = truss3DLongitudElementos(estructura);

for i = 1:nin
    if i == 1
        datosExcel = varargin{i};
        %% Completamos los datos con los datos de excel
        estructura.secciones = datosExcel.secciones;
        estructura.material = datosExcel.material;
        estructura.esbeltez = datosExcel.esbeltez;
        estructura.viento = datosExcel.viento;
        estructura.vientoElementos = datosExcel.vientoElementos;
        estructura.limiteDesplazamiento = datosExcel.limiteDesplazamiento;
        %Ya que el modulo de elasticidad es nuestro caso no cambia entre
        %cada iteracion añadimos como otro dato 
        nroElementos = size(estructura.conectividad,1);
        E=ones(nroElementos,2);
        E(:,1)=E(:,1).*(1:nroElementos)';
        E(:,2)=E(:,2)*estructura.material.E;
        estructura.Eelementos = E;
        % esbeltez de todos los elementos
        e1 = estructura.conectividad(:,1);
        e2 = estructura.esbeltez.limEsb(estructura.grupos(:,1),:);
        estructura.esbeltezElementos = [e1,e2];
    end
    if i == 2
        %% Datos Optimizacion
        datosOpt = varargin{i};
        cmin = datosOpt.cmin ;
        datosOpt.cmin = [cmin cmin];
        cmax = datosOpt.cmax ;
        datosOpt.cmax = [cmax cmax];
        %definimos datos dependientes de otras struct
        datosOpt.nvariables = size(unique(datosSap2000.grupos(:,1)),1);
        %Limites por donde se moveran la particulas q depende de nro de variables
        secMin=datosExcel.secciones.A(1,1);
        secMax=datosExcel.secciones.A(end,1);
        datosOpt.LB=secMin*ones(1,datosOpt.nvariables);
        datosOpt.UB=secMax*ones(1,datosOpt.nvariables);
        varargout{1} = datosOpt;
    end
end
datosEstructura = estructura;



% EJEM
% solo sap2000
% [datosEstructura] = organizarDatos(datosSap2000)
% sap mas tabla2 secciones y materiales
% [datosEstructura] = organizarDatos(datosSap2000, datosExcel)
% todos los datos
% [datosEstructura,datosOpt] = organizarDatos(datosSap2000, datosExcel, datosOpt)

