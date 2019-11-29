function expon(lambda)
% input the parameter of the exponential distribution
N=5000; % random numbers we need
X=zeros(1,N);
count=0;
for i=1:N
    U=unifrnd(0,1);    % Generates uniformly distributed random Numbers
    x=-(1./lambda)*log(1-U);
    if x>0 && x<30
        count=count+1;
        X(count)=x;
    end
end
hist(X,60);
hold on
t=0:0.1:20;
y=lambda*exp(-lambda.*t);
plot(t,y*count*(10/(60*lambda)),'r');
hold off
end

