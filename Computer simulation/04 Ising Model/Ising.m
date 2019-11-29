function D = Ising(T)    % T is the tempure. 
    N=8;
    nTrials = 100000;    % for stat.         
    startup = 100000;    % for steady.        
    d = zeros(1, nTrials);   % results.      
    beta = 1/T;              %             
    M = 0;
    s = 2 * round(rand(1, N*N)) - 1;   % randomly set 1 or -1.
    
    for t = 1 : (startup + nTrials)   
        i = fix(1 + N * N * rand);  % randomly pick 1 ~ N*N.
        y = s;         % y is the suggestion dist in s' neighbour. 
        y(i) = -s(i);  % randomly flip the status on one point.
        
        Es=0;
        Ey=0;
        [A,B,C,D]=deal(0);
        if mod(i,N)~=0 % not right boundery
            A=y(i+1);
        end
        if mod(i,N)~=1 % not left boundery
            B=y(i-1);
        end
        if i>N % not upper boundery
            C=y(i-N);
        end
        if i<=N*(N-1)  % not lower bounder
            D=y(i+N);
        end 
        Es = Es+s(i)*(A+B+C+D)*(-1);
        Ey = Ey+y(i)*(A+B+C+D)*(-1);
        
        h = min(1, exp(-beta * (Ey - Es)));
        if (rand < h)
            s = y;
            Es = Ey;
        end
        
        if (t > startup)
            Ms=sum(s);
            M = M + Ms;     
            d(t - startup) = Ms;
        end
    end
    x = -(N*N):1:(N*N);
    hist(d, x);
    M = (M / nTrials) / (N*N);  % 每个自旋的平均磁矩
    D = sum(d.^2);
end