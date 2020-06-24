function [v1o] = fc_intrln(v1,v2,v2i)
%V.M. Alfaro, 2003
%fc_intrln encuentra el valor v1o en el vector v1
%correspondiente al valor v2i en el vector v2
%por interpolación lineal
%
%	[v1o]=fc_intrln(v1,v2,v2i)
%
%		v1, v2	-  par de vectores columna (v1,v2)
%		v2i		-  valor a encontrar en v2
%
%		v1o		-  valor correspondiente en v1
%
[v2f,v2c]=size(v2);
i=1;
while v2(i)<=v2i
	i=i+1;
	if i>v2f
		break
	end;
end;
if i==1
	v1o=v1(1);
else
	if i>v2f
		v1o=v1(v2f);
	else
		i1=i-1;i2=i;
		v1o=v1(i1)+(v1(i2)-v1(i1))*(v2i-v2(i1))/(v2(i2)-v2(i1));
	end;
end;