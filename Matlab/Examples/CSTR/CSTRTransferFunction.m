clear; clc;
CSTRInit;
CSTRSS = ss(A,B,C,D);
FTotal = tf(CSTRSS);
F = FTotal(1);
simulation = sim('CSTRExampleLinear');
figure(1)
plot(simulation.yLinear.Time,simulation.yLinear.Data, simulation.yNonLinear.Time,simulation.yNonLinear.Data,'--');
legend('Linear', 'Nonlinear');
xlabel('time (min)');
ylabel('Output (%)');
grid on
%
% Skogestad approximation
K = dcgain(F);
p = F.den{1}/F.den{1}(end);
L = - F.num{1}(2)/F.num{1}(3);
FSko = tf(K,p);
FSko.iodelay = L;
yLinearSko = lsim(FSko,(simulation.u.Data - u0),simulation.u.Time) + y0;
figure(2)
plot(simulation.yLinear.Time,simulation.yLinear.Data, simulation.u.Time,yLinearSko,'--');
legend('Linear', 'Skogestad approximation');
xlabel('time (min)');
ylabel('Output (%)');
grid on
%
FSkoZPK = zpk(FSko);
a = FSkoZPK.P{1}(2)/FSkoZPK.P{1}(1);
tau = -1/FSkoZPK.P{1}(1);