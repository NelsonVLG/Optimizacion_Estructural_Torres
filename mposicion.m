function [X]=mposicion(X,V,nparticulas,nvar)
for i=1:nparticulas
    for j=1:nvar 
        X(i,j)=X(i,j)+V(i,j);
    end
end
