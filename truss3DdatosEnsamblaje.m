function [cosDir,glsNodos] = truss3DdatosEnsamblaje(datosEstructura)
%[cosDir,glsNodos] = truss3DdatosEnsamblaje(datosEstructura)
%--------------------------------------------------------------------------
%Datos auxiliares para el ensamblaje de la matriz de rigidez
d = datosEstructura;
xr = d.coordenadas(d.conectividad(:,3),2) - d.coordenadas(d.conectividad(:,2),2);
yr = d.coordenadas(d.conectividad(:,3),3) - d.coordenadas(d.conectividad(:,2),3);
zr = d.coordenadas(d.conectividad(:,3),4) - d.coordenadas(d.conectividad(:,2),4);
landax = xr./d.longitudElementos(:,2);
landay = yr./d.longitudElementos(:,2);
landaz = zr./d.longitudElementos(:,2);
cosDir = [d.conectividad(:,1),landax,landay,landaz];
%Grados de libertad de los nodos de la estructura
g1 = 3.*d.coordenadas(:,1)-2;
g2 = 3.*d.coordenadas(:,1)-1;
g3 = 3.*d.coordenadas(:,1);
glsNodos = [d.coordenadas(:,1),g1,g2,g3];
%--------------------------------------------------------------------------