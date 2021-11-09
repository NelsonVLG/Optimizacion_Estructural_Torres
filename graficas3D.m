function [coorsIni, coorsFin, gG] = graficas3D(datosEstructura,nvariables)
%Funcion para graficar la estructura
d = datosEstructura;
% nvariables = datosOpt.nvariables;
%global coorsIni coorsFin;
%% obtener puntos
coordenadas=d.coordenadas;
conectividad=d.conectividad;
nroElementos=size(conectividad,1);
coorsIni=zeros(nroElementos,4);
coorsFin=zeros(nroElementos,4);
for i=1:nroElementos
    id1=conectividad(i,2);
    id2=conectividad(i,3);
    coorsIni(i,:)=coordenadas(id1,:);
    coorsFin(i,:)=coordenadas(id2,:);
end

%% Creamos grupos para almacenar lineas
gG = cell(nvariables,1);
for contG = 1:nvariables
    gG{contG} = hggroup;
end

%% graficar
% figure(1),
hold on
%%
for cont=1:nroElementos
    vx=[coorsIni(cont,2),coorsFin(cont,2)];
    vy=[coorsIni(cont,3),coorsFin(cont,3)];
    vz=[coorsIni(cont,4),coorsFin(cont,4)];
%     plot3(vx,vy,vz,'Color',[1 0 0]);        
    plot3(vx,vy,vz,'b','Parent',gG{d.grupos(cont,1)},'LineWidth',1);
end    
title('Vista 3D de la estructura')
xlabel('Eje X')
ylabel('Eje Y')
zlabel('Eje Z')
view([39 26]);
% view(0,90);
hold off  ;
axis('equal');

% %% graficar
% %figure(1),
% hold on
% for cont=1:nroElementos
%     vx=[coorsIni(cont,2),coorsFin(cont,2)];
%     vy=[coorsIni(cont,3),coorsFin(cont,3)];
%     vz=[coorsIni(cont,4),coorsFin(cont,4)];
%     plot3(vx,vy,vz,'Color',[1 0 0]);        
% end    
% title('Vista 3D de la estructura')
% xlabel('Eje X')
% ylabel('Eje Y')
% zlabel('Eje Z')
% view([39 26]);
% hold off  ;
% axis('equal');
%  
        
