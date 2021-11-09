function [longitudElementos]=truss3DLongitudElementos(datosEstructura)
%% Longitud de los elementos
d = datosEstructura;
%% 
xr = d.coordenadas(d.conectividad(:,3),2) - d.coordenadas(d.conectividad(:,2),2);
yr = d.coordenadas(d.conectividad(:,3),3) - d.coordenadas(d.conectividad(:,2),3);
zr = d.coordenadas(d.conectividad(:,3),4) - d.coordenadas(d.conectividad(:,2),4);
num = (1:d.nroElementos)';
longitudElementos = [num, (xr.*xr + yr.*yr + zr.*zr).^(1/2)];

