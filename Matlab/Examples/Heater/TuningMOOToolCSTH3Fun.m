clear; clc;
time = (0:0.01:3000).';
r = 1*(time >= 100);
di = 1*(time >= 1000);
do = 1*(time >= 2000);
x0 = zeros(4,1);
%--------------------------------------------------------------------------
%----------- -------------- Jdo anchor point ------------------------------
%--------------------------------------------------------------------------
load('Results3FunCSTHBestJdo') % loads plant and controller parameters
Kp = MOOResults.Kp;
Ti = MOOResults.Ti;
Td = MOOResults.Td;
beta = MOOResults.beta;
%
ParamContr = [Kp; Ti; Td; 0.1; beta; 0];
%
%Simulate model
[yJdo,~,uJdo] = SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
%
iaeJr_Jdo = trapz(time(time<1000), abs(r(time<1000)-yJdo(time<1000)));
iaeJdi_Jdo = trapz(time(time >= 1000 & time<2000),...
    abs(r(time >= 1000 & time<2000)-yJdo(time >= 1000 & time<2000)));
iaeJdo_Jdo = trapz(time(time >= 2000),...
    abs(r(time >= 2000)-yJdo(time >= 2000)));
TVJdo = sum(abs(diff(uJdo)));
figure(1)
plot(time,yJdo)
grid on
xlabel('time(s)')
ylabel('output amplitude')
%
%--------------------------------------------------------------------------
%----------- -------------- Jdi anchor point ------------------------------
%--------------------------------------------------------------------------
load('Results3FunCSTHBestJdi') % loads plant and controller parameters
Kp = MOOResults.Kp;
Ti = MOOResults.Ti;
Td = MOOResults.Td;
beta = MOOResults.beta;
%
ParamContr = [Kp; Ti; Td; 0.1; beta; 0];
%
%Simulate model
[yJdi,~,uJdi] = SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
%
iaeJr_Jdi = trapz(time(time<1000), abs(r(time<1000)-yJdi(time<1000)));
iaeJdi_Jdi = trapz(time(time >= 1000 & time<2000),...
    abs(r(time >= 1000 & time<2000)-yJdi(time >= 1000 & time<2000)));
iaeJdo_Jdi = trapz(time(time >= 2000),...
    abs(r(time >= 2000)-yJdi(time >= 2000)));
TVJdi = sum(abs(diff(uJdi)));
figure(2)
plot(time,yJdi)
grid on
xlabel('time(s)')
ylabel('output amplitude')
%
%
%--------------------------------------------------------------------------
%----------- -------------- Jr anchor point -------------------------------
%--------------------------------------------------------------------------
load('Results3FunCSTHBestJr') % loads plant and controller parameters
Kp = MOOResults.Kp;
Ti = MOOResults.Ti;
Td = MOOResults.Td;
beta = MOOResults.beta;
%
ParamContr = [Kp; Ti; Td; 0.1; beta; 0];
%
%Simulate model
[yJr,~,uJr] = SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
%
iaeJr_Jr = trapz(time(time<1000), abs(r(time<1000)-yJr(time<1000)));
iaeJdi_Jr = trapz(time(time >= 1000 & time<2000),...
    abs(r(time >= 1000 & time<2000)-yJr(time >= 1000 & time<2000)));
iaeJdo_Jr = trapz(time(time >= 2000),...
    abs(r(time >= 2000)-yJr(time >= 2000)));
TVJr = sum(abs(diff(uJr)));
figure(3)
plot(time,yJr)
grid on
xlabel('time(s)')
ylabel('output amplitude')
%
figure(4)
plot(time,[yJr,yJdi,yJdo],'linewidth',1)
grid on
xlabel('time(s)')
ylabel('Tank temperature sensor (%)')
legend('J_r anchor','J_{di} anchor','J_{do} anchor')
%
figure(5)
plot(time(time<2000),[uJr(time<2000),uJdi(time<2000),uJdo(time<2000)],'linewidth',1)
grid on
xlabel('time(s)')
ylabel('Temperature control valve (%)')
legend('J_r anchor','J_{di} anchor','J_{do} anchor')
%
%
figure(6)
plot(time(time>=2000),[uJr(time>=2000),uJdi(time>=2000),uJdo(time>=2000)],'linewidth',1)
grid on
xlabel('time(s)')
ylabel('Temperature control valve (%)')
legend('J_r anchor','J_{di} anchor','J_{do} anchor')
