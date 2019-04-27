function Romberg(f,a,b,e)
k=0;
n=1;  
h=b-a;  
T=h/2*(f(a)+f(b));  
gap=1;  
while gap>=e
    k=k+1;  
    h=h/2;  
    temp=0;  
    for i=1:n  
        temp=temp+f(a+(2*i-1)*h);  
    end  
    T(k+1,1)=T(k)/2+h*temp;  
    for j=1:k  
        T(k+1,j+1)=T(k+1,j)+(T(k+1,j)-T(k,j))/(4^j-1);  
    end  
    n=n*2;  
    gap=abs(T(k+1,k+1)-T(k,k));  
end  
disp(T(k+1,4));  
    
        
    
    
    