% This script computes all data point for several plants and several
% robusteness values. The final product is a set of .csv files with the
% results. At the end, this script is for crunching numbers.
clear; clc;
%
%---------------------Optimization parameters------------------------------
Fnum 	= 3; % number of functions: Jdi, Jdo and Jr
nvars   = 4; % number of variables: Kp,Ti,Td,beta
%VLD : see below
VUB     = [10 10 10 1]; % variables upper bound
npoints=10; % Number of points. For 3 functions, the number of point are larger than npoints con 65 hace 2145 puntos mas o menos
algorithm='interior-point'; %'interior-point' 'active-set'
%--------------------------------o-----------------------------------------
%
%--------------------------Set of plants-----------------------------------
% This is the set of plants. Since the plants are normalized, the only
% values that change are the normalized delay and the value of a
Lv=0.1;%:0.1:2;
av=0;%:0.1:1;
% These are the values of Ms that are going to be tested
Msv=2;%[2,1.8,1.6,1.4];%[2,1.8,1.6,1.4];
%--------------------------------o-----------------------------------------
%
K=1; % normalized gain
T=1; % normalized lag time
alpha=0.1; % constant for the derivative
gamma=0.0;
disp(['El proceso inicio el ',datestr(clock)])
for l=1:length(Msv)
    Ms=Msv(l);
    for j=1:length(Lv)
        L=Lv(j);
        for k=1:length(av)
            a=av(k);
            ParamPlant=[K;T;L;a];
            %--------------------------------------------------------------
            % The initial point is computed using the usort2 algorithm
            [Kp,Ti,Td,beta]=usort2(K,T,L,a,Ms);%initial controller
            pasoTiempo=min([Ti,Td,L,0.1])/10;
            VLB = [0 pasoTiempo*5 pasoTiempo*5 0]; % variables lower bound
            time=(0:pasoTiempo:200).'; % time for each simulation
            X0=repmat([Kp;Ti;Td;beta],1,Fnum); % initial point
            %
            Fmhandle = @(x) [Jdi([x(1);x(2);x(3);alpha;x(4);gamma],ParamPlant,time);...
                Jdo([x(1);x(2);x(3);alpha;x(4);gamma],ParamPlant,time);...
                Jr([x(1);x(2);x(3);alpha;x(4);gamma],ParamPlant,time)...
                ];% The multidimentional cost function
            Conhandle = @(x) MsConstraint(x,ParamPlant,Ms); %Robustness constraint
            %
            % Guardar resultados
            FileName=['ParetoX_a',num2str(a),'_to',num2str(L),'_ms',num2str(Ms),'.csv'];
            Header='a,t0,Kp,Ti,Td,beta,Jdi,Jdo,Jr,JdiNorm,JdoNorm,JrNorm,Ms';
            fid=fopen(FileName,'w');
            fprintf(fid,'%s\r\n',Header);
            fclose(fid);
            %--------------------------------------------------------------------------
            % Optimization with ENNC
            [Pareto_Fmat, Pareto_Xmat,Exit] = ENNC(X0,nvars,Fnum,VLB,VUB,npoints,algorithm,Fmhandle,Conhandle);
            %--------------------------------------------------------------------------
            % Filtering the results to eliminate non-pareto Points
            x = paretoset(Pareto_Fmat'); %position of the pareto points
            ParetoFun = Pareto_Fmat(:,x).';
            ParetoVar = Pareto_Xmat(:,x).';
            % Compute Ms for all optimal controllers
            P=tf(K,conv([T,1],[a*T,1]),'iodelay',L);
            [n,m]=size(ParetoVar);
            Msvec=zeros(n,1);
            for i=1:n
                Kpo=ParetoVar(i,1);
                Tio=ParetoVar(i,2);
                Tdo=ParetoVar(i,3);
                betao=ParetoVar(i,4);
                C=tf(Kpo*[(1+alpha)*Tio*Tdo,(Tio+alpha*Tdo),1],[alpha*Tio*Tdo,Tio,0]);
                Msvec(i)=MsCalc(pade(P,5),C);
            end
            % Normalize values
            FunMax = repmat(max(ParetoFun),[n,1]);
            FunMin = repmat(min(ParetoFun),[n,1]);
            ParetoFunNorm = (ParetoFun-FunMin)./(FunMax-FunMin);
            dlmwrite(FileName,[a*ones(n,1),L/T*ones(n,1),ParetoVar,ParetoFun,ParetoFunNorm,Msvec],'delimiter',',','-append');
        end
    end
end
disp(['El proceso finalizo el ',datestr(clock)])