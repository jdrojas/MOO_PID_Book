% Parameters
k1 = 5/6; 
k2 = 5/3;
k3 = 1/6;
V = 700;

% Operation point
Ca0 = 2.917496611031752;
Cb0 = 1.099991103606458;
u0 = 60;
Cai0 = 10;
Fr0 = 634.1719/100 * u0;
y0 = 100/1.5714*Cb0;

% Linear model
A = [-Fr0/V-k1-2*k3*Ca0, 0; k1, -Fr0/V-k2];
B = [6.341719*(Cai0-Ca0)/V, Fr0/V; -6.341719*Cb0/V, 0];
C = [0 100/1.5714];
D = [0, 0];