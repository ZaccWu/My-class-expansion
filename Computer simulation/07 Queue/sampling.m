function guests = sampling(T, L, M);
% T - total time
% L - lambda
% M - mu
% guests(1, :) = guests arriving time
% guests(2, :) = guests in-service time
    N = T * L * 2;
    guests = zeros(2, N);
    guests(1, :) = cumsum(exprnd(1.0 / L, 1, N));
    guests(2, :) = exprnd(1.0 / M, 1, N);
    guests = guests(:, guests(1, :) < T);
end