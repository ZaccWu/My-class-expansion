% 3-3
x=-4:0.01:4;
y=(5+x.^2+x.^3+x.^4)./(5+5*x+5*x.^2);
plot(x,y)

y1=(5+x.^2+x.^3+x.^4)./(5+5*x+5*x.^2);y2=y1.*sin(x);
plot(x,y1,'r',x,y2,'b')

% 3-6
x=0.1:0.1:50;
y=sin(x)./(x.^2);
plot(x,y)

% 3-10
[x1,minf]=fminbnd('2*(sin(2*x))^2+2.5*x*(cos(x/2))^2',0,pi)
[x2,maxf]=fminbnd('-(2*(sin(2*x))^2+2.5*x*(cos(x/2))^2)',0,pi)

% 3-13
