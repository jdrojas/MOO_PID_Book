% Compute operating points for CSTR system
clear;clc
model = 'CSTR';
CSTRInit;
step = 10e-3;
tfinal = 15;
t = (0:step:tfinal)';
u = 60 + 10*( t > 5);
Cai = 10*ones(size(t));
%open_system(model);
in = Simulink.SimulationInput(model);
in = in.setExternalInput([t, u, Cai]);
simOut = sim(in);
y = simOut.yout{1}.Values.Data;
Ca = simOut.yout{2}.Values.Data;
Cb = simOut.yout{3}.Values.Data;
tsim = simOut.tout;
figure(1)
plot(tsim,y,'linewidth',1.5);
xlabel('Time (s)');
ylabel('Output (%)');
grid on;
figure(2)
subplot(2,1,1)
plot(tsim,Ca,'linewidth',1.5);
xlabel('Time (s)');
ylabel('Ca (moles per liter)');
grid on;
%
subplot(2,1,2)
plot(tsim,Cb,'linewidth',1.5);
xlabel('Time (s)');
ylabel('Cb (moles per liter)');
grid on;