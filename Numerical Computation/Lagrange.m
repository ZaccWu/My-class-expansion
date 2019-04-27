function Lagrange(xh)
m=length(xh);

t=1;
for k=-1:0.001:1
    F(t)=0;
    for i=1:1:m
        l=1;
        for j=1:i-1
            l=l*(k-xh(j))./(xh(i)-xh(j));
        end
        for j=i+1:m
            l=l*(k-xh(j))./(xh(i)-xh(j));
        end
        F(t)=F(t)+l*(1./(1+25*xh(i).^2));
    end
    t=t+1;
end
x=-1:0.01:1;
y=1./(1+25*x.^2);
plot(x,y,'r');
hold on
k=-1:0.001:1;
plot(k,F,'b.','markersize',2);



