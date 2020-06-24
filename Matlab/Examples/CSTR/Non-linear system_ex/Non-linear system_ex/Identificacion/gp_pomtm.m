function [Gp]=gp_pomtm(kp,tau,tm)
%gp_pomtm provee la función de transferencia de
%una planta de primer orden más tiempo muerto
%
%	Gp=gp_pomtm(kp,tau,tm)
%
%		kp	-  ganancia de la planta
%		tau	-  constante de tiempo
%		tm	-  tiempo muerto aparente
%
%		Gp	-  función de transferencia de la planta
%
s=tf('s');
%
%planta de POMTM
Gp=kp/(tau*s+1);
Gp.outputdelay=tm;