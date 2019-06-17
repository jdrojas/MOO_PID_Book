function [kp,zi,zd,B]=interpolarControl(t0,a,Ms,Jdimax,Jdomax,Jrmax)
t0Buscar=[floor(t0/0.1),ceil(t0/0.1)]*0.1;
aBuscar=[floor(a/0.1),ceil(a/0.1)]*0.1;
%
%Primera interpolaci�n: a con t0 contante
if aBuscar(1) ~= aBuscar(2)
    if t0Buscar(1) ~= t0Buscar(2)
        [JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1]=seleccionar(t0Buscar(1),aBuscar(1),Ms);
        [JdiVec_t02_a1,JdoVec_t02_a1,JrVec_t02_a1,KpVec_t02_a1,TiVec_t02_a1,TdVec_t02_a1,betaVec_t02_a1]=seleccionar(t0Buscar(2),aBuscar(1),Ms);
        Param_t01_a1=buscar(JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1,Jdimax,Jdomax,Jrmax);
        Param_t02_a1=buscar(JdiVec_t02_a1,JdoVec_t02_a1,JrVec_t02_a1,KpVec_t02_a1,TiVec_t02_a1,TdVec_t02_a1,betaVec_t02_a1,Jdimax,Jdomax,Jrmax);
        %
        [JdiVec_t01_a2,JdoVec_t01_a2,JrVec_t01_a2,KpVec_t01_a2,TiVec_t01_a2,TdVec_t01_a2,betaVec_t01_a2]=seleccionar(t0Buscar(1),aBuscar(2),Ms);
        [JdiVec_t02_a2,JdoVec_t02_a2,JrVec_t02_a2,KpVec_t02_a2,TiVec_t02_a2,TdVec_t02_a2,betaVec_t02_a2]=seleccionar(t0Buscar(2),aBuscar(2),Ms);
        Param_t01_a2=buscar(JdiVec_t01_a2,JdoVec_t01_a2,JrVec_t01_a2,KpVec_t01_a2,TiVec_t01_a2,TdVec_t01_a2,betaVec_t01_a2,Jdimax,Jdomax,Jrmax);
        Param_t02_a2=buscar(JdiVec_t02_a2,JdoVec_t02_a2,JrVec_t02_a2,KpVec_t02_a2,TiVec_t02_a2,TdVec_t02_a2,betaVec_t02_a2,Jdimax,Jdomax,Jrmax);
        %
        Param_t01=interpSimple(aBuscar(1),Param_t01_a1,aBuscar(2),Param_t01_a2,a);
        Param_t02=interpSimple(aBuscar(1),Param_t02_a1,aBuscar(2),Param_t02_a2,a);
        Param=interpSimple(t0Buscar(1),Param_t01,t0Buscar(2),Param_t02,t0);
    else
        [JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1]=seleccionar(t0Buscar(1),aBuscar(1),Ms);
        [JdiVec_t01_a2,JdoVec_t01_a2,JrVec_t01_a2,KpVec_t01_a2,TiVec_t01_a2,TdVec_t01_a2,betaVec_t01_a2]=seleccionar(t0Buscar(1),aBuscar(2),Ms);
        Param_t01_a1=buscar(JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1,Jdimax,Jdomax,Jrmax);
        Param_t01_a2=buscar(JdiVec_t01_a2,JdoVec_t01_a2,JrVec_t01_a2,KpVec_t01_a2,TiVec_t01_a2,TdVec_t01_a2,betaVec_t01_a2,Jdimax,Jdomax,Jrmax);
        Param=interpSimple(aBuscar(1),Param_t01_a1,aBuscar(2),Param_t01_a2,a);
    end
else
    if t0Buscar(1) ~= t0Buscar(2)
        [JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1]=seleccionar(t0Buscar(1),aBuscar(1),Ms);
        [JdiVec_t02_a1,JdoVec_t02_a1,JrVec_t02_a1,KpVec_t02_a1,TiVec_t02_a1,TdVec_t02_a1,betaVec_t02_a1]=seleccionar(t0Buscar(2),aBuscar(1),Ms);
        Param_t01_a1=buscar(JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1,Jdimax,Jdomax,Jrmax);
        Param_t02_a1=buscar(JdiVec_t02_a1,JdoVec_t02_a1,JrVec_t02_a1,KpVec_t02_a1,TiVec_t02_a1,TdVec_t02_a1,betaVec_t02_a1,Jdimax,Jdomax,Jrmax);
        Param=interpSimple(t0Buscar(1),Param_t01_a1,t0Buscar(2),Param_t02_a1,t0);
    else
        [JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1]=seleccionar(t0Buscar(1),aBuscar(1),Ms);
        Param=buscar(JdiVec_t01_a1,JdoVec_t01_a1,JrVec_t01_a1,KpVec_t01_a1,TiVec_t01_a1,TdVec_t01_a1,betaVec_t01_a1,Jdimax,Jdomax,Jrmax);
    end
end
if isempty(Param)
    kp = nan;
    zi = nan;
    zd = nan;
    B = nan;
else
    kp = Param(1);
    zi = Param(2);
    zd = Param(3);
    B = Param(4);
end
end

function yi=interpSimple(x1,y1,x2,y2,xi)
yi=y1+(y2-y1)./(x2-x1).*(xi-x1);
end