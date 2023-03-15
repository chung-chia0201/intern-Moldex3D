clc,clear,close all
%%problem 8(a)
%answer1
A=[-6 1 1 0;1 -6 0 1;1 0 -6 1;0 1 1 -6];
b1=-[1 1 0 0];
b1=sqrt(2)*b1';
answer1=inv(A)*b1;

%answer2
B=[-4 1 1 0;1 -4 0 1;1 0 -6 1;0 1 1 -6];
b2=-[1 1 0 0];
b2=(sqrt(2)*pi*cosh(pi))/(4*sinh(pi))*b2';
answer2=inv(B)*b2;

%%real_answer
u=[0.25 0.75;0.75 0.75;0.25 0.25;0.75 0.25];
real_answer =zeros(4,1);
for i=1:4
    real_answer(i)=(sin(pi*u(i,1)))*(sinh(pi*u(i,2)))/(sinh(pi));
end

error1=norm(real_answer-answer1,2)/norm(real_answer,2)
error2=norm(real_answer-answer2,2)/norm(real_answer,2)
% norm(real_answer,2)



