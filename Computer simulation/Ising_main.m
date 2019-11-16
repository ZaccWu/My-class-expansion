M = zeros(100,1);
T = 1.1:0.1:11;
for i = 1:100
    for j = 1:10
        M(i) = M(i) + Ising(i*0.1);
        M(i) = M(i) / 10;
    end
end
plot(T, M)
