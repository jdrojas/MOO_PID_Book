clear; clc;
% parameters
Y = 0.65;
r = 0.6;
beta = 0.2;
KDO  = 2; %mg/l
alpha = 0.018;
umax = 0.15; %mg/l
Ks = 100; %mg/l
K0 = 0.5;
DOmax = 10; % mg/l

DO = 5;
D =  0.025;
Sin = 200; % mg/l 
DOin = 0.5; %mg/l

f = @(x) WTPSS(x,Y,r,beta,KDO,alpha,umax,Ks,K0,DOmax, DO, D,Sin, DOin);

x0 = [298.19;10.302;596.37;27.50];
sol = fsolve(f,x0);
disp(sol);
disp(f(sol));

function e = WTPSS(x,Y,r,beta,KDO,alpha,umax,Ks,K0,DOmax, DO, D,Sin, DOin)
X = x(1);
S = x(2);
Xr = x(3);
Qair = x(4);

u = umax * (S/(Ks+S))*(DO/(KDO+DO));
%
e1 = u*X - D*(1+r)*X + r*D*Xr;
e2 = -u/Y*X -D*(1+r)*S + D*Sin;
e3 = -K0*u/Y*X - D*(1+r)*DO + alpha*Qair*(DOmax-DO) + D*DOin;
e4 = D*(1+r)*X - D*(beta+r)*Xr;
e=[e1;e2;e3;e4];
end