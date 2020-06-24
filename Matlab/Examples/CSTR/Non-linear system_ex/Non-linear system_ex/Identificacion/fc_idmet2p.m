function [kp,tau,tm] = fc_idmet2p(y,t,t0,du,mid)
%V.M. Alfaro, 2003, 2004
%fc_idmet2p identifica un modelo de primer orden más
%tiempo muerto por un método de dos puntos
%a partir de la curva de reacción del sistema
%y regresa los parámetros del modelo
%
%	[kp,tau,tm]=fc_idmet2p(y,t,t0,du,mid)
%
%		y	-	respuesta del sistema a una entrada escalón
%		t	-	vector de tiempos
%		t0	-	instante de aplicación del escalón
%		du	-	magnitud del escalón de entrada
%		mi	-	método de identificación
%				1	método de Smith 
%				2	método 1/4-3/4 (POMTM) (o si se omite mid)
%				3	método 1/4-3/4 (SOMTM)
%
%		kp	-	ganancia del modelo
%		tau -	constante de tiempo del modelo
%		tm -	tiempo muerto del modelo
%
nin=nargin;
if (nin==4)
	mid=2;
end;
[n1 n2]=size(y);
dy=y(n1,n2)-y(1,1);
%
switch mid
case 1
	p1=0.285;p2=0.632;
	a=1.5;b=1.5;
case 2
	p1=0.25;p2=0.75;
	a=0.9102;b=1.2620;
case 3
	p1=0.25;p2=0.75;
	a=0.5776;b=1.5552;
end;
%
%identificación del modelo
t1a=fc_intrln(t,y,p1*dy);
t2a=fc_intrln(t,y,p2*dy);
t1=t1a-t0;t2=t2a-t0;
%
%constante de tiempo
tau=a*(t2-t1);
%tiempo muerto
tm=b*t1+(1-b)*t2;
%ganancia
kp=dy/du;