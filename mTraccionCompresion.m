function [Pu,Puc] = mTraccionCompresion(nroElementos,Ag,L,r,Fy,Fu,E1)
%[Pu,Puc]=mTraccionCompresion(Fy,Fu,Ag,E1,L,r)
%funcion de verificacion de una seccion para traccion y compresion
K=1;
%--------------------------------------------------------------------------
%Verficacion a resistencia a TRACCION
%1)para fluencia en traccion en seccion bruta
Pn1 = Fy*Ag;
coeft = 0.9;
Put(:,1) = Pn1*coeft;
%2)para fractura en traccion en la seccion neta
%Ae=1*Ag ;                  %segun la norma este valor podria se 0.75 asi q por el momento estamos variando
Ae = 0.75*Ag; %aisc table 5-2
Pn2 = Fu*Ae;
coeft2 = 0.75;
Put(:,2) = Pn2*coeft2;
%obtenemos el menor valor el cual seria el limite de diseno
Pu = min(Put,[],2); %(nroElementos,1)
%--------------------------------------------------------------------------
%% Verificamos la resistencia a COMPRESION
aux1 = K*L./r;
aux2 = 4.71*(E1/Fy)^(1/2);
Fe = ((pi^2)*E1)./(aux1).^(2);
Pn = zeros(nroElementos,1);
for cont=1:nroElementos
    if aux1(cont,1)<=aux2
        Fcr = (0.658^(Fy/Fe(cont,1)))*Fy;
        Pn(cont,1) = Fcr*Ag(cont,1);
    else
        Fcr = 0.877*Fe(cont,1);
        Pn(cont,1) = Fcr*Ag(cont,1);
    end    
end
coefc = 0.9;
Puc = Pn*coefc;
% si dijeramos q fuera como el sap2000 q su ratio no sobrepase 0.95
% entonces tendriamos q reducir la capacidad para ver q pasa
% Pu=0.95*Pu;
% Puc=0.95*Puc;






