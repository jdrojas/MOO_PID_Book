function [Kp,Ti,Td,beta]=usort2(K,T,L,a,Ms)
if(nargin<3)
    error('input:NumberInput','Insuficient number of inputs');
elseif(nargin<=3)
    a=0;
    Ms=2;
elseif(nargin<=4)
    Ms=2;
elseif(nargin>5)
    warning('Extra input variables ignored')
end

aV=[0.0;0.25;0.50;0.75;1.0];
MsV=[1.4;1.6;1.8;2.0];
[aM,MsM]=meshgrid(aV,MsV);
if a>=0.0 && a<=1.0 && Ms<=2.0 && Ms>=1.4 && T>0 && K>0
    a0M=[0.149,0.176,0.229,0.151,0.195;...
        0.194,0.320,0.329,0.335,0.348;...
        0.227,0.392,0.403,0.410,0.421;...
        0.255,0.451,0.459,0.464,0.475];
    a1M=[0.462,0.394,0.365,0.506,0.521;...
        0.609,0.418,0.450,0.515,0.585;...
        0.726,0.482,0.521,0.600,0.690;...
        0.819,0.533,0.581,0.675,0.779];
    a2M=[-0.941,-0.952,-1.098,-0.951,-1.052;...
        -0.940,-1.099,-1.168,-1.199,-1.212;...
        -0.938,-1.128,-1.199,-1.232,-1.239;...
        -0.938,-1.146,-1.216,-1.249,-1.254];
    b0M=[-0.100,-0.168,0.209,0.324,0.305].';
    b1M=[1.189,1.106,1.197,1.217,1.375].';
    b2M=[0.519,0.519,0.502,0.529,0.491].';
    c0M=[0.0,0.086,0.088,0.071,0.054];
    c1M=[0.393,0.433,0.549,0.652,0.738];
    c2M=[0.857,0.720,0.554,0.500,0.455].';
    d0M=[0.441,0.315,0.339,0.439].';
    d1M=[0.858,0.664,0.476,0.278].';
    d2M=[0.658,0.524,0.440,0.560].';
    a0=interp2(aM,MsM,a0M,a,Ms);
    a1=interp2(aM,MsM,a1M,a,Ms);
    a2=interp2(aM,MsM,a2M,a,Ms);
    b0=interp1(aV,b0M,a);
    b1=interp1(aV,b1M,a);
    b2=interp1(aV,b2M,a);
    c0=interp1(aV,c0M,a);
    c1=interp1(aV,c1M,a);
    c2=interp1(aV,c2M,a);
    d0=interp1(MsV,d0M,Ms);
    d1=interp1(MsV,d1M,Ms);
    d2=interp1(MsV,d2M,Ms);
    tau0=L/T;
    Kp=1/K*(a0+a1*tau0^a2);
    Ti=T*(b0+b1*tau0^b2);
    Td=T*(c0+c1*tau0^c2);
    beta=min(1.5/Kp,d0+d1*tau0^d2);
else
    error('input:Range','Ms has to be between 1.4 and 2.0 and a has to be between 0 and 1, K>0 and T>0');
end