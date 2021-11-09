function [var]=mrand(liminf,limsup)
tam=size(liminf,2);
var=zeros(1,tam);
for cont=1:tam
    var(1,cont)=(liminf(1,cont)+(limsup(1,cont)-liminf(1,cont))*rand);
end