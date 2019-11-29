function d = distance(cityXY)
    d = 0;
    n = length(cityXY);
    for i = 1:(n - 1)
        d = d + norm(cityXY(:,i) - cityXY(:,i + 1));
    end
    d = d + norm(cityXY(:,n) - cityXY(:,1));
end
