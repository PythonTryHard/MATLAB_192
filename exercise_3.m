function exercise_3
clc
syms x y z
disp('Enter any point belongs to the sphere')
x0=input('x0= ');y0=input('y0= ');z0=input('z0= ');
f=x.^2+y.^2+z.^2-9; %F=f(x,y,z)-k where k=9
P=diff(f,'x'); Q=diff(f,'y'); R=diff(f,'z');
n=[P Q R]; %calculate partial derivative
n1=subs(n,[x y z],[x0 y0 z0]); 
n1=double(n1); %gradient vector
f1=n1(1,1)*(x-x0)+n1(1,2)*(y-y0)+n1(1,3)*(z-z0); %tangent surface
disp(['Function of tangent surface is: ' char(f1) ' = 0' ])
disp('Unit normal vector is: ')

% Draw unit normal vector
p0=[x0 y0 z0]; %initial point
grad1=n1(1,1)/sqrt((n1(1,1)).^2+(n1(1,2)).^2+(n1(1,3)).^2);
grad1=double(grad1);
grad2=n1(1,2)/sqrt((n1(1,1)).^2+(n1(1,2)).^2+(n1(1,3)).^2);
grad2=double(grad2);
grad3=n1(1,3)/sqrt((n1(1,1)).^2+(n1(1,2)).^2+(n1(1,3)).^2);
grad3=double(grad3);
grad=[grad1 grad2 grad3] % set up gradient vector
p1=[grad(1,1)+x0 grad(1,2)+y0 grad(1,3)+z0];% second point
c=zeros(1,3); c=double(c);
starts=zeros(3,3);
ends=[p0;p1;c];
quiver3(starts(:,1), starts(:,2), starts(:,3), ends(:,1), ends(:,2), ends(:,3),'Color',[1 0 0],'LineWidth',1.5);
hold on

% Draw the graph of sphere
[x, y, z]=sphere;
x=3*x;
y=3*y;
z=3*z;
surf(x,y,z)
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
axis equal

%Draw tangent surface
[x,y]=meshgrid(x0-2:.1:x0+2,y0-2:.1:y0+2);
z=(z0*n1(1,3)-(n1(1,1)*(x-x0)+n1(1,2)*(y-y0)))/n1(1,3);
set(surf(x,y,z),'facecolor','g','edgecolor','non','facealpha',.3)
hold off
rotate3d on
end