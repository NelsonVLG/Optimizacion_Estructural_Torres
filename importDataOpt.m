function [datosOpt] = importDataOpt(edNPart, edWmin, edWmax, edCmin, edCmax, edIteMax)
%Funcion para guardar los de optimizacion que estan en la interfaz
%Inicializamos un struct para guardar los datos extraidos
datosOpt = struct;
%recogemos los datos de los parametros que necesitamos de la optimizacion
datosOpt.nparticulas = str2double(get(edNPart,'String'));
datosOpt.wmin = str2double(get(edWmin,'String'));
datosOpt.wmax = str2double(get(edWmax,'String'));
datosOpt.cmin = str2double(get(edCmin,'String'));
datosOpt.cmax = str2double(get(edCmax,'String'));
datosOpt.maxite = str2double(get(edIteMax,'String'));





