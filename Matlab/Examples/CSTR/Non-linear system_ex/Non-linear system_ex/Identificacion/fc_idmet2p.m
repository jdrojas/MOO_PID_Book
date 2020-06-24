function [kp,tau,tm] = fc_idmet2p(y,t,t0,du,mid)
%V.M. Alfaro, 2003, 2004
%fc_idmet2p identifica un modelo de primer orden m�s
%tiempo muerto por un m�todo de dos puntos
%a partir de la curva de reacci�n del sistema
%y regresa los par�metros del modelo
%
%	[kp,tau,tm]=fc_idmet2p(y,t,t0,du,mid)
%
%		y	-	respuesta del sistema a una entrada escal�n
%		t	-	vector de tiempos
%		t0	-	instante de aplicaci�n del escal�n
%		du	-	magnitud del escal�n de entrada
%		mi	-	m�todo de identificaci�n
%				1	m�todo de Smith 
%				2	m�todo 1/4-3/4 (POMTM) (o si se omite mid)
%				3	m�todo 1/4-3/4 (SOMTM)
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
%identificaci�n del modelo
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