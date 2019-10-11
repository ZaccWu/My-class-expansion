function poiss(lambda)
% input the parameter of the poisson distribution
N=100000; % random numbers we need
X=zeros(1,N);
count=0;
for i=1:N
    F=0;
    U=unifrnd(0,1);    % Generates uniformly distributed random Numbers
    for j=0:20
        F=F+lambda^j*exp(-lambda)/factorial(j);
        if U<F
            break;
        end
    end
    count=count+1;
    X(count)=j;
end
% For the sake of beauty, end the bin size
if lambda<3
    bin=9;
else if lambda<6
    bin=10;
    else
        bin=12;
    end
end

hist(X,bin);
hold off
end
