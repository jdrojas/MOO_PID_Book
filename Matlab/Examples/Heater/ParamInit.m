% Paramenters of the CSTH
rho = 1200; %tank fluid density, ρ = 1200 kgm −3 ,
rhoC = 800; %heating fluid density, ρ c = 800 kgm −3 ,
D = 0.30; %tank diameter, D = 0.30 m,
A = pi*D^2/4;%tank inside section area, A = π D 2 /4 m 2 ,
Hc = 0.6; %heating jacket height, H c = 0.60 m,
Ac = pi*D*Hc + pi*D^2/4;% jacket heat transfer area, A c = π D H c + π D 2 /4 m 2 ,
Cp = 4190; % tank fluid heat capacity, C p = 4190 Jkg −1◦ C −1 ,
Cpc = 2400; %heating fluid heat capacity, C pc = 2400 Jkg −1◦ C −1 ,
g = 9.8; %gravity constant, g = 9.8 ms −2 ,
Ht = 0.9; %tank wall height, H t = 0.90 m,
Hsp = 0.7; %level controller set-point, H sp = 0.70 m,
KL = 125; %level transmitter gain, K L = 125 %m,
KT = 2.0; %temperature transmitter gain, K T = 2.0 %/ ◦ C,
KvL = 1.5e-5; %level control valve constant, K vL = 1.5 × 10 −5 ,
KvT = 3e-6; %temperature control valve constant, K vT = 3 × 10 −6 ,
KxL = 0.01; %level control valve stem constant, K x L = 0.01/%,
KxT = 0.01; %temperature control valve stem constant, K x T = 0.01/%,
Pcp = 414*1000;% : heating fluid pump discharge pressure, P cp = 414 kpa,
Pcr = 138*1000;% : heating fluid system return pressure, P cr = 138 kpa;
Rc = 5.5e7*1000; %heating system pipe nominal flow resistance, R c = 5.5 × 10 7 kPa/(m 3 /s) 2
RvT = 50; %temperature control valve rangeability, R vT = 50;
Tsp = 38; %temperature controller set-point, T sp = 38 ◦ C
TL = 2; %level transmitter time constant, T L = 2 s,
TT = 15; %temperature transmitter time constant, T T = 15 s,
TvL = 3; %level control valve time constant, T vL = 3 s,
TvT = 5; %temperature control valve time constant, T vT = 5 s
U = 440; %overall heat-transfer coefficient, U = 440 Js −1 m −2◦ C −1 ,
Wc = 0.02; % : heating jacket wide, W c = 0.02 m,
Vc = Hc*pi*((D+2*Wc)^2 - D^2)/4 + Wc*pi*(D + 2*Wc)^2/4; % heat jacket volume,
% Initial conditions of the states for the operating point
T0  = 38;%30.345;%
H0 = 0.7;
Tca0 = 214.03;%110.1;%
YL0 = 87.5;
YT0 = 76;%60.7;%
XL0 = 0.7172;
XT0 = 0.344;
% Inputs and disturbances for the operating point
UL0 = 71.72;
UT0 = 34.40;%85.0;%
Tin = 24.0; % fluid inlet temperature, 22 ◦ C ≤ T i ≤ 26 ◦ C, temperature T i n = 24 ◦ C,
Tci = 320.0; %heating fluid inlet temperature, T ci = 320 ◦ C,
Qin = 7e-4; % tank inlet fluid flow rate, 6 × 10 −4 m 3 s −1 ≤ Q i ≤ 7.5 × 10 −4 m 3 s −1 ,
            % normal tank inlet fluid flow rate Q i n = 7 × 10 −4 m 3 s −1 ,