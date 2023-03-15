clc,clear,close all
%create phi for random
n=1000;
x_i=randi([1,n],10,2)./n;
x=x_i(:,1);
y=x_i(:,2);
% cat(2,x,y)-phi    %確認x,y是否有錯誤

%create f_
ff=@myfunction1;
f=ff(x(1),y(1));
for i=2:10
f=cat(1,f,ff(x(i),y(i)));
end

%create phi
c_i=1;
phi_f=@myfunction2;
phi=zeros(10);
for i=1:10
    for j=1:10
        phi(i,j)=phi_f(x(i),y(i),x(j),y(j),c_i);
    end
end

%compute f_k
x_k=0.5;
y_k=0.5;
phi_k=phi_f(x_k,y_k,x(1),y(1),c_i);
for i=2:10
    phi_k=cat(2,phi_k,phi_f(x_k,y_k,x(i),y(i),c_i));
end
f_k=phi_k*(phi\f);

%compute error
err_f=@myfunction3;
err=err_f(ff(x_k,y_k),f_k);

%estimate the numerical gradient 
grad_f=@myfunction4;
grad_phi=grad_f(x_k,y_k,x(1),y(1),c_i);
for i=2:10;
    grad_phi=cat(2,grad_phi,grad_f(x_k,y_k,x(i),y(i),c_i));
end
grad=grad_phi/phi
answer=grad*f


function f=myfunction1(x,y)
f=sin(pi*x)*sin(pi*y);
end

function phi=myfunction2(x,y,x_i,y_i,c_i)
phi=sqrt((x-x_i)^2+(y-y_i)^2+c_i^2);
end

function err=myfunction3(f_k,f_k_d)
err=abs(f_k-f_k_d)/abs(f_k);
end

function grad=myfunction4(x,y,x_i,y_i,c_i)
grad=zeros(2,1);
grad(1)=(x-x_i)/sqrt((x-x_i)^2+(y-y_i)^2+c_i^2);
grad(2)=(y-y_i)/sqrt((x-x_i)^2+(y-y_i)^2+c_i^2);
end