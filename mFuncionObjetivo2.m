function [W,varargout] = mFuncionObjetivo2(posLista, datosEstructura,posGbest)
%[W,varargout] = mFuncionObjetivo2(posLista, datosEstructura,posGbest)
%--------------------------------------------------------------------------
%%Organización de datos
%--------------------------------------------------------------------------
d = datosEstructura;
nroParticulas = size(posLista,1);
At = zeros(d.nroElementos,2);
At(:,1) = (1:d.nroElementos)'; 
%--------------------------------------------------------------------------
% Análisis estructural de cada particula
%--------------------------------------------------------------------------
W = zeros(nroParticulas,1);
hfaltas = zeros(nroParticulas,1);
%Reduciendo t hacemos el analisis solo para gbest
pos = posLista(posGbest,:);
a1 = d.secciones.A(pos);
Ae = a1(d.grupos(:,1),1); %[nroElementos,1]
b1 = d.secciones.b(pos);
b = b1(d.grupos(:,1),1);
At(:,2) = Ae;
[cargasResultados] = analisisEstructural3D(datosEstructura,At,b);
%--------------------------------------------------------------------------
%Calificación de las particulas
%--------------------------------------------------------------------------
for i=1:nroParticulas       %para cada particula del enjambre        
    pos = posLista(i,:);
    a1 = d.secciones.A(pos);
    Ae = a1(d.grupos(:,1),1); %[nroElementos,1]
    r1 = d.secciones.rz(pos);
    rz = r1(d.grupos(:,1),1);
    At(:,2) = Ae;
    Windividual=(d.material.densidad).*Ae.*d.longitudElementos(:,2);  
    W(i,1)=sum(Windividual);    
    %----------------------------------------------------------------------
    %Restricciones
    %----------------------------------------------------------------------
    %Penalizacion de diseño    
    elementoFuerzaUsar = cargasResultados.envolvente.elementoFuerza; 
    desplazamientosUsar = cargasResultados.envolvente.desplazamientos;    
    [h] = mRestricciones3(pos,elementoFuerzaUsar,desplazamientosUsar,Ae,rz,d);    
    hfaltas(i,1) = h;
    penal = h*10000;
    W(i,1) = W(i,1) + penal;                
end
varargout{1} = cargasResultados;
varargout{2} = hfaltas;
%--------------------------------------------------------------------------
