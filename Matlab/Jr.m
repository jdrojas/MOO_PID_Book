function IAE=Jr(ParamContr,ParamPlant,time)
x0=zeros(4,1);
r=ones(size(time));
do=zeros(size(time));
di=zeros(size(time));
y=SOPTDPIDSimu(ParamPlant,ParamContr,time,r,di,do,x0);
IAE=trapz(time,abs(r-y));