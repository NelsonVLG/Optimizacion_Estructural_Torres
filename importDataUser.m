function [datosExcel] = importDataUser
%Funcion para importar datos de un archivo excel que comtenga datos que no
%se importaron del sap
%Inicializamos un struct para guardar los datos extraidos
tablasExcel = struct;
%% Abrimos el archivo excel que deseamos importar
[nombreArchivo, pathArchivo] =  uigetfile({'*.xlsx'},'seleccione archivo Excel');
%direccion completa como nombre de archivo leido
nombreArchivo = strcat(pathArchivo,nombreArchivo);
%tabla de secciones(sortrows=>para ordenar la tabla de < a > respecto A)
secciones=sortrows(readtable(nombreArchivo,'sheet','secciones'),'A');
tablasExcel.secciones = secciones;
tablasExcel.material = readtable(nombreArchivo,'sheet','material');

%limites de esbeltez para diferentes elementos de la estructura
tablasExcel.esbeltez = sortrows(readtable(nombreArchivo,'sheet','esbeltez'),'idGrupo');
%% datos para calcular viento
tablasExcel.viento=readtable(nombreArchivo,'sheet','viento');
tablasExcel.vientoElementos=readtable(nombreArchivo,'sheet','vientoElementos');
tablasExcel.limiteDesplazamiento = readtable(nombreArchivo,'sheet','limiteDesplazamiento');
datosExcel = tablasExcel;

