function exercise_2

% Clean-up
%clc

% Turn off warnings
warning off

% Declare symbolic variable
syms x y lamda

% Declare the function f to find extrema
f=@(x,y)3*x+4*y;

% Find extreme value on constraint D
phi=@(x,y) x.^2+4*x*y+5*y.^2-10;

% Lagrange multiplier function
L=f+lamda*(phi);

% The two gradient of the Lagrange multiplier function
Lx=diff(L,'x');
Ly=diff(L,'y');

%Evaluate first-order partial derivatives where: l <=> lamda , m <=> x , n <=> y
[m, n, l] = solve(Lx,Ly,phi,'x','y','lamda');

% Remove all complex solutions
[m, n]=loai(m,n);

% Convert to double-precision floats
m=double(m);
n=double(n);
l=double(l);

% Concatenate result into table for easy manipulation
A=[];
for i=1:length(m)
    A(i,2)=m(i);
    A(i,3)=n(i);
    A(i,1)=subs(f,[x y],[m(i) n(i)]);
end

% Self-explanatory
if isempty(A)
    disp('There is any minimum and maximum values')
    return
end

%Draw contour plot of f and constraint
fimplicit(phi,'LineWidth',1.5,'Color','k');
axis([-10 10 -10 10]);
hold on
fcontour(f);

%plot(-6.1394,1.7541,'ro');
%plot(6.1394,-1.7541,'bo');

% Outputting
a=max(A(:,1));
b=min(A(:,1));
GTLN='Maximum value is ';
GTNN='Minimum value is ';

for i=1:size(A)
    if A(i,1)==a
        GTLN=[GTLN 'f(' num2str(A(i,2)) ',' num2str(A(i,3)) ')= '];
        plot(A(i,2),A(i,3),'ro');
    elseif A(i,1)==b
        GTNN=[GTNN 'f(' num2str(A(i,2)) ',' num2str(A(i,3)) ')= '];  
        plot(A(i,2),A(i,3),'bo');
    end
end
GTLN=[GTLN num2str(a)];
GTNN=[GTNN num2str(b)];
disp(GTLN)
disp(GTNN)
legend('constraint','f contours','maximum','minimum');
hold off

end

function [a, b]=loai(a,b) %remove complex value
for i=1:length(a)
    if ~isreal(a(i)) || ~isreal(b(i))
        a(i,:)=[];
        b(i,:)=[];
    end
end
end