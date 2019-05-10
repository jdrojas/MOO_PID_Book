function [Pareto_Fmat, Pareto_Xmat, Exit] = ENNC(X0,nvars,Fnum,VLB,VUB,npoints,algorithm,Fmhandle,Conhandle)
%ENNC: Enhanced Normalized Normal Constraint method for multi-objective
%optimization.
%
%[Pareto_Fmat, Pareto_Xmat] = ENNC(X0,nvars,Fnum,VLB,VUB,npoints,algorithm,Fmhandle,Conhandle)
% X0: Individual initialization (nvars x Fnum) to find anchor points
% nvars: number of variables
% Fnum: number of objective functions
% VLB: lower bound value of variables
% VUB: upper bound value of variables
% npoints: number of points per function. The function creates all possible
%          combination of points for the weights
% algorithm: (string) Algorithm to be used in the optimization for fmincon
%               'active-set', 'interior-point', 'trust-region-reflective' 'sqp'
% Fmhandle: handle to the function that computes the cost function vector.
%           Fmhandle = @(x) myFun(x)
%           The function myFun(x) has to return a Fnum x 1 vector with the value of the
%           functions in point x
% Conhandle: handle to the function that computes the constraints function vector.
%           Conhandle = @(x) myCon(x)
%           The function myCon(x) has to return the vector c and ceq the value of the
%           functions in point x. The optimization problem is constraint
%           such as c(x)<0 and ceq(x)=0

% global variables
global g_Index g_T g_StartFN g_Uto g_Futo Weight

%%%%%%%%%%%%%%%%%%%%%%%%%Initialize Options%%%%%%%%%%%%%%%%%%%%%%%%
% Number of points - 1
Spac = npoints-1;

% Optimisation options
TolX  = 1e-7;
TolF  = 1e-7;
TolCon= 1e-9;
MaxFunEvals=5000;
MaxIter=5000;
options = optimset('TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','none' ,'Algorithm',algorithm);% iter notify
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Individual minima%%%%%%%%%%%%%%%%%%%%%%
%disp('----Step 1: finding individual minima...');
    
g_Futo = zeros(Fnum,1);
Xind   = zeros(nvars,Fnum);
Findiv  = zeros(Fnum);
FS=@(x) myFS(x,Fmhandle);
for i = 1:Fnum
    g_Index = i;
    xstart  = X0(:,i);    % individual initialization
    % Find individual minima
    [Xind(:,i),g_Futo(i)] = fmincon(FS,xstart,[],[],[],[],VLB,VUB,Conhandle,options);
    %-----------------------------------------------------------------------------------
    %-------------------- Just needed for the PID problem we're working on
    %right now------------------------------------------------------------
    if i~=Fnum
        g_Index = Fnum;
        FS2=@(x) myFS([Xind(1,i);Xind(2,i);Xind(3,i);x],Fmhandle); % Optimizar solo beta
        betaN= fmincon(FS2,Xind(4,i),[],[],[],[],VLB(4),VUB(4),[],options); % Conhandle does not matter, since beta does not affect Ms
        Xind(4,i)=betaN;
        g_Futo(i)=FS(Xind(:,i));
        g_Index = i;
    end
    %-----------------------------------------------------------------------------------
    % Find matrix with objective vectors for individual minima: Findiv = [F(x1*) | F(x2*) | ... | F(xn*)];
    Findiv(:,i)  = (Fmhandle(Xind(:,i)))';
end
%Xind
%g_Futo
%Findiv

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Normalize%%%%%%%%%%%%%%%%%
%disp('----Step 2: normalizing...');    
% Find Fnadir, Futopia, pay-off matrix PHI and scaling matrix T
%Fnadir  = max(Findiv,[],2);
g_Futo  = min(Findiv,[],2);
PHI     = Findiv-repmat(g_Futo,1,Fnum);
%g_T     = diag(1./(Fnadir-g_Futo));
g_T     = (ones(Fnum)-diag(ones(Fnum,1)))*(PHI^-1);

% Find normalized matrix with objective vectors for individual minima
FindivN = g_T*(Findiv-repmat(g_Futo,1,Fnum));


