function etFrame = graficaEtiquetaFrame(datosEstructura, coorsIni, coorsFin)
%Funcion para poner etiquetas a los frames
d = datosEstructura;
%%
M=(coorsIni(:,[2 3 4])+coorsFin(:,[2 3 4]))./2;         %con esta matriz encontramos las coordenadas del medio de las lineas
%%
axis('equal');
%figure(1),
hold on
etFrame = zeros(size(coorsIni,1),1);
for i=1:size(coorsIni,1)
 etFrame(i,1) = text(M(i,1),M(i,2),M(i,3),[{'\color{blue}'} int2str( d.conectividad(i,1) ),],'FontSize',8) ;
end
hold off