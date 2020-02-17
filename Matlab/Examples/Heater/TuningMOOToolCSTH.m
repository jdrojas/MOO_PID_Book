clc;
% Second order model
K = 0.3658;
T1 = 52.861;
T2 = 52.805;
L = 24.736;
ParamPlant = [K;T1;L;T2/T1];
Kp = MOOResults.Kp;
Ti = MOOResults.Ti;
Td = MOOResults.Td;
beta = MOOResults.beta;
%
ParamContr = [Kp; Ti; Td; 0.1; beta; 0];
%
%Simulate model
time = (0:0.01:1000).';
SPValue = 1;
DValue = 0;
r = SPValue*ones(size(time));
di = DValue*ones(size(time));
do = zeros(size(time));
x0 = zeros(4,1);
[y,~,~] = SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
%
iae = trapz(time, abs(r-y));
plot(time,y)