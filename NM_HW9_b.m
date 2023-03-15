clc,clear,close all
c=100000;
a1=[c+12 -4 0 0];
a2=[c+4 -c-8 4 0];
a3=[0 c+4 -c-8 4];
a4=[0 0 c+4 -12];
A=[a1;a2;a3;a4];
b=[0 0 0 c-8];
b=b';
ff=@myfunction;
ans=A\b
ans_real=[ff(0.125,c);ff(0.375,c);ff(0.625,c);ff(0.875,c)];

err=norm(ans_real-ans,2)/norm(ans_real,2)

function f=myfunction(x,c)
% f=(exp(c*x)-1)/(exp(c)-1);
f=(exp(c*(x-1))-exp(-c))/(1-exp(-c));
end
