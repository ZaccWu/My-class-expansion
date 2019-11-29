function f = plotcities(cityXY)
plot(cityXY(1, :), cityXY(2, :), 'b*');
hold on;
plot(cityXY(1, :), cityXY(2, :), 'b');
plot([cityXY(1, end) cityXY(1, 1)], [cityXY(2, end) cityXY(2, 1)], 'b');
