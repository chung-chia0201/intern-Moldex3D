clc,clear,close all
row_n=10;                                                         %m must >1
col_n=11;                                                           %n must >1
cell_n=row_n*col_n;                                    %the number of cell
x=1/(col_n*2);
y=1/(row_n*2);

%cell center
cell_c=zeros(2,cell_n);
for i=1:row_n
    for j=1:col_n
        cell_c(1,j+(i-1)*col_n)=1/(col_n*2)*(2*j-1);
        cell_c(2,j+(i-1)*col_n)=1/(row_n*2)*(row_n*2-1)-2*(i-1)*1/(row_n*2);
    end
end

%face center
face_c_n=row_n*(col_n+1)+col_n*(row_n+1);
face_c_1=zeros(2,col_n*(row_n+1));
for i=1:row_n+1
    for j=1:col_n
        face_c_1(1,j+(i-1)*col_n)=x*(2*j-1);
        face_c_1(2,j+(i-1)*col_n)=row_n*2*y-y*(2*i-2);
    end
end
face_c_2=zeros(2,row_n*(col_n+1));
for i=1:col_n+1
    for j=1:row_n
        face_c_2(1,j+(i-1)*row_n)=x*2*(i-1);
        face_c_2(2,j+(i-1)*row_n)=y*(j*2-1);
    end
end
face_c=cat(2,face_c_1,face_c_2);

%inner face center
count=1;
for i=col_n+1:col_n*(row_n+1)-col_n
    inn_face_c_1(1,count)=face_c_1(1,i);
    inn_face_c_1(2,count)=face_c_1(2,i);
    count=count+1;
end

count=1;
for i=row_n+1:row_n*(col_n+1)-row_n
    inn_face_c_2(1,count)=face_c_2(1,i);
    inn_face_c_2(2,count)=face_c_2(2,i);
    count=count+1;
end
inn_face_c=cat(2,inn_face_c_1,inn_face_c_2);

%boundary face center
count=1;
for i=1:col_n
    bdr_face_c_1(1,count)=face_c_1(1,i);
    bdr_face_c_1(2,count)=face_c_1(2,i);
    count=count+1;
end
for i=(row_n+1)*col_n-col_n+1:(row_n+1)*col_n
    bdr_face_c_1(1,count)=face_c_1(1,i);
    bdr_face_c_1(2,count)=face_c_1(2,i);
    count=count+1;
end
count=1;
for i=1:row_n
    bdr_face_c_2(1,count)=face_c_2(1,i);
    bdr_face_c_2(2,count)=face_c_2(2,i);
    count=count+1;
end
for i=row_n*(col_n+1)-row_n+1:row_n*(col_n+1)
    bdr_face_c_2(1,count)=face_c_2(1,i);
    bdr_face_c_2(2,count)=face_c_2(2,i);
    count=count+1;
end
bdr_face_c=cat(2,bdr_face_c_1,bdr_face_c_2);

%create matrix A
A=zeros(cell_n);
%兩個boundary
corner_c_n=[1 1+col_n-1 cell_n-col_n+1 cell_n];
cell_n_bdr_face_1=[1 col_n col_n+1 2*col_n];
cell_n_bdr_face_2=[2*col_n+row_n 2*(col_n+row_n) 2*col_n+1 2*(col_n+row_n)-row_n+1];
cell_n_bdr_face=cat(1,cell_n_bdr_face_1,cell_n_bdr_face_2);

cell_n_cell_1=[2 col_n-1 row_n*col_n-col_n+2 row_n*col_n-1];
cell_n_cell_2=[1+col_n 2*col_n row_n*col_n-2*col_n+1 row_n*col_n-col_n];
cell_n_cell=cat(1,cell_n_cell_1,cell_n_cell_2);     %跟編號幾號的cell相鄰
for i=1:4
    A(corner_c_n(i),corner_c_n(i))=-3*(y/x+x/y);
    A(corner_c_n(i),cell_n_cell(1,i))=y/x;
    A(corner_c_n(i),cell_n_cell(2,i))=x/y;
end

% 一個boundary
cell_1_bdr_n=2*(row_n+col_n-2)-4;
cell_1_bdr_dir=[col_n-2 row_n-2];  %x,y
cell_1_bdr=[];
if cell_1_bdr_dir(1) ~= 0
    for i=1:cell_1_bdr_dir(1)
        flash=1+i;
        cell_1_bdr=cat(2,cell_1_bdr,flash);
        A(flash,flash+1)=y/x;
        A(flash,flash-1)=y/x;
        A(flash,flash+col_n)=x/y;
        A(flash,flash)=-(2*y/x+3*x/y);
    end
end

if cell_1_bdr_dir(2) ~= 0
    for i=1:cell_1_bdr_dir(2)
        flash=1+col_n*i;
        cell_1_bdr=cat(2,cell_1_bdr,flash);
        A(flash,flash+1)=y/x;
        A(flash,flash-col_n)=x/y;
        A(flash,flash+col_n)=x/y;
        A(flash,flash)=-(3*y/x+2*x/y);
        cell_1_bdr=cat(2,cell_1_bdr,flash+col_n-1);
        A(flash+col_n-1,flash+col_n-1-1)=y/x;
        A(flash+col_n-1,flash+col_n-1-col_n)=x/y;
        A(flash+col_n-1,flash+col_n-1+col_n)=x/y;
        A(flash+col_n-1,flash+col_n-1)=-(3*y/x+2*x/y);
    end
end

if cell_1_bdr_dir(1) ~= 0
    for i=1:cell_1_bdr_dir(1)
        flash=col_n*(row_n-1)+1+i;
        cell_1_bdr=cat(2,cell_1_bdr,flash);
        A(flash,flash+1)=y/x;
        A(flash,flash-1)=y/x;
        A(flash,flash-col_n)=x/y;
        A(flash,flash)=-(2*y/x+3*x/y);
    end
end

% 零個boundary
cell_0_bdr_n=(row_n-2)*(col_n-2);
cell_0_bdr_dir=[col_n-2 row_n-2];
cell_0_bdr=[];
if cell_0_bdr_n~=0
    for i=1:row_n-2
        for j=1:col_n-2
            flash=col_n+1+j+(i-1)*col_n;
            cell_0_bdr=cat(2,cell_0_bdr,flash);
            A(flash,flash)=-2*(y/x+x/y);
            A(flash,flash+1)=y/x;
            A(flash,flash-1)=y/x;
            A(flash,flash+col_n)=x/y;
            A(flash,flash-col_n)=x/y;
        end
    end
end

%create b
b=zeros(cell_n,1);
top_bdr=@myfunction;
for i=1:col_n
    flash=bdr_face_c(:,i);
    b(i)=top_bdr(flash(1))*(2*x/y);
end

%compute answer
answer=inv(A)*(-b);

%real answer
real_answer=zeros(1,cell_n);
for i=1:cell_n
    real_answer(i)=(sin(pi*cell_c(1,i)))*(sinh(pi*cell_c(2,i)))/(sinh(pi));
end
real_answer=real_answer';

%compute error
err=norm(real_answer-answer,2)/norm(real_answer,2)

function f=myfunction(x)                          %top boundary condiction
f=sin(pi*x);
end