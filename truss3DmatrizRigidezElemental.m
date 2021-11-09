function [matrizElemental] = truss3DmatrizRigidezElemental(E,A,L,landax,landay,landaz)
%[matrizElemental] = truss3DmatrizRigidezElemental(E,A,L,landax,landay,landaz)
%--------------------------------------------------------------------------
%Calculo de matriz de rigidez de un elemento
Cx = landax;
Cy = landay;
Cz = landaz;
w = [Cx*Cx Cx*Cy Cx*Cz ; Cy*Cx Cy*Cy Cy*Cz ; Cz*Cx Cz*Cy Cz*Cz];
matrizElemental = E*A/L*[w -w ; -w w];
%--------------------------------------------------------------------------