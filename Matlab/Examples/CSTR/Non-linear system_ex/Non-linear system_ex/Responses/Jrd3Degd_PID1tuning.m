function [Kc,Ti,Td]=Jrd3Degd_PID1tuning(K,T,L,Deg)
%
%Tuning
%Constantes
a1= 0.6425*(Deg)^2-1.6940*(Deg)+1.2620;
b1= 0.0500*(Deg)^2-0.1132*(Deg)-0.9024;
c1=-0.8425*(Deg)^2+1.1650*(Deg)-0.0359;
a2=-1.5650*(Deg)^2+1.4530*(Deg)+0.5499;
b2= 0.9525*(Deg)^2-0.9609*(Deg)+0.8236;
c2= 1.0930*(Deg)^2-1.2830*(Deg)+0.7026;
a3= 0.4550*(Deg)^2-0.3128*(Deg)+0.3292;
b3=-0.7025*(Deg)^2+0.3467*(Deg)+0.8339;
c3=-0.2425*(Deg)^2+0.2255*(Deg)-0.0561;
%
%Parameters of the PID
Kc=1/K*(a1*(L/T)^b1+c1);
Ti=T*(a2*(L/T)^b2+c2);
Td=T*(a3*(L/T)^b3+c3);
%