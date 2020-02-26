clear; clc;
%
% Original Plant
P = zpk([],[-1,-1/0.5,-1/0.5^2,-1/0.5^3],1*(1/0.5)*(1/0.5^2)*(1/0.5^3));
%
% Second order approximation
F = zpk([],[-1/0.9477, -1/0.6346],1/0.9477*1/0.6346);
F.iodelay = 0.297;
%
step(P,F)
legend('High order model', 'Reduced order model','location','southeast');
grid on;