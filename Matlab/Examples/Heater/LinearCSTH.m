clear; clc;
Results = sim('CSTH_Linearization');
plot(Results.y.Time,Results.y.Data(:,1),'--',Results.y.Time,Results.y.Data(:,2));
grid on;
xlabel('Time (s)');
ylabel('Y_T (%)');
legend('Non linear model','Linearized model','location','southeast');