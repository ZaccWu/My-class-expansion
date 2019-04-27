function Line(xh)
s=length(xh);
 for j=2:s
         X(j-1)=(xh(j-1)+xh(j))/2; 
         Sn(j-1)=(((X(j-1)-xh(j))/(xh(j-1)-xh(j)))/(1+25*xh(j-1)^2))+(((X(j-1)-xh(j-1))/(xh(j)-xh(j-1)))/(1+25*xh(j)^2));
 end

 plot(X,Sn,'b-');
 hold on
 Z=Sn;

 sym x;
 hs='1/(1+25*x^2)';
 h=ezplot(hs,[-1,1]);
 set(h,'color','r');



