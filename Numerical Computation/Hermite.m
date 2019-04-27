function f = Hermite(x,y,y_1)
syms t;
f = 0.0;
if(length(x) == length(y))
    if(length(x) == length(y_1))
        n = length(x);
    end
end

for i = 1:n
    h =  1.0;
    a =  0.0;
    for j = 1:n
        if(j ~= i)
            h = h*(t-x(j))^2/((x(i)-x(j))^2);
            a = a + 1/(x(i)-x(j));
        end
    end
    f = f + h*((x(i)-t)*(2*a*y(i)-y_1(i))+y(i));
end
    
x0=-1:0.001:1;
y0=1./(1+25*x0.^2);
plot(x0,y0,'r');
hold on

ft=matlabFunction(f);
y1=ft(x0);
plot(x0,y1,'b');
ylim([-0.01,1.2]);

