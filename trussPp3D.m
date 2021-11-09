function [cargasPp]=trussPp3D(datosEstructura,A,densidad)
%[FpesoPropio]=FpesoPropioArmadura3D(conectividad,longitudElementos,nroElementos,A,densidad)
d = datosEstructura;
%%
%Calcular el peso por elemento
pesoElementos = densidad*A(:,2).*d.longitudElementos(:,2);
%calculamos las cargas en los nodos
pP = zeros(d.nroNodos,4);
pP(:,1) = (1:d.nroNodos)';
for cont = 1:d.nroElementos
    i = d.conectividad(cont,2);
    j = d.conectividad(cont,3);
    %restamos porque el peso va hacia abajo
    pP(i,4) = pP(i,4) - pesoElementos(cont,1)/2; 
    pP(j,4) = pP(j,4) - pesoElementos(cont,1)/2; 
end
cargasPp = pP;