%%%%%%%%%%%%%%%%%%%%%%%%%%%Utopia plane vectors%%%%%%%%%%%%%%%
%disp('----Step 3: find normalized utopia plane vectors...');
g_Uto = repmat(FindivN(:,end),1,Fnum-1)-FindivN(:,1:Fnum-1);

%pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%weights%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('----Step 4: create weights...');
%[Weight, Near]  = Weightsf(Fnum,Spac);
Weight = Weightsf(Fnum,Spac);
num_w = size(Weight, 2);
%Weight
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%NNC Subproblems%%%%%%%%%%%%%%%%%%
%disp('Step 5: solve NNC sub-problems');
%disp('......Solving NNC sub-problems......');

%Pareto_FNmat = [];       % Pareto Optima in Normalized F-space
%Pareto_Xmat  = [];       % Pareto Optima in X-space
%Exit = [];
Pareto_FNmat = zeros(Fnum,num_w);       % Pareto Optima in Normalized F-space
Pareto_Xmat  = zeros(nvars,num_w);       % Pareto Optima in X-space
Exit = zeros(1,num_w);
% Starting point for first NNC subproblem is the minimizer of f_1(x)
xstart = Xind(:,1);

myENh=@(x) myEN(x,Fmhandle);
myENConh=@(x) myENCon(x,Conhandle,Fmhandle);
% solve NNC subproblems
for k = 1:num_w
    w  = Weight(:,k);      
    
    % Solve problem only if it is not minimizing one of the individual objectives
    indiv_fn_index = find( w == 1 );

    % the boundary solution which has been solved
    if indiv_fn_index ~= 0
      % w has a 1 in indiv_fn_index th component, zero in rest
      % Just read in solution from shadow data
      %Pareto_FNmat = [Pareto_FNmat, FindivN(:,indiv_fn_index)];
      %Pareto_Xmat  = [Pareto_Xmat,  Xind(:,indiv_fn_index)];
      %Exit=[Exit,10];
      Pareto_FNmat(:,k) = FindivN(:,indiv_fn_index);
      Pareto_Xmat(:,k)  = Xind(:,indiv_fn_index);
      Exit(k)=10;
    else 
      %start point in Normalized F-space
      g_StartFN = FindivN*w;
      % SOLVE NNC SUBPROBLEM
      %exitflag=10;
      %count=0;
      %while exitflag~=1 && count<=6
          %switch count
              %case 0
                  [x_trial,~,exitflag] = fmincon(myENh,xstart,[],[],[],[],VLB,VUB,myENConh,options);
