function IAE=Jdi(ParamContr,ParamPlant,time)
x0=zeros(4,1);
r=zeros(size(time));
do=zeros(size(time));
di=ones(size(time));
y=SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
IAE=trapz(time,abs(r-y));