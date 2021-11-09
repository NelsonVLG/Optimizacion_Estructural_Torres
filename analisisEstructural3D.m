function [cargasResultados]=analisisEstructural3D(datosEstructura,Ae,b)
d = datosEstructura;
%PATRONES DE CARGA
%--------------------------------------------------------------------------
%Cargas aplicadas (patrones de carga)
nroPatron = size(d.patronCarga,1);

%%Cargas de peso propio si existen
if ismember(1,d.patronCarga.SelfWtMult)
    densidad = d.material.pesoEspecifico;
    [cargasPp] = trussPp3D(d,Ae,densidad);   
    d.cargas.(d.patronCarga.LoadPat{d.patronCarga.SelfWtMult==1}) = cargasPp;    
end

%%Cargas de viento si existen
if ~isempty(d.viento)
    if ismember('x',datosEstructura.viento.eje)
        %Cargas de viento en x
        lista=d.vientoElementos.listaX;
        lista(isnan(lista)) = [];
        pV=d.viento.presion(1);
        dirF=d.viento.eje{1};
        [vientoX]=trussViento3D(lista,b,pV,d,dirF);
        nombreVX = d.viento.nombre{1};
        d.cargas.(nombreVX) = vientoX;         
    end    
    if ismember('y',datosEstructura.viento.eje)
        lista=d.vientoElementos.listaY;
        lista(isnan(lista))=[];
        pV=d.viento.presion(2);
        dirF=d.viento.eje{2};
        [vientoY]=trussViento3D(lista,b,pV,d,dirF);        
        nombreVY = d.viento.nombre{2};
        d.cargas.(nombreVY) = vientoY;        
    end    
end
%--------------------------------------------------------------------------
%%Realizamos el analisis estructural de los patrones de carga
%--------------------------------------------------------------------------
cargasResultados = struct;
nomCampos = fieldnames(d.cargas);
for i=1:nroPatron
    nomCarga = nomCampos{i};
    cargas = d.cargas.(nomCarga);
    [cargasResultados.(nomCarga).desplazamientos,cargasResultados.(nomCarga).elementoFuerza]=truss3D(d,cargas,Ae);    
end
%--------------------------------------------------------------------------

%%COMBINACIONES DE CARGAS  
%--------------------------------------------------------------------------
[combinacionesCarga,~,jp] = unique(d.combCarga.ComboName);
nroComb = size(combinacionesCarga,1);

%Inicializamos la matriz de combinaciones
combF = zeros(size(d.conectividad,1),nroComb);
combD1 = zeros(size(d.coordenadas,1),nroComb);
combD2 = zeros(size(d.coordenadas,1),nroComb);
combD3 = zeros(size(d.coordenadas,1),nroComb);
idFuerzas = (1:d.nroElementos)';
for cont=1:nroComb
    pos = find(jp == cont);    
    nroP = size(pos,1);
    for contP = 1:nroP
        patronC = d.combCarga.CaseName{pos(contP)};
        sf = d.combCarga.ScaleFactor(pos(contP));
        combF(:,cont) = combF(:,cont)+cargasResultados.(patronC).elementoFuerza(:,2)*sf;
        combD1(:,cont) = combD1(:,cont)+cargasResultados.(patronC).desplazamientos(:,2)*sf; 
        combD2(:,cont) = combD2(:,cont)+cargasResultados.(patronC).desplazamientos(:,3)*sf;
        combD3(:,cont) = combD3(:,cont)+cargasResultados.(patronC).desplazamientos(:,4)*sf;
    end
    
    combo = combinacionesCarga{cont};
    cargasResultados.(combo).elementoFuerza = [idFuerzas,combF(:,cont)];
    cargasResultados.(combo).desplazamientos = [d.coordenadas(:,1),combD1(:,cont),combD2(:,cont),combD3(:,cont)];
end
%--------------------------------------------------------------------------
%ENVOLVENTE DE CARGAS
%--------------------------------------------------------------------------
%%Clasificamos las fuerzas y desplazamientos mas grandes por elemento
envolFmax = max(combF,[],2);
envolFmin = min(combF,[],2);

[~,indD1] = max(abs(combD1),[],2);
id1 = sub2ind(size(combD1),1:size(combD1,1),indD1');
envolD1 = combD1(id1');
[~,indD2] = max(abs(combD2),[],2);
id2 = sub2ind(size(combD2),1:size(combD2,1),indD2');
envolD2 = combD2(id2');
[~,indD3] = max(abs(combD3),[],2);
id3 = sub2ind(size(combD3),1:size(combD3,1),indD3');
envolD3 = combD3(id3');
%Valores a usar del analisis estructural
cargasResultados.envolvente.elementoFuerza = [idFuerzas,envolFmin,envolFmax];
cargasResultados.envolvente.desplazamientos = [d.coordenadas(:,1),envolD1,envolD2,envolD3];
%--------------------------------------------------------------------------

        
        
    
    
    