%               case 1 % La primera vez no se lleg� bien, se intenta de nuevo con el �ltimo valor de la optimizaci�n
%                   [x_trial,tmp,exitflag] = fmincon(myENh,x_trial,[],[],[],[],VLB,VUB,myENConh,options);
%               case 2
%                   options = optimset('TolFun',TolF/100,'TolX',TolX/100,'TolCon',TolCon/100,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','iter','Algorithm',algorithm);%
%                   [x_trial,tmp,exitflag] = fmincon(myENh,x_trial,[],[],[],[],VLB,VUB,myENConh,options);
%                   options = optimset('TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','iter','Algorithm',algorithm);%
%               case 3 % Todav�a no, se intenta moviendo un poquito el valor inicial
%                   [x_trial,tmp,exitflag] = fmincon(myENh,x_trial+x_trial/10*sign(-1+2*rand),[],[],[],[],VLB,VUB,myENConh,options);
%               case 4 % tampoco se logr�, se intenta con otro m�todo
%                   if strcmp(algorithm,'interior point')
%                       algorithm2='active-set';
%                   elseif strcmp(algorithm,'active-set')
%                       algorithm2='interior-point';
%                   else
%                       algorithm2='interior-point';
%                   end
%                   options = optimset('TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','iter','Algorithm',algorithm2);%
%                   [x_trial,tmp,exitflag] = fmincon(myENh,x_trial,[],[],[],[],VLB,VUB,myENConh,options);
%                   options = optimset('TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','iter','Algorithm',algorithm);%
%               case 5
%                   options = optimoptions(@fmincon,'Algorithm',algorithm,'MaxIter',1500,'FinDiffType','central');
%                   [x_trial,tmp,exitflag] = fmincon(myENh,x_trial,[],[],[],[],VLB,VUB,myENConh,options);
%                   options = optimset('TolFun',TolF,'TolX',TolX,'TolCon',TolCon,'MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'Display','iter','Algorithm',algorithm);%
%               otherwise
%                   disp(':(');
%           end
%           
%           count=count+1;
      %end

%       Pareto_FNmat = [Pareto_FNmat, g_T*(Fmhandle(x_trial)-g_Futo)];         % Pareto optima in Normalized F-space
%       Pareto_Xmat  = [Pareto_Xmat,  x_trial(1:nvars)];                    % Pareto optima in X-space
%       Exit=[Exit,exitflag];
      Pareto_FNmat(:,k) = g_T*(Fmhandle(x_trial)-g_Futo);         % Pareto optima in Normalized F-space
      Pareto_Xmat(:,k)  = x_trial(1:nvars);                    % Pareto optima in X-space
      Exit(k)=exitflag;
      %disp('Xstart has been FIXED')
      xstart = Xind(:,1);
      %xstart = x_trial+x_trial*(rand/20)*sign(-1+2*rand);
      %xstart = x_trial;
    end % if indiv_fn_index ~= 0
end	

% De-normalize
%Pareto_Fmat = repmat(g_Futo,1,num_w) + Pareto_FNmat .* repmat(g_L,1,num_w);
Pareto_Fmat = repmat(g_Futo,1,num_w) + g_T^(-1)*Pareto_FNmat;

function f = myEN(x,myFMh)
global g_T g_Futo
% Minimise fm(x)
F  = (myFMh(x));
FN = g_T*(F-g_Futo);
f  = FN(end);

function [c,ceq] = myENCon(x,myConh,myFMh)
global g_Uto g_Futo g_T g_StartFN
[c1,ceq] = myConh(x);
% Additional NNC inequalities
F  = myFMh(x);
FN = g_T*(F-g_Futo);
ce = g_Uto'*(FN-g_StartFN);
c  = [c1;ce];

function f = myFS(x,Fhandle)
global g_Index
F = Fhandle(x);
f = F(g_Index);

function [Weights, Formers] = Weightsf( n, k )

global weight Weightsg Formersg Layer lastone currentone

%[Weight, Former] = Weights( n, k )
%
% Generates all possible weights for NBI subproblems given:
% n, the number of objectives
% 1/k, the uniform spacing between two w_i (k integral) 
% This is essentially all the possible integral partitions 
% of integer k into n parts.

% Function called : wtgener_test(n,k)

% Having allocated the global spaces for W (and an intermediate wt_vec)
% this calls wtgener_test to actually allocate the weights
weight        = zeros(1,n);
Weightsg     = [];
Formersg     = [];
Layer         = n;
lastone       = -1;
currentone  = -1;

Weight_Generate( 1, k );
Weights = Weightsg/k;
Formers=Formersg;

function [ ] = Weight_Generate( n, k )

global weight Weightsg Formersg Layer lastone currentone

% wtgener_test(n,k)
%
% Intended to test the weight generation scheme for NBI for > 2 objectives
% n is the number of objectives
% 1/k is the uniform spacing between two w_i (k integral)

% Recursive algorithm, courtesy of Sanjeeb Dash.

if ( n == Layer )
    if( currentone >= 0 )
        Formersg = [Formersg,lastone];
        lastone = currentone;
        currentone = -1;
    else
        num = size( Weightsg );
        Formersg = [Formersg,num(2)];
    end
    weight( Layer - n + 1 ) = k;
    Weightsg = [Weightsg,weight'];
else
    for i = 0 : k
        if( n == ( Layer - 2 ) )
            num = size(Weightsg);
            currentone = num(2)+1;
        end
        weight( Layer - n + 1 ) = i;
        Weight_Generate( n+1, k-i );
    end
end