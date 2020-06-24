%Identificacion reactor
%Orlando Arrieta
%
clc;
clear;
sim('Id_u_d');
%entrada
duu=10;
dud=1;
%
%Identificación de un modelo de primer orden más tiempo muerto
[kp1,tau1,tm1] = fc_idmet2p(yu,t,0,duu,2);
%
%Identificación de un modelo de segundo orden más tiempo muerto
[kp2,tau2,tm2] = fc_idmet2p(yd,t,0,dud,2);
%
Gm1=gp_pomtm(kp1,tau1,tm1)
Gm2=gp_pomtm(kp2,tau2,tm2)
%
%Gráfico de la respuesta al escalón de la planta y del modelo
ym1=duu*step(Gm1,t);
ym2=dud*step(Gm2,t);
%
subplot(1,2,1);
plot(t',0.1*yu','--',t',0.1*ym1','-');
title('P_u');
xlabel('time(min)');ylabel('y_u(t)');
subplot(1,2,2);
plot(t',yd','--',t',ym2','-');
%plot(t',2*yd','--',t',2*ym2','-');
title('P_d');
xlabel('time(min)');ylabel('y_d(t)');
legend('Process','Model');
%