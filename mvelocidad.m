function [V]=mvelocidad(V,X,nvar,nparticulas,c1,c2,w,pbest,gbest)
for i=1:nparticulas
    for j=1:nvar
        V(i,j)=w*V(i,j)+c1*rand()*(pbest(i,j)-X(i,j))+c2*rand()*(gbest(1,j)-X(i,j));
    end
end
