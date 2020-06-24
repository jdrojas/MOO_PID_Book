%Orlando Arrieta
%
clc;
close all;
clear;
%
%Model parameters
K=0.3199;
T=0.6238;
Ln=0.5289;
%
%
%1-DOF Servo+Regulation - Ms libre - Deg=0
[Kc,Ti,Td]=Jrd3Deg_PID1tuning(K,T,Ln);
sim('Reactor_Gp1');y_rd3=y;u_rd3=u;
Ms_rd3Deg0=MaxSenPID([Kc,Ti,Td],K,T,Ln,0);

%
%1-DOF Servo+Regulation - Deg=0.25
[Kc,Ti,Td]=Jrd3Deg_PID1tuning(K,T,Ln,0.25);
sim('Reactor_Gp1');y_rd3Deg025=y;u_rd3Deg025=u;
Ms_rd3Deg025=MaxSenPID([Kc,Ti,Td],K,T,Ln,0);
%
%1-DOF Servo+Regulation - Deg=0.35
[Kc,Ti,Td]=Jrd3Deg_PID1tuning(K,T,Ln,0.35);
sim('Reactor_Gp1');y_rd3Deg035=y;u_rd3Deg035=u;
Ms_rd3Deg035=MaxSenPID([Kc,Ti,Td],K,T,Ln,0);
%
%1-DOF Servo+Regulation - Deg=0.45
[Kc,Ti,Td]=Jrd3Deg_PID1tuning(K,T,Ln,0.45);
sim('Reactor_Gp1');y_rd3Deg045=y;u_rd3Deg045=u;
Ms_rd3Deg045=MaxSenPID([Kc,Ti,Td],K,T,Ln,0);
%
%1-DOF Servo+Regulation - Deg=0.55
[Kc,Ti,Td]=Jrd3Deg_PID1tuning(K,T,Ln,0.55);
sim('Reactor_Gp1');y_rd3Deg055=y;u_rd3Deg055=u;
Ms_rd3Deg055=MaxSenPID([Kc,Ti,Td],K,T,Ln,0);
%
%
%Plots
figure;
subplot(211);
plot(t,y_rd3,':',t,y_rd3Deg025,'--',t,y_rd3Deg035,'-',t,y_rd3Deg045,'-.',t,y_rd3Deg055,'-');
legend('$Deg^a=0$','$Deg^a=0.25$','$Deg^a=0.35$','$Deg^a=0.45$','$Deg^a=0.55$');
xlabel('time (min)');ylabel('y(t)(%)');
subplot(212);
plot(t,u_rd3,':',t,u_rd3Deg025,'--',t,u_rd3Deg035,'-',t,u_rd3Deg045,'-.',t,u_rd3Deg055,'-');
legend('$Deg^a=0$','$Deg^a=0.25$','$Deg^a=0.35$','$Deg^a=0.45$','$Deg^a=0.55$');
xlabel('time (min)');ylabel('u(t)(%)');
%