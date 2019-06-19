%-----------------------------------------------
%
% Industrial PID Controller Tuning
% with a multi-objective framework using MATLAB?
%
% Jose David Rojas, Orlando Arrieta, Ramon Vilanova
%
% Examples Chapter 2 : IndustrialPIDControl
%
% CSTR Open Loop simulation
%
%-----------------------------------------------
clear all;
close all;
clc;

% Initial concentrations and operation point
C_Ao=2.9175;    % mol l?1
C_Bo=1.10;      % mol l?1
C_Afeed=10;     % mol l?1
Fr_in=60;       % percentage

% Changes
Fr_Change=20;       % Percentage change
Fr_instant=2;       % Time to apply change
C_Afeed_Change=-10;  % Percentage change
C_Afeed_instant=10;  % Time to apply change


% Simulation
tf=20;
sim('Ch2CSTROpenLoop_Sys',[0 tf]);

% Plot figures
subplot(211);
plot(C_B.Time,C_B.Data,'r');
xlabel(' Time [min]');
ylabel(' Output C_B [%]'); 
title('CSTR : Output concentration ');
axis([0 tf 60 80]);

subplot(212);
plot(Fr.Time,Fr.Data,'r');
xlabel(' Time [min]');
ylabel(' Feed Fr [%]'); 
title('CSTR : Manipulated Variable');
axis([0 tf 40 80]);



