function [time,y,timePert] = ploter(K,T,a,L,Kp,Ti,Td,beta,t,Jdo,Jdi,Jr)

ParamPlant=[K;T;L;a];
alpha=0.1;
gamma=0;
ParamContr=[Kp,Ti,Td,alpha,beta,gamma].';
time = (0:0.01:t).';
%time = linspace(0, t, 10000).';

switch Jdo + Jdi + Jr
    case 0
        do=Jdo*time;
        di=Jdi*time;
        r=Jr*time;
        timePert=[0;0;0];
    case 1
        di=Jdi*(time>=t/2);
        do=Jdo*(time>=t/2);
        r=Jr*(time>=t/2);
        timePert=[Jdi;Jdo;Jr]*(t/2);
    case 2
        di=Jdi*(time>=t/3);
        do=Jdo*(time>=(1+Jdi)*t/3);
        r=Jr*(time>=(1+Jdo+Jdi)*t/3);
        timePert=[Jdi*t/3;Jdo*(1+Jdi)*t/3;Jr*(1+Jdo+Jdi)*t/3];
    case 3
        di=Jdi*(time>=t/4);
        do=Jdo*(time>=2*t/4);
        r=Jr*(time>=3*t/4);
        timePert=[t/4;2*t/4;3*t/4];
end

x0=zeros(4,1);%Estados iniciales, siempre poner en cero
%[y,u,x]=SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
[y,~,~]=SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
end