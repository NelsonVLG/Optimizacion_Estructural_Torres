function [desplazamientos,elementoFuerza] = truss3D(datosEstructura,cargas,A)
%[desplazamientos,elementoFuerza] = truss3D(datosEstructura,cargas,A)
%--------------------------------------------------------------------------
d = datosEstructura;
%-------------------------------------------------------------------------- 
[cosDir,glsNodos] = truss3DdatosEnsamblaje(datosEstructura);
%Calculamos la matriz global del elemento
nroGls = d.nroNodos*3;
matrizGlobal = zeros(nroGls,nroGls);
for cont = 1:d.nroElementos
    %Matriz de rigidez elemental
    Em = d.Eelementos(cont,2);
    Am = A(cont,2);
    Lm = d.longitudElementos(cont,2);
    landax = cosDir(cont,2);
    landay = cosDir(cont,3);
    landaz = cosDir(cont,4);
    [matrizElemental] = truss3DmatrizRigidezElemental(Em,Am,Lm,landax,landay,landaz);
    %Ensamblamos a la matriz global de la estructura
    cI = d.conectividad(cont,2);
    cJ = d.conectividad(cont,3);
    [matrizGlobal] = truss3Densamblaje(matrizGlobal,matrizElemental,cI,cJ);
end
%Ordenar la matriz para realizar los calculos necesarios
Qt = zeros(nroGls,2);
Qt(:,1) = (1:nroGls)';
glsCargas = glsNodos(cargas(:,1),(2:4));
cCargas = reshape(cargas(:,2:4)',1,[])';
glsC = reshape(glsCargas',1,[])';
Qt(glsC,2) = cCargas;

glsRestricciones = glsNodos(d.restricciones(:,1),(2:4));
cRestricciones = reshape(d.restricciones(:,2:4)',1,[])';
glsR = reshape(glsRestricciones',1,[])';
%Verificar si existe un apoyo movil
glsR(cRestricciones == 0) = [];
%Calculamos Qc y Dc
Qc = Qt;
Qc(glsR,:) = [];
Dc = [glsR,zeros(size(glsR,1),1)]; %desplaz en los apoyos es cero
%Calculamos K11
K11 = matrizGlobal;
K11(glsR,:) = [];
K11(:,glsR) = [];
%Calculamos K21
K21 = matrizGlobal;
K21 = K21(glsR,Qc(:,1));
%Desplazamientos y reacciones desconocidas
Dd = [Qc(:,1),K11\Qc(:,2)];
Qd = [glsR,K21*Dd(:,2)];  
%Desplazamientos y reacciones de la estructura
Dtotal = [Dd;Dc];
Qtotal = [Qc;Qd];
Dtotal = sortrows(Dtotal,1);
Qtotal = sortrows(Qtotal,1);
%Fuerza interna en los elementos
gf = zeros(d.nroElementos,2);
gf(:,1) = d.conectividad(:,1);
for cont = 1:d.nroElementos
    Ae = A(cont,2);
    Ee = d.Eelementos(cont,2);
    Le = d.longitudElementos(cont,2);
    lxyz = [-cosDir(cont,2:4),cosDir(cont,2:4)];
    despN = glsNodos(d.conectividad(cont,2),2:4)';
    despF = glsNodos(d.conectividad(cont,3),2:4)';
    desplaGls = Dtotal([despN;despF],2); 
    gf(cont,2) = (Ae*Ee/Le)*lxyz*desplaGls;
end
%Resulatados finales
desplNodos = reshape(Dtotal(:,2),3,[]);
desplazamientos = [d.coordenadas(:,1),desplNodos'];
elementoFuerza = gf;
%--------------------------------------------------------------------------

    


