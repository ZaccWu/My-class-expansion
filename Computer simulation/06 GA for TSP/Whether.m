function Prob=Whether(P)
% return true(1) or false(0) according to the input probability
    test(1: 100) = 0;
    l = round(100 * P);
    test(1 : l) = 1;
    n = round(rand * 99) + 1;
    Prob = test(n);
end