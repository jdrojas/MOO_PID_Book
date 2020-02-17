clear; clc;
% Second order model
K = 0.3658;
T1 = 52.861;
T2 = 52.805;
L = 24.736;
%
% First order model with Half-Rule
Tn = T1 + T2/2;
Ln = L + T2/2;
% SIMC tuning
%T1 <= 8L
KpSIMC = (0.5/K)*(T1+T2)/L;
TiSIMC = T1 + T2;
TdSIMC = T2/(1+T2/T1);
%
% Rovira
KpRovira = 1.086/K*(Tn/Ln)^0.869;
TiRovira = Tn/(0.740-0.13*Ln/Tn);
TdRovira = 0.348*Tn*(Ln/Tn)^0.914;
% Murril
KpMurril = 1.435/K*(Tn/Ln)^0.921;
TiMurril = Tn/0.878*(Ln/Tn)^0.749;
TdMurril = 0.482*Tn*(Ln/Tn)^1.137;
%
%Simulate model
SPValue = 1;
DValue = 0;
Results = sim('CSTHLinearPID.slx');
IaeSIMC = trapz(Results.SP.Time,abs(Results.SP.Data-Results.SIMC.Data));
IaeMurril = trapz(Results.Murril.Time,abs(Results.SP.Data-Results.Murril.Data));
IaeRovira = trapz(Results.Rovira.Time,abs(Results.SP.Data-Results.Rovira.Data));
plot(Results.SP.Time,Results.SP.Data,Results.SIMC.Time,Results.SIMC.Data,'--',Results.Murril.Time,Results.Murril.Data,'-.',Results.Rovira.Time,Results.Rovira.Data,':');
legend('Setpoint','SIMC','Murril','Rovira');
xlabel('Time (s)');
ylabel('YT (%)');
grid on