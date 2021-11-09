function [cargasViento]=trussViento3D(lista,b,pV,datosEstructura,dirF)
%funcion para repartir la fuerza en los elementos afectados
d = datosEstructura;
%%
%Calcular el peso por elemento
bElementos = b(lista,:);
lElementos = d.longitudElementos(lista,2);
fViento = pV*bElementos.*lElementos;
%calculamos las cargas en los nodos
nds = unique([d.conectividad(lista,2);d.conectividad(lista,3)]);
vF = zeros(d.nroNodos,4);
vF(:,1) = d.coordenadas(:,1);
nroElista = size(lista,1);
if dirF == 'x'
    col = 2;
elseif dirF == 'y'
    col = 3;
end
for cont = 1:nroElista
    i = d.conectividad(lista(cont,1),2);
    j = d.conectividad(lista(cont,1),3);
    %restamos porque el peso va hacia abajo
    vF(i,col) = vF(i,col) + fViento(cont,1)/2; 
    vF(j,col) = vF(j,col) + fViento(cont,1)/2; 
end
vFe = vF(nds,:);
cargasViento = vFe;

