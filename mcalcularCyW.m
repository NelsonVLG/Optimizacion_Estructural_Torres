function [w,c1,c2]=mcalcularCyW(wmax,wmin,cmax,cmin,maxite,ite)
w=wmax-(wmax-wmin)*ite/maxite;
c1=(((cmin(1,1)-cmax(1,1))/maxite)*ite)+cmax(1,1);
c2=(((cmax(1,2)-cmin(1,2))/maxite)*ite)+cmin(1,2);
