function [K,a,T1,L,Gmodel]=IdentFun(t,u,y,Metodo)
% [num,den]=IdentFun(t,u,y)
% IdentFun encuentra el modelo de una planta de segundo orden m谩s tiempo
% muerto sobreamortiguada a partir de los datos t,u,y, utilizando Metodo:
%   'Opt': Identificacion utilizando un metodo de identificaci贸n
%   'Alfaro123': Utiliza el m茅todo de 123 cuartos de Alfaro, necesita una
%   prueba escal贸n
%
% Se supone que los datos comienzan en estado estacionario
%------------------------------------------
%
% Primero hay que preparar los datos
u=reshape(u,[],1);
y=reshape(y,[],1);
up=u-u(1);
yp=y-y(1);
tp=t-t(1);
%
fun1=@(x) simu([x(1);x(2);x(3);x(4)],tp,up,yp); % se define la funci贸n de costo. simu est谩 abajo
switch Metodo
    case 'Opt' % Se encuentra el modelo mediante una optimizaci贸n
        x=fmincon(fun1,[1;1;1;1],[],[],[],[],[0;min(diff(tp))*2;0;0]); %
        Gmodel=tf(x(1),conv([x(2),1],[x(2)*x(3),1]));
        Gmodel.iodelay=x(4);
        
        %%Modificaci髇
        K = x(1);
        T1 = x(2);
        a = x(3);
        L = x(4);
        
    case 'Alfaro123' % se encuentra con el metodo 123 de alfaro
        %ver http://www.revistas.ucr.ac.cr/index.php/cienciaytecnologia/article/view/2647
        updiff=diff(up);
        MoreThan1Step=find(updiff~=0);
        if length(MoreThan1Step)>1
            error('El m閠odo Alfaro123 solo permite un cambio escal髇');
        else
            i0=MoreThan1Step;
        end
        % Se encuentran los tiempos en los que la salida alcaza el 25%, 50%
        % y 75% del valor final.
        i25=find(yp>=0.25*yp(end),1);
        i50=find(yp>=0.5*yp(end),1);
        i75=find(yp>=0.75*yp(end),1);
        t25=tp(i25)-tp(i0);
        t50=tp(i50)-tp(i0);
        t75=tp(i75)-tp(i0);
        K=(yp(end)-yp(1))/(u(end)-u(1));
        a=(-0.6240*t25+0.9866*t50-0.3626*t75)/(0.3533*t25-0.7036*t50+0.3503*t75);
        tau=(t75-t25)/(0.9866+0.7036*a);
        T1=tau;
        T2=a*tau;
        L=t75-(1.3421+1.3455*a)*tau;
        Gmodel=tf(K,conv([T1,1],[T2,1]));
        Gmodel.iodelay=L;
    otherwise
        Gmodel=NaN;
end
end

function error=simu(x,t,u,y) % Calacula el error del modelo con los datos de entrada
    F=tf(x(1),conv([x(2),1],[x(3)*x(2),1]));
    F.iodelay=x(4);
    ym=lsim(F,u,t);
    error=sum((y-ym).^2); % tambien se puede usar el valor absoluto
end