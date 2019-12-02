function [GV,GV_Prob]=Genefit_value_all(Pop,D)
%   Calculate the fitness value of a certain population
%   The larger the total distance, the smaller the fitness value will be
    
    T=16;   % let the good indivuals have a higher probability to be chosen.
    init=size(Pop,1);   % The size of the population
    GV=zeros(init,1);
    for i=1:init
        GV(i)=Genefit_value(D,Pop(i,:));    % Calculate the fitness value of each chromosome in the population
    end
    GV=1./GV'; 
    
    % Calculate the accumulate probability
    Sum = 0;
    for i = 1 : init
        Sum = Sum + GV(i)^T;   
    end
    
    probs = zeros(init, 1);
    for i = 1: init
        probs(i) = GV(i)^T/ Sum;
    end
    
    GV_prob = zeros(init,1);
    GV_prob(1) = probs(1);
    for i = 2 : init
        GV_prob(i) = GV_prob(i - 1) + probs(i);
    end
    GV_Prob=GV_prob';
end
        