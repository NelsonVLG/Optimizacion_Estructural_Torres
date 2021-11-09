function [h] = mRestricciones3(pos,elementoFuerzaUsar,desplazamientosUsar,Ae,rz,datosEstructura)
%[h] = mRestricciones3(pos,elementoFuerzaUsar,desplazamientosUsar,Ae,rz,datosEstructura)
%--------------------------------------------------------------------------
%Funcion para determinar nro de faltas de la estructura
%--------------------------------------------------------------------------
d = datosEstructura;
Fy = d.material.fy;
Fu = d.material.fu;
E1 = d.material.E;  
L = d.longitudElementos(:,2);
%Factor de longitud efectiva
K = 1; %modelo de nudos articulados
%--------------------------------------------------------------------------
%Resistencia nominal de las secciones de estructura a traccion y compresion
[Pu,Puc] = mTraccionCompresion(d.nroElementos,Ae,L,rz,Fy,Fu,E1);
%--------------------------------------------------------------------------
%RESTRICCIONES
%--------------------------------------------------------------------------
%Tenemos 4 restricciones por variables 
nroVar = size(pos,2);
%Inicializamos variables que se usan en el ciclo
grTmax = zeros(1,nroVar);
pT = zeros(1,nroVar);
compC = zeros(1,nroVar);
LmaxGrupo = zeros(1,nroVar);
for cont = 1:nroVar
    grVar = d.grupos(d.grupos(:,1)==cont,2);
    %----------------------------------------------------------------------
    %Traccion    
    tenGrupo = elementoFuerzaUsar(grVar,3);
    maxTension = max(tenGrupo);
    if maxTension < 0
        maxTension = 0;
    end
    grTmax(1,cont) = maxTension; 
    pT(1,cont) = Pu(grVar(1,1),1);
    %----------------------------------------------------------------------
    %Compresion    
    comGrupo = elementoFuerzaUsar(grVar,2);
    resComGrupo = Puc(grVar,1).*(-1);
    compCgr =comGrupo<resComGrupo;
    compCelem = max(compCgr);  
    compC(1,cont) = compCelem; 
    %----------------------------------------------------------------------
    %esbeltez elemental
    longGrupo = L(grVar,1);    
    maxLong = max(longGrupo);
    LmaxGrupo(1,cont) = maxLong;    
end
%--------------------------------------------------------------------------
%Restricciones a traccion
compT = grTmax>pT;

%Restricciones a esbeltez local
bl = d.secciones.b(pos');
tl = d.secciones.t(pos');
aux1 = bl./tl;
aux2 = 0.45*(E1/Fy)^(1/2);  %ecuacion varia dependiendo de la seccion
compEsbL = (aux1>aux2)';
%Restricciones a esbeltez elemental
relEsbeltez = K*LmaxGrupo./d.secciones.rz(pos,1)';
compEsbElem = relEsbeltez>d.esbeltez.limEsb';
%--------------------------------------------------------------------------
%RESTRICCIONES A LAS VARIABLES
%--------------------------------------------------------------------------
comp = [compT;compC;compEsbL;compEsbElem];
hcomp = sum(comp);
h = sum(hcomp);
%--------------------------------------------------------------------------
%Otros tipos de restriccion
%--------------------------------------------------------------------------
%Restricciones a desplazamiento
if ~isempty(d.limiteDesplazamiento)
    indNodos = d.limiteDesplazamiento.nodo;    
    limDmax = d.limiteDesplazamiento.limDesplazamiento;
    dmaxNodos = max(abs(desplazamientosUsar(indNodos,2:4)),[],2);
    compDmax = dmaxNodos>limDmax;
    hcompDmax = sum(compDmax);
    h = h + hcompDmax;
end
%--------------------------------------------------------------------------




