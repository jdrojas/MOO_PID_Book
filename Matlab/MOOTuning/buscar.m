function [Param,Jmin]=buscar(JdiVec,JdoVec,JrVec,KpVec,TiVec,TdVec,betaVec,Jdimax,Jdomax,Jrmax)%ParamContr, Jdi, Jdo, Jr
% [ParamContr, Jdi, Jdo, Jr]=buscar(to,a,Ms,Jdimax,Jdomax)
% Encuentra el controlador que cumpla con Jdimax, Jdomax y Jrmax (valores
% normalizados). Sólo uno de ellos puede ser cero a la vez.
%
% Universidad de Costa Rica
% Marzo 2016

%--------------------------------------------------------------------------
%
% Cargamos el archivo
%
%--------------------------------------------------------------------------
if Jdimax==0 && Jdomax~=0 && Jrmax~=0
    vec1=JdoVec<=Jdomax;
    vec2=JrVec<=Jrmax;
    i=and(vec1,vec2);
    KpJ=KpVec(i);
    TiJ=TiVec(i);
    TdJ=TdVec(i);
    betaJ = betaVec(i);
    J=JdiVec(i);
    [Jmin,k]=min(J);
    Kp=KpJ(k);
    Ti=TiJ(k);
    Td=TdJ(k);
    beta=betaJ(k);
    Param=[Kp;Ti;Td;beta];
elseif Jdomax==0 && Jdimax~=0 && Jrmax~=0
    vec1=JdiVec<=Jdimax;
    vec2=JrVec<=Jrmax;
    i=and(vec1,vec2);
    KpJ=KpVec(i);
    TiJ=TiVec(i);
    TdJ=TdVec(i);
    betaJ = betaVec(i);
    J=JdoVec(i);
    [Jmin,k]=min(J);
    Kp=KpJ(k);
    Ti=TiJ(k);
    Td=TdJ(k);
    beta=betaJ(k);
    Param=[Kp;Ti;Td;beta];
elseif Jrmax==0 && Jdimax~=0 && Jdomax~=0
    vec1=JdiVec<=Jdimax;
    vec2=JdoVec<=Jdomax;
    i=and(vec1,vec2);
    KpJ=KpVec(i);
    TiJ=TiVec(i);
    TdJ=TdVec(i);
    betaJ = betaVec(i);
    J=JrVec(i);
    [Jmin,k]=min(J);
    Kp=KpJ(k);
    Ti=TiJ(k);
    Td=TdJ(k);
    beta=betaJ(k);
    Param=[Kp;Ti;Td;beta];
else
    vec1=JdoVec<=Jdomax;
    vec2=JrVec<=Jrmax;
    i=and(vec1,vec2);
    KpJ=KpVec(i);
    TiJ=TiVec(i);
    TdJ=TdVec(i);
    betaJ = betaVec(i);
    J=JdiVec(i);
    [Jmin,k]=min(J);
    Kp=KpJ(k);
    Ti=TiJ(k);
    Td=TdJ(k);
    beta=betaJ(k);
    Param=[Kp;Ti;Td;beta];
end