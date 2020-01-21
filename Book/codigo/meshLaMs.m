function [LMesh,aMesh,MsMesh] = meshLaMs(Lv,av,Msv)
% This function finds all possible commutations of the vectors. The idea is
% to use one single for to compute all the paretos, which is usefull for
% paralelization
if iscolumn(Lv)
    L=Lv;
else
    L=Lv.';
end
%
if iscolumn(av)
    a=av;
else
    a=av.';
end
%
if iscolumn(Msv)
    Ms=Msv;
else
    Ms=Msv.';
end
Lsize=length(L);
asize=length(a);
Mssize=length(Ms);
%LMesh=0;
MsMesh=repmat(Ms,Lsize*asize,1);
aMesh=reshape(repmat(a',Mssize,Lsize),Mssize*Lsize*asize,1);
LMesh=reshape(repmat(L',Mssize*asize,1),Mssize*Lsize*asize,1);
