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
% Load MOO values from file
M = readmatrix('TuningToolResult.csv');
MOOJdi = M(:,1);
MOOJr = M(:,2);
% Parameters of the selected controllers:
KpMOO01 = M(1,3);
TiMOO01 = M(1,4);
TdMOO01 = M(1,5);
betaMOO01 = M(1,6);
ParamContrMOO01 = [KpMOO01; TiMOO01; TdMOO01; 0.1; betaMOO01; 0];
%
KpMOO02 = M(12,3);
TiMOO02 = M(12,4);
TdMOO02 = M(12,5);
betaMOO02 = M(12,6);
ParamContrMOO02 = [KpMOO02; TiMOO02; TdMOO02; 0.1; betaMOO02; 0];
%
KpMOO03 = M(24,3);
TiMOO03 = M(24,4);
TdMOO03 = M(24,5);
betaMOO03 = M(24,6);
ParamContrMOO03 = [KpMOO03; TiMOO03; TdMOO03; 0.1; betaMOO03; 0];
%
%
%Simulate model for servo response
time = (0:0.01:1000).';
SPValue = 1;
DValue = 0;
r = SPValue*ones(size(time));
di = DValue*ones(size(time));
do = zeros(size(time));
x0 = zeros(4,1);
[ySIMC,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrSIMC,time,r,di,do,x0);
[yRoviraJr,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrRovira,time,r,di,do,x0);
[yMurrilJr,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMurril,time,r,di,do,x0);
[yMOO01Jr,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO01,time,r,di,do,x0);
[yMOO02Jr,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO02,time,r,di,do,x0);
[yMOO03Jr,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO03,time,r,di,do,x0);
%
iaeSIMCJr = trapz(time, abs(r-ySIMC));
iaeRoviraJr = trapz(time, abs(r-yRoviraJr));
iaeMurrilJr = trapz(time, abs(r-yMurrilJr));
iaeMOO01Jr = trapz(time, abs(r-yMOO01Jr));
iaeMOO02Jr = trapz(time, abs(r-yMOO02Jr));
iaeMOO03Jr = trapz(time, abs(r-yMOO03Jr));
% Simulate model for regulator response
SPValue = 0;
DValue = 1;
r = SPValue*ones(size(time));
di = DValue*ones(size(time));
do = zeros(size(time));
x0 = zeros(4,1);
[ySIMC,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrSIMC,time,r,di,do,x0);
[yRoviraJdi,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrRovira,time,r,di,do,x0);
[yMurrilJdi,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMurril,time,r,di,do,x0);
[yMOO01Jdi,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO01,time,r,di,do,x0);
[yMOO02Jdi,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO02,time,r,di,do,x0);
[yMOO03Jdi,~,~] = SOPTDPIDSimu(ParamPlant,ParamContrMOO03,time,r,di,do,x0);
%
iaeSIMCJdi = trapz(time, abs(r-ySIMC));
iaeRoviraJdi = trapz(time, abs(r-yRoviraJdi));
iaeMurrilJdi = trapz(time, abs(r-yMurrilJdi));
iaeMOO01Jdi = trapz(time, abs(r-yMOO01Jdi));
iaeMOO02Jdi = trapz(time, abs(r-yMOO02Jdi));
iaeMOO03Jdi = trapz(time, abs(r-yMOO03Jdi));
%
% Plot results
figure(1)
plot(MOOJdi,MOOJr,'-.b',iaeMurrilJdi,iaeMurrilJr,'sr',iaeRoviraJdi,iaeRoviraJr,'xk',MOOJdi([1,12,24]),MOOJr([1,12,24]),'ob');
xlabel('J_{di}');
ylabel('J_r');
grid on;
legend('MOO tuning','Murril','Rovira')
%
figure(2)
plot(time,yMurrilJr,'--',time,yRoviraJr,'-.',time,yMOO01Jr,time,yMOO02Jr,':',time,yMOO03Jr,'--');
xlabel('Time (s)');
ylabel('Y_T (%)');
legend(['Murril, IAE = ',num2str(iaeMurrilJr,4)],...
    ['Rovira, IAE = ',num2str(iaeRoviraJr,4)],...
    ['MOO01, IAE = ',num2str(iaeMOO01Jr,4)],...
    ['MOO02, IAE = ',num2str(iaeMOO02Jr,4)],...
    ['MOO03, IAE = ',num2str(iaeMOO03Jr,4)],...
    'location','southeast');
grid on;
%
figure(3)
plot(time,yMurrilJdi,'--',time,yRoviraJdi,'-.',time,yMOO01Jdi,time,yMOO02Jdi,':',time,yMOO03Jdi,'--');
xlabel('Time (s)');
ylabel('Y_T (%)');
legend(['Murril, IAE = ',num2str(iaeMurrilJdi,4)],...
    ['Rovira, IAE = ',num2str(iaeRoviraJdi,4)],...
    ['MOO01, IAE = ',num2str(iaeMOO01Jdi,4)],...
    ['MOO02, IAE = ',num2str(iaeMOO02Jdi,4)],...
    ['MOO03, IAE = ',num2str(iaeMOO03Jdi,4)],...
    'location','northeast');
grid on;