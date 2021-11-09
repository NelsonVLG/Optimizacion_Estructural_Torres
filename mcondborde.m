function [X]=mcondborde(UB,LB,nparticulas,nvar,X)
for i=1:nparticulas
    for j=1:nvar
        if X(i,j)<LB(1,j)
            X(i,j)=LB(1,j);
        elseif X(i,j)>UB(1,j)
            X(i,j)=UB(1,j);
        end
    end
end
