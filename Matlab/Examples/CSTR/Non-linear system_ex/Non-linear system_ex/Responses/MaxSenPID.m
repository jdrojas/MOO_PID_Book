function Ms=MaxSenPID(pid,K,T,L,a)
%
%Controller parameters
Kc=pid(1);  %Controller Gain
Ti=pid(2);  %Integral Time Constant
Td=pid(3);  %Derivative Time Constant
b=1;        %Set-point Weight (1-DoF)
%
N=10;
%Modelo
numP=[0 K];
denP=[(a*T^2) (T+a*T) 1];
%Controlador
numCy=Kc*[Ti*Td*(1/N+1) (Td*(1/N)+Ti) 1];
denCy=[Ti*Td*(1/N) Ti 0];
%Maximo de Funcion de Sensibilidad
w=logspace(-3,3,1000);
numL=conv(numCy,numP);
denL=conv(denCy, denP);
numLjw=polyval(numL,j*w).*exp(-L*j*w);
denLjw=polyval(denL,j*w);
Sjw=denLjw./(denLjw+numLjw);
MagS=abs(Sjw);
Ms=max(MagS);
%