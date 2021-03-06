% Compute operating points for CSTR system
clear; clc
model = 'CSTRExampleControl';
CSTRInit;
step = 10e-3;
tfinal = 8;
t = (0:step:tfinal)';
%
r = 70 + 5*(t>1);
%r = 70*ones(size(t));
Cai = 10*ones(size(t));
%Cai = 10 + 3*(t>1);
%
% Controller
load('CSTRControllers');
ContrNum = 1:4;
Ms = 18;
y = cell(1,length(ContrNum));
u = cell(1,length(ContrNum));

for i = 1:length(ContrNum)
%ContrNum = 1;
controller = ['MOOResultsC',num2str(ContrNum(i)),'_',num2str(Ms)];
eval(['Kp = ', controller, '.Kp;']);
eval(['Ti = ', controller, '.Ti;']);
eval(['Td = ', controller, '.Td;']);
eval(['alpha = ', controller, '.alpha;']);
eval(['beta = ', controller, '.beta;']);
eval(['gamma = ', controller, '.gamma;']);
in = Simulink.SimulationInput(model);
in = in.setExternalInput([t, r, Cai]);
simOut = sim(in);
y{i} = simOut.yout{1}.Values.Data;
u{i} = simOut.yout{2}.Values.Data;
end
%
figure(1)
for i = 1:length(ContrNum)
    plot(t,y{i});
    hold on
end
hold off;
grid on;
legend({'C1';'C2';'C3';'C4'})
xlabel('time (min)');
ylabel('Output (%)');
%
figure(2)
for i = 1:length(ContrNum)
    plot(t,u{i});
    hold on
end
hold off;
grid on;
legend({'C1';'C2';'C3';'C4'})
xlabel('time (min)');
ylabel('Control signal  (%)');
%
Y = cell2mat(y);
R = repmat(r,1,length(ContrNum));
ERROR = abs(R-Y);
IAE = trapz(t, ERROR);
U = cell2mat(u);
TV = sum(abs(diff(U)));
disp('IAE: ');
disp(IAE)
disp('TV: ');
disp(TV)