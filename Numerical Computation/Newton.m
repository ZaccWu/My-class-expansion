function Newton(f,xh)  
      min_x=xh(1);
      max_x=xh(length(xh));
      n=length(xh);
      x = min_x : (max_x-min_x)/n : max_x; 
      for i = 1:1:n+1  
          y(i) = f(x(i));  
      end  
     a=[x',y'];  
     for i = 1:1:n  
         for j = 1:1:(n-i+1)  
             a(j,i+2) = (a(j+1,i+1)-a(j,i+1))/(a(j+i,1)-a(j,1));  
         end  
     end  
       
     STEP = 0.001;  
     x = min_x : STEP : max_x;  
     for i = 1:1:((max_x-min_x)/STEP+1)  
         y_1(i) = f(x(i));  
     end  
     plot(x,y_1,'r')  

     hold on  
     for i = 1:1:((max_x-min_x)/STEP+1)  
         y_2(i) = a(1,n+2);  
         for j = n:-1:1  
             y_2(i) = y_2(i) * (x(i) - a(j,1)) + a(1,j+1);  
        end  
     end  
     plot(x,y_2,'b')  
end
