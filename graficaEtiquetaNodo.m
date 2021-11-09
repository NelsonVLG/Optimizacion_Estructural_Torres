function etNodo = graficaEtiquetaNodo(datosEstructura)
%Funcion para poner etiqueta a los nodos de la estructura
d = datosEstructura;
%figure(1),
hold on
nud=d.coordenadas;
nNodos=size(nud,1);
etNodo = zeros(nNodos,1);
for i=1:nNodos
    etNodo(i,1) = text(nud(i,2),nud(i,3),nud(i,4),[{'\color[rgb]{0 0 0}'} int2str(nud(i) ),],'FontSize',9)  ;
end 
hold off