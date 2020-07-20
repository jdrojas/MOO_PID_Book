clear; clc;
load('CSTRControllers');
t = (0:0.01:20)';
r = 1*(t>=1);
di = 1*(t>=10);
do = zeros(size(t));
x0 = zeros(4,1);
%
Kp(1) = MOOResultsC1_2.Kp;
Kp(2) = MOOResultsC2_2.Kp;
Kp(3) = MOOResultsC3_2.Kp;
Kp(4) = MOOResultsC4_2.Kp;
%
Ti(1) = MOOResultsC1_2.Ti;
Ti(2) = MOOResultsC2_2.Ti;
Ti(3) = MOOResultsC3_2.Ti;
Ti(4) = MOOResultsC4_2.Ti;
%
Td(1) = MOOResultsC1_2.Td;
Td(2) = MOOResultsC2_2.Td;
Td(3) = MOOResultsC3_2.Td;
Td(4) = MOOResultsC4_2.Td;
%
beta(1) = MOOResultsC1_2.beta;
beta(2) = MOOResultsC2_2.beta;
beta(3) = MOOResultsC3_2.beta;
beta(4) = MOOResultsC4_2.beta;
%
ParamPlant = [MOOResultsC1_10.k;MOOResultsC1_10.T; MOOResultsC1_10.L; MOOResultsC1_10.a];
ParamContr1 = [Kp(1); Ti(1); Td(1); 0.1; beta(1); 0];
ParamContr2 = [Kp(2); Ti(2); Td(2); 0.1; beta(2); 0];
ParamContr3 = [Kp(3); Ti(3); Td(3); 0.1; beta(3); 0];
ParamContr4 = [Kp(4); Ti(4); Td(4); 0.1; beta(4); 0];
[y1,~,u1]=SOPTDPIDSimu(ParamPlant,ParamContr1,t,r,di,do,x0);
[y2,~,u2]=SOPTDPIDSimu(ParamPlant,ParamContr2,t,r,di,do,x0);
[y3,~,u3]=SOPTDPIDSimu(ParamPlant,ParamContr3,t,r,di,do,x0);
[y4,~,u4]=SOPTDPIDSimu(ParamPlant,ParamContr4,t,r,di,do,x0);
%
figure(1)
plot(t,[y1,y2,y3,y4]);
legend('C1', 'C2', 'C3', 'C4');
grid on
xlabel('Time (min)');
ylabel('Output change (%)')
%
figure(2)
plot(t,[u1,u2,u3,u4]);
legend('C1', 'C2', 'C3', 'C4');
grid on
xlabel('Time (min)');
ylabel('Input change (%)')
%
%---------------------------------------------------------------------------
%
Kp(1) = MOOResultsC1_10.Kp;
Kp(2) = MOOResultsC2_10.Kp;
Kp(3) = MOOResultsC3_10.Kp;
Kp(4) = MOOResultsC4_10.Kp;
%
Ti(1) = MOOResultsC1_10.Ti;
Ti(2) = MOOResultsC2_10.Ti;
Ti(3) = MOOResultsC3_10.Ti;
Ti(4) = MOOResultsC4_10.Ti;
%
Td(1) = MOOResultsC1_10.Td;
Td(2) = MOOResultsC2_10.Td;
Td(3) = MOOResultsC3_10.Td;
Td(4) = MOOResultsC4_10.Td;
%
beta(1) = MOOResultsC1_10.beta;
beta(2) = MOOResultsC2_10.beta;
beta(3) = MOOResultsC3_10.beta;
beta(4) = MOOResultsC4_10.beta;
%
ParamPlant = [MOOResultsC1_10.k;MOOResultsC1_10.T; MOOResultsC1_10.L; MOOResultsC1_10.a];
ParamContr1 = [Kp(1); Ti(1); Td(1); 0.1; beta(1); 0];
ParamContr2 = [Kp(2); Ti(2); Td(2); 0.1; beta(2); 0];
ParamContr3 = [Kp(3); Ti(3); Td(3); 0.1; beta(3); 0];
ParamContr4 = [Kp(4); Ti(4); Td(4); 0.1; beta(4); 0];
[y1,~,u1]=SOPTDPIDSimu(ParamPlant,ParamContr1,t,r,di,do,x0);
[y2,~,u2]=SOPTDPIDSimu(ParamPlant,ParamContr2,t,r,di,do,x0);
[y3,~,u3]=SOPTDPIDSimu(ParamPlant,ParamContr3,t,r,di,do,x0);
[y4,~,u4]=SOPTDPIDSimu(ParamPlant,ParamContr4,t,r,di,do,x0);
%
figure(3)
plot(t,[y1,y2,y3,y4]);
legend('C1', 'C2', 'C3', 'C4');
grid on
xlabel('Time (min)');
ylabel('Output change (%)')
%
figure(4)
plot(t,[u1,u2,u3,u4]);
legend('C1', 'C2', 'C3', 'C4');
grid on
xlabel('Time (min)');
ylabel('Input change (%)')
%