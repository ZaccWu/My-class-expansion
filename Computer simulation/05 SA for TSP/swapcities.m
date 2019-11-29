function s = swapcities(cityXY)
    n = length(cityXY);
    city = [1, 1];
    while (city(1) == city(2)) 
        city = randi([1, n], 1, 2);
    end
    city_1 = min(city);
    city_2 = max(city);
    s = [cityXY(:,1: city_1 - 1) cityXY(:,city_2:-1:city_1) cityXY(:,city_2 + 1:end)];
end