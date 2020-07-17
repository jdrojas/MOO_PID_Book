function F=CSTROP(x,u,param)
k1 = param(1); 
k2 = param(2);
k3 = param(3);
V  = param(4);

Fr = 634.1719/100 * u(1);
Cai = u(2);

Ca = x(1);
Cb = x(2);
F = [Fr/V * (Cai - Ca) - k1*Ca - k3*Ca^2
    -Fr/V*Cb + k1*Ca - k2 *Cb];


