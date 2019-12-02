function Dist = Genefit_value(D,Gene)
%   Calculate the fitness value of a certain chromosome
%   Here we calculate the distance

    Dist=0;
    n=size(Gene,2); % length of the chromosome
    for i=1:(n-1)
        Dist=Dist+D(Gene(i),Gene(i+1));
    end
    Dist=Dist+D(Gene(n),Gene(1));   % Ensure the Loop
end

