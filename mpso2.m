function [ds] = mpso2(datosOpt, datosEstructura, varargin)
%[ds] = mpso(datosOpt, datosEstructura, Xinicial)
%%OPTIMIZACION POR ENJAMBRE DE PARTICULAS(PSO)
%--------------------------------------------------------------------------
%Definicion de parametros para la optimización
%--------------------------------------------------------------------------
nvariables = datosOpt.nvariables;
%Limites por donde se moveran la particulas que depende de nro de variables
LB = datosOpt.LB;
UB = datosOpt.UB;
%Parametros entrada para la optimizacion de pso
nparticulas = datosOpt.nparticulas;
wmin = datosOpt.wmin;
wmax = datosOpt.wmax;
cmin = datosOpt.cmin;
cmax = datosOpt.cmax;
maxite = datosOpt.maxite;
% maxite = 1000
%--------------------------------------------------------------------------
%Encontramos una poblacion inicial 
%--------------------------------------------------------------------------
Xinicial = zeros(nparticulas,nvariables);
for cont=1:nparticulas
    Xinicial(cont,:)=mrand(LB,UB);
end
%si existe un punto de partida de la optimizacion
nin = nargin - 2;
if nin > 1
    Xparticula = varargin{2};
    Xinicial(1,:) = Xparticula;
end
%--------------------------------------------------------------------------
%Determinamos la población y velocidad inicial
%--------------------------------------------------------------------------
[Xinicial,posLista] = mdiscreto(Xinicial,datosEstructura);
X = Xinicial;
V = 0.1*X;
%%Calculamos la funcion objetivo para la poblacion inicial
[fun0]=mFuncionObjetivo2(posLista, datosEstructura,1);
%Calculamos pbest y gbest iniciales
[fmin0,posicion]=min(fun0);
pbest=Xinicial;
gbest=Xinicial(posicion,:);
pos = posicion;
%--------------------------------------------------------------------------
%%PSO INIALIZACION 
%--------------------------------------------------------------------------
%Inicializamos algunas variables para la iteracion
ite = 1;
%tolerancia = 1;
%--------------------------------------------------------------------------
while ite<=maxite %&& tolerancia>10^-12
    [w,c1,c2] = mcalcularCyW(wmax,wmin,cmax,cmin,maxite,ite);
    %Actualizacion de velocidad
    [V] = mvelocidad(V,X,nvariables,nparticulas,c1,c2,w,pbest,gbest);
    %Actualizacion de la posicion
    [X] = mposicion(X,V,nparticulas,nvariables);
    %Manejo de limites de frontera
    [X] = mcondborde(UB,LB,nparticulas,nvariables,X);
    [X,posLista] = mdiscreto(X,datosEstructura);
    %Evaluacion de la funcion objetivo
    [fun] = mFuncionObjetivo2(posLista,datosEstructura,pos);
    %Actualizacion de pbest y fitness
    for cont=1:nparticulas
        if fun(cont,1)<fun0(cont,1)
            pbest(cont,:)=X(cont,:);
            fun0(cont,1)=fun(cont,1) ;       
        end
    end
    %Encontramos la mejor particula
    [fmin,pos]=min(fun0);
    ffmin(ite,1)=fmin;                      
    %Actualizamos gbest y el mejor fitness
    if fmin<fmin0
        gbest=pbest(pos,:);
        fmin0=fmin;
    end
    %Calculamos la tolerancia
    if ite>100
        tolerancia=abs(ffmin(ite-100,:)-fmin0);
    end
    %------------------------
    iter(ite,1)=ite;
    ite=ite+1;    
    figure(1);
    plot(iter,ffmin);
    title('Optimización por enjambre de particulas (PSO)')
    xlabel('Número de iteraciones')
    ylabel('Peso de la estructura')
    drawnow ;   
        
    %Ver graficamente la optimizacion
    if nin > 0
        gG = varargin{1};         
        for nv = 1:nvariables
            porc = (gbest(1,nv)-LB(1,1))/(UB(1,1)-LB(1,1));
            grosor = (10-1)*porc +1;
            lt = gG{nv}.Children(:,1);
            set(lt,'LineWidth',grosor);
        end         
    end         
    %--------------------------------
end
%--------------------------------------------------------------------------
%RESULTADOS
%--------------------------------------------------------------------------
resultado = datosEstructura.secciones(posLista(pos,:)',:);
[W,cargasResultados,hfaltas] = mFuncionObjetivo2(posLista,datosEstructura,pos);
pesoMinimo = [pos,fmin];

ds = struct;
ds.secciones = resultado;
ds.cargasResultados = cargasResultados;
ds.poblacion = X;
ds.pesoPoblacion = W;
ds.pbest = pbest;
ds.gbest = gbest;
ds.pesoIteracion = ffmin;
ds.nroFaltaPoblacion = hfaltas;
ds.pesoMinimo = pesoMinimo;
ds.posLista = posLista;
%--------------------------------------------------------------------------



