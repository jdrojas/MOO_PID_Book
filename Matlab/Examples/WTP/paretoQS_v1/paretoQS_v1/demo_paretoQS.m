%% Generate population of XY data

% Mimic pareto curve as random variation from y=1/x
xyRng=5;
mgDev=.75;
x=linspace(1/xyRng,xyRng,5000).';
rawData=[x+mgDev.*randn(size(x))... %OF1
    1./x+mgDev.*randn(size(x))... %OF2
    ];

%Find pareto optimal front
indPar=paretoQS(rawData);

%Plot original with pareto point circled
figure
plot(rawData(:,1),rawData(:,2),'b.');hold on
plot(rawData(indPar,1),rawData(indPar,2),'ro');
legend('Raw Data','Pareto Optimal','location','best')
xlabel('OF1');
ylabel('OF2');


%% Generate population of 3D data

% Mimic pareto surface as random variation from z=1/xy
[X,Y] = meshgrid(linspace(1/xyRng,xyRng/5,100));
rawDataXYZ=[X(:)+mgDev.*randn(numel(X),1)... %OF1
    Y(:)+mgDev.*randn(numel(X),1)... %OF2
    1./X(:)./Y(:)+mgDev.*randn(numel(X),1)... %OF3
    ];

%Find pareto optimal front
indParXYZ=paretoQS(rawDataXYZ);

%Plot original with pareto point circled
figure
plot3(rawDataXYZ(:,1),rawDataXYZ(:,2),rawDataXYZ(:,3),'b.');hold on
plot3(rawDataXYZ(indParXYZ,1),rawDataXYZ(indParXYZ,2),rawDataXYZ(indParXYZ,3),'ro');
legend('Raw Data','Pareto Optimal','location','best')
xlabel('OF1');
ylabel('OF2');
zlabel('OF3');

