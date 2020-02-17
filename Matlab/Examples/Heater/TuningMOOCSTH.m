clear; clc;
% Second order model
K = 0.3658;
T1 = 52.861;
T2 = 52.805;
L = 24.736;
ParamPlant = [K;T1;L;T2/T1];
%
% First order model with Half-Rule
Tn = T1 + T2/2;
Ln = L + T2/2;
% SIMC tuning
%T1 <= 8L
KpSIMC = (0.5/K)*(T1+T2)/L;
TiSIMC = T1 + T2;
TdSIMC = T2/(1+T2/T1);
ParamContrSIMC = [KpSIMC; TiSIMC; TdSIMC; 0.1; 1; 1];
%
% Rovira
KpRovira = 1.086/K*(Tn/Ln)^0.869;
TiRovira = Tn/(0.740-0.13*Ln/Tn);
TdRovira = 0.348*Tn*(Ln/Tn)^0.914;
ParamContrRovira = [KpRovira; TiRovira; TdRovira; 0.1; 1; 1];
% Murril
KpMurril = 1.435/K*(Tn/Ln)^0.921;
TiMurril = Tn/0.878*(Ln/Tn)^0.749;
TdMurril = 0.482*Tn*(Ln/Tn)^1.137;
ParamContrMurril = [KpMurril; TiMurril; TdMurril; 0.1; 1; 1];
%
%Simulate model
time = (0:0.01:1000).';
SPValue = 0;
DValue = 1;
r = SPValue*ones(size(time));
di = DValue*ones(size(time));
do = zeros(size(time));
x0 = zeros(4,1);
[ySIMC,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrSIMC,time,r,di,do,x0);
[yRovira,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrRovira,time,r,di,do,x0);
[yMurril,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMurril,time,r,di,do,x0);
%
iaeSIMC = trapz(time, abs(r-ySIMC));
iaeRovira = trapz(time, abs(r-yRovira));
iaeMurril = trapz(time, abs(r-yMurril));