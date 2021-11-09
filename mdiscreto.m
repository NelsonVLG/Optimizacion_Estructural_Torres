function [X,posLista]=mdiscreto(X,datosEstructura)
%% 
d = datosEstructura;
[fil,col]=size(X);
A = d.secciones.A;
E1 = d.material.E;
Fy = d.material.fy;

%restricciones a esbeltez local
bl = d.secciones.b;
tl = d.secciones.t;
aux1 = bl./tl;
aux2 = 0.45*(E1/Fy)^(1/2);  % W 0.56*(E1/Fy);esta ecuacion varia dependiendo de la seccion
compEsbL = (aux1>aux2);
A(compEsbL==1,1) = 0;    %%%%cambio de areas esbeltez
%posLista para guardar las posiciones en y no tener que buscar
posLista=zeros(fil,col);
for i=1:fil
    for j=1:col
        valor=X(i,j);
        res=abs(A-valor);
        [~,pos]=min(res);
        X(i,j)=A(pos,1);
        posLista(i,j)=pos;
    end
end

