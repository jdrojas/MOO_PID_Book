function [JdiVec,JdoVec,JrVec,KpVec,TiVec,TdVec,betaVec]=seleccionar(t0,a,Ms)
% Devuelve los vectores de b�squeda, de acuerdo con las caracter�sticas de
% la planta
archivo=['ParetoX_a',num2str(a),'_to',num2str(t0),'_ms',num2str(Ms),'.csv'];
%folder=['./Ms',num2str(Ms)]; %comentar después
%cd(folder) % comentar despues
M=csvread(archivo,1,0);
%cd ..% comentar despues
JdiVec=M(:,10);
JdoVec=M(:,11);
JrVec=M(:,12);
KpVec=M(:,3);
TiVec=M(:,4);
TdVec=M(:,5);
betaVec=M(:,6);