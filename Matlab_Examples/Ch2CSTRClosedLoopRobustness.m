%-----------------------------------------------
%
% Industrial PID Controller Tuning
% with a multi-objective framework using MATLAB?
%
% Jose David Rojas, Orlando Arrieta, Ramon Vilanova
%
% Examples Chapter 2 : IndustrialPIDControl
%
% CSTR Closed loop simulation with PID controller
%
%-----------------------------------------------
clear all;
close all;
clc;
warning off;

% Initial concentrations
C_Ao=2.9175;    % mol l?1, initial concentrarions on reactor
C_Bo=1.10;      % mol l?1, initial concentrarions on reactor
C_Afeed=10;     % mol l?1, initial concentration on C_A feed 

% Operating point
Fr_in=60;         % Percentage control input
C_Bin=70;         % percentage for output concentration

% -----------------------------
% FIRST EXPERIMENT
% Changes for a ref step change
fprintf('reference step change experiment \n')
C_Afeed_Change=0;          % Percentage change
C_Afeed_instant=2;          % Time to apply change
Fr_Change=0;%10;%;-10;      % Percentage change
Fr_instant=10;              % Time to apply change
CB_Change=0;                % Percentage change
CB_instant=10;              % Time to apply change
Ref_C_B_Change=-10;         % Percentage change
Ref_C_B_instant=2;          % Time to apply change


% Parameters for the PID controller (Ms=2.0)
Kp = 3.335;
Ti = 0.685; 
Td = 0.181;
beta=0.0;
% Kp = 4.04;
% Ti = 1.186; 
% Td = 0.406;
% beta=0.479;
alpha=0.1;
gamma=0;
tauf=0.534;
% Simulation
tf=10;
%sim('Ch2CSTRClosedLoopIdealPIDFilter_Sys',[0 tf]);
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);
% Plot figures
subplot(221);
plot(Ref.Time, Ref.Data,'k--', C_B.Time,C_B.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 65 85]);

subplot(223);
plot(Fr.Time,Fr.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 50 100]);

fprintf('PID - Ms=2.0 IAE= %f TV=%f \n',IAE.Data(length(IAE.Data)),sum(abs(diff(u.Data))));

% Parameters for the PID controller (Ms=1.6)
Kp = 2.372;
Ti = 0.663; 
Td = 0.162;
beta=0.0;
% Kp = 3.1559;
% Ti = 1.279; 
% Td = 0.384;
% beta=0.528;
tauf=0.654;
alpha=0.1;
gamma=0;

%sim('Ch2CSTRClosedLoopIdealPIDFilter_Sys',[0 tf]);
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);
% Plot figures
subplot(221);
plot(C_B.Time,C_B.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 55 75]);
legend('Ref', 'PID M_s=2.0','PID M_s=1.6');

subplot(223);
plot(Fr.Time,Fr.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 30 70]);
legend('PID M_s=2.0','PID M_s=1.6');

fprintf('PID - Ms=1.6 IAE= %f TV=%f \n',IAE.Data(length(IAE.Data)),sum(abs(diff(u.Data))));

% -----------------------------
% SECOND EXPERIMENT
% Changes for a disturbance at the CA_feed concentration
fprintf('Disturbance experiment\n')
C_Afeed_Change=10;          % Percentage change
C_Afeed_instant=2;          % Time to apply change
Fr_Change=0;%10;%;-10;      % Percentage change
Fr_instant=2;              % Time to apply change
CB_Change=0;                % Percentage change
CB_instant=10;              % Time to apply change
Ref_C_B_Change=0;%-10;      % Percentage change
Ref_C_B_instant=2;          % Time to apply change


% Parameters for the PID controller (Ms=2.0)
Kp = 3.335;
Ti = 0.685; 
Td = 0.181;
beta=0.0;
% Kp = 4.04;
% Ti = 1.186; 
% Td = 0.406;
% beta=0.479;
alpha=0.1;
gamma=0;
tauf=0.534;
% Simulation
tf=10;
%sim('Ch2CSTRClosedLoopIdealPIDFilter_Sys',[0 tf]);
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);
% Plot figures
subplot(222);
plot(Ref.Time, Ref.Data,'k--', C_B.Time,C_B.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 65 85]);

subplot(224);
plot(Fr.Time,Fr.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 50 100]);

fprintf('PID - Ms=2.0 IAE= %f TV=%f \n',IAE.Data(length(IAE.Data)),sum(abs(diff(u.Data))));

% Parameters for the PID controller (Ms=1.6)
Kp = 2.372;
Ti = 0.663; 
Td = 0.162;
beta=0.0;
% Kp = 3.1559;
% Ti = 1.279; 
% Td = 0.384;
% beta=0.528;
tauf=0.654;
alpha=0.1;
gamma=0;

%sim('Ch2CSTRClosedLoopIdealPIDFilter_Sys',[0 tf]);
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);
% Plot figures
subplot(222);
plot(C_B.Time,C_B.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 65 75]);
legend('Ref', 'PID M_s=2.0','PID M_s=1.6');

subplot(224);
plot(Fr.Time,Fr.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 40 70]);
legend('PID M_s=2.0','PID M_s=1.6');

fprintf('PID - Ms=1.6 IAE= %f TV=%f \n',IAE.Data(length(IAE.Data)),sum(abs(diff(u.Data))));



