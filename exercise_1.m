function exercise_1

% Clean up
clc

% Turn off warning
warning off

% Symbolic vars
syms x y real

% Function declaration
f = 2*x.^(y)-y.^(2)-4*x.^(2)+3*y;

% Calculate first-order derivative's root such that FOD  =  =  0
[a,b] = solve([diff(f,'x') == 0, diff(f,'y') == 0]);
a = double(a);
b = double(b);

% Second-order differential check
A = diff(f,2,x);
B = diff(diff(f,x),y);
C = diff(f,2,y);

% Create arrays to contain values
cd = zeros(0); ct = zeros(0);
zcd = zeros(0); zct = zeros(0);
sd = zeros(0); zsd = zeros(0);
n = size(a,1);i = 1;

% Differential test
while i<= n
    x = a(i);y = b(i);
    
    % Evaluate A, B, C at points (a,b)
    sA = eval(A);sB = eval(B);sC = eval(C);
    
    % Calculate delta for SOD test
    delta = (sA*sC-sB^2); 
    delta = double(delta);
    
    if delta > 0
        if sA > 0 % A > 0  = > local minimum
            ct = [ct;a(i) b(i)]; zct = [zct;eval(f)];
            i = i+1;
        elseif sA < 0 % A > 0  = > local maximmum
            cd = [cd;a(i) b(i)]; zcd = [zcd;eval(f)];
            i = 1+i;
        else
            a(i) = [];b(i) = [];
            n = n-1;
        end
    elseif delta<0 % f has saddle point
        sd = [sd;a(i) b(i)]; zsd = [zsd;eval(f)];
        i = i+1;
    else
        a(i) = [];b(i) = [];
        n = n-1;
    end
end

% Contour plot + 3D plot if has extrema
if size([zcd;zct],1)>=  1
        [x, y] = meshgrid(min(a)-abs(max( a )-min(a))/5:.1:max(a)+abs(max(a)-min(a))/5,min(b)-abs(max(b)-min(b))/5:.1:max(b)+abs(max(b)-min(b))/5);
        f = char(f);f = strrep(f,'^','.^');f = strrep(f,'*','.*');f = eval(f);
        [x, y, f] = khu(x,y,f);
        subplot(1,2,2);
        mesh(x,y,real(f));
        hold on
        ctri(cd,ct,zcd,zct);
        subplot(1,2,1);
        contour(x,y,real(f),'ShowText','on');
        hold on
        ctri(cd,ct,zcd,zct);
end

% Contour + 3D plot of saddle points
if size([zsd],1)>=  1
    x = linspace(-10,10);
    y = linspace(-10,10);
    [x, y] = meshgrid(x,y);
    f = char(f);f = strrep(f,'^','.^');f = strrep(f,'*','.*');f = eval(f);
    [x, y, f] = khu(x,y,f);
    subplot(1,2,2);
    mesh(x,y,real(f)) ;
    hold on
    sd = double(sd); zsd = double(zsd);
    for i = 1:size([zsd],1)
    disp([' f has saddle point: ' '(' num2str(sd(i,1)) ',' num2str(sd(i,2)) ',' num2str(zsd(i)) ')'])
    k = plot3(sd(i,1),sd(i,2),zsd(i),'ro');
    legend(k,'saddle point');
    end
    hold on
    subplot(1,2,1);
    contour(x,y,real(f),'ShowText','on');
    hold on
    sd = double(sd); zsd = double(zsd);
    for i = 1:size([zsd],1)
    k = plot(sd(i,1),sd(i,2),'ro');  
    end
    hold on
    legend(k,'saddle point');
else 
    disp('f has no local extreme and no saddle point' )
    [x,y] = meshgrid(-2:.1:2);
    f = char(f);f = strrep(f,'^','.^');f = strrep(f,'*','.*');f = eval(f);
    [x, y, f] = khu(x,y,f);
    mesh(x,y,real(f));
end

rotate3d on
hold off
xlabel('x axis');
ylabel('y axis');
end

% Function to draw local extreme points
function ctri(cd,ct,zcd,zct)
cd = double(cd);zcd = double(zcd);

for i = 1:size(zcd,1)
    disp([' f has max point: ' '(' num2str(cd(i,1)) ',' num2str(cd(i,2)) ',' num2str(zcd(i)) ')'])
    plot3(cd(i,1),cd(i,2),real(zcd(i)),'ro');
    text(cd(i,1),ct(i,2),zcd(i)+.1,['MAX (' num2str(cd(i,1)) ',' num2str(cd(i,2)) ',' num2str(zcd(i)) ')']);
end

ct = double(ct);zct = double(zct);
for i = 1:size(zct,1)
    disp([' f has min point: ' '(' num2str(ct(i,1)) ',' num2str(ct(i,2)) ',' num2str(zct(i)) ')'])
    plot3(ct(i,1),ct(i,2),real(zct(i)),'ro');
    text(ct(i,1),ct(i,2),zct(i)+.1,['MIN (' num2str(ct(i,1)) ',' num2str(ct(i,2)) ',' num2str(zct(i)) ')']);
end
end

% Function to eliminate points in which do not evaluate cleanly (NaN == Not
% a Number)
function [x, y, f] = khu(x,y,f)
for i = 1:length(x)
    for j = 1:length(y)
        if ~isreal(f(i,j))
            f(i,j) = NaN;x(i,j) = NaN;y(i,j) = NaN;
        end
    end
end
end