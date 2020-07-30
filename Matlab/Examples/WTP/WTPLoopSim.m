clear; clc
WTPInit;
h = load_system('WTPLoop');
Kp = linspace(0,10,32);
Ti = linspace(0.1,10,32);
[KP,TI] = meshgrid(Kp,Ti);
IaeGrid = zeros(length(Kp)*length(Ti),1);
TVGrid = zeros(length(Kp)*length(Ti),1);
for i=1:(length(Kp)*length(Ti))
    disp(i/(length(Kp)*length(Ti))*100);
    [IAE,TV] = WTPPerformance([KP(i);TI(i)]);
    IaeGrid(i) = IAE;
    TVGrid(i) = TV;
    clc;
end
plot(IaeGrid,TVGrid,'.');
indices = paretoQS([IaeGrid, TVGrid]);
hold on;
plot(IaeGrid(indices),TVGrid(indices),'ro');
hold off;
grid on
xlabel('IAE');
ylabel('TV');

function [IAE,TV] = WTPPerformance(x)
Kp = x(1);
Ti = x(2);
set_param('WTPLoop/Kp','Gain',num2str(Kp));
set_param('WTPLoop/Ti','Gain',num2str(1/Ti));
result = sim('WTPLoop');
IAE = result.yout{1}.Values.Data(end);
TV = result.yout{2}.Values.Data(end);
end

function iae = WTPIAE(x)
[iae,~] = WTPPerformance(x);
end

function tv = WTPTV(x)
[~,tv] = WTPPerformance(x);
end