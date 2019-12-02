function f = plotcities(Best)
    disp(Best);
    load('cityXY.mat');
    n=length(cityXY);
    New_range=zeros(2,n);
    for i=1:n
        New_range(1,i)=cityXY(1,Best(i));
        New_range(2,i)=cityXY(2,Best(i));
    end
    plot(New_range(1, :), New_range(2, :), 'b*');
    hold on;
    plot(New_range(1, :), New_range(2, :), 'b');
    plot([New_range(1, end) New_range(1, 1)], [New_range(2, end) New_range(2, 1)], 'b');
end
