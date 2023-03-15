clc,clear,close all
c=100000;
a1=[c+24 c-8 0 0];
a2=[8+c -16 8-c 0];
a3=[0 8+c -16 8-c];
a4=[0 0 c+8 c-24];
A=[a1;a2;a3;a4];
b=[0 0 0 2*c-16];
b=b';
ff=@myfunction;
ans=A\b
ans_real=[ff(0.125,c);ff(0.375,c);ff(0.625,c);ff(0.875,c)]

err=norm(ans_real-ans,2)/norm(ans_real,2)

function f=myfunction(x,c)
% f=(exp(c*x)-1)/(exp(c)-1);
f=(exp(c*(x-1))-exp(-c))/(1-exp(-c));
end
