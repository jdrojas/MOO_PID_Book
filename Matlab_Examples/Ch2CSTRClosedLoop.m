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

% Initial concentrations
C_Ao=2.9175;    % mol l?1, initial concentrarions on reactor
C_Bo=1.10;      % mol l?1, initial concentrarions on reactor
C_Afeed=10;     % mol l?1, initial concentration on C_A feed 

% Operating point
Fr_in=60;         % Percentage control input
C_Bin=70;         % percentage for output concentration

% Changes
C_Afeed_Change=-5;  % Percentage change
C_Afeed_instant=10; % Time to apply change
Fr_Change=-10;       % Percentage change
Fr_instant=20;       % Time to apply change
Ref_C_B_Change=5;   % Percentage change
Ref_C_B_instant=2;  % Time to apply change


% Parameters for the PID controller
Kp = 3.33;
Ti = 0.685; 
Td = 0.18;
beta=0.5;
alpha=0.1;
gamma=0;

% Simulation
tf=30;
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);

% Plot figures
subplot(211);
plot(Ref.Time, Ref.Data,'k--', C_B.Time,C_B.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 65 80]);

subplot(212);
plot(Fr.Time,Fr.Data,'r'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 50 100]);

% Simulation for the PI controller
Td=0;
sim('Ch2CSTRClosedLoop_Sys',[0 tf]);
% Plot figures
subplot(211);
plot(C_B.Time,C_B.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' C_B [%]: Reference (Black dash) Output (red solid)'); 
title('CSTR : Output concentration ');
axis([0 tf 65 80]);
legend('Ref', 'PID','PI');

subplot(212);
plot(Fr.Time,Fr.Data,'b'); hold on;
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('Fr [%] : Control action');
axis([0 tf 50 100]);
legend('PID','PI');

