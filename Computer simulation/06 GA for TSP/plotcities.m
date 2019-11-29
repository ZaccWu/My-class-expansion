function f = plotcities(Best)
    load('cityXY.mat');
    n=length(cityXY);
    New_range=zeros(2,n);
    for i=1:n
        New_range(1,i)=cityXY(1,Best(i));
        New_range(2,i)=cityXY(2,Best(i));
    end
    plot(cityXY(1, :), cityXY(2, :), 'b*');
    hold on;
    plot(cityXY(1, :), cityXY(2, :), 'b');
    plot([cityXY(1, end) cityXY(1, 1)], [cityXY(2, end) cityXY(2, 1)], 'b');
end
