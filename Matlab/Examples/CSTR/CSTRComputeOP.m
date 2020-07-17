% Compute operating points for CSTR system
clear;clc

Cai = 10;
k1 = 5/6; 
k2 = 5/3;
k3 = 1/6;
V = 700;
u = linspace(0,100,200).';
Fr = 634.1719/100 * u;
param = [k1;k2;k3;V];
Ca = zeros(size(u));
Cb = zeros(size(u));
for i=1:length(u)
    poli = [k3,(k1+Fr(i)/V), -Fr(i)/V*Cai];
    x = roots(poli);
    Ca(i) = max(x);
    Cb(i) = k1*Ca(i)/(Fr(i)/V+k2);
end
%
CaM10 = zeros(size(u));
CbM10 = zeros(size(u));
for i=1:length(u)
    poli = [k3,(k1+Fr(i)/V), -Fr(i)/V*(Cai*1.1)];
    x = roots(poli);
    CaM10(i) = max(x);
    CbM10(i) = k1*CaM10(i)/(Fr(i)/V+k2);
end
%
Cam10 = zeros(size(u));
Cbm10 = zeros(size(u));
for i=1:length(u)
    poli = [k3,(k1+Fr(i)/V), -Fr(i)/V*(Cai*0.9)];
    x = roots(poli);
    Cam10(i) = max(x);
    Cbm10(i) = k1*Cam10(i)/(Fr(i)/V+k2);
end

figure(1)
plot(u,Ca,'linewidth',1.5);
hold all
plot(u,CaM10,'--');
plot(u,Cam10,'--');
hold off
grid on
xlabel('u (%)');
ylabel('C_a concentration (moles/liter)')

figure(2)
plot(u,Cb,'linewidth',1.5);
hold all
plot(u,CbM10,'--');
plot(u,Cbm10,'--');
hold off
grid on
xlabel('u (%)');
ylabel('C_b concentration (moles/liter)')
%
figure(3)
y = 100/1.5714 * Cb;
yM = 100/1.5714 * CbM10;
ym = 100/1.5714 * Cbm10;
plot(u,y,'linewidth',1.5);
hold all
plot(u,yM,'--');
plot(u,ym,'--');
hold off
xlabel('u (%)');
ylabel('y (%)')
grid on
%
figure(4)
plot(Ca,Cb,'linewidth',1.5)
hold all
plot(CaM10,CbM10,'--')
plot(Cam10,Cbm10,'--')
Ca0 = 2.917496611031752;
Cb0 = 1.099991103606458;
plot(Ca0, Cb0, 'o');
plot([0;Ca0],[Cb0,Cb0],'b-.');
plot([Ca0;Ca0],[Cb0,0],'b-.');
hold off
grid on
xlabel('C_a (moles/liter)')
ylabel('C_b (moles/liter)')