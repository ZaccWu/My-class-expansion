function GCor=Gene_Cross(Pop,GSel,cross)
%   Cross Process
%   'cross' is the probability of the occurance

    length=size(Pop,2);
    crossProb=Whether(cross);    % 1 means yes and 0 means no
    GCor(1,:) = Pop(GSel(1), :);
    GCor(2,:) = Pop(GSel(2), :);
    if crossProb == 1
       a = round(rand * (length - 2)) + 1;  % generate cross position a
       b = round(rand * (length - 2)) + 1;  % generate cross position b
       Gca = min(a, b);
       Gcb = max(a,b);
       middle = GCor(1,Gca+1:Gcb); % change the chromosome slice from Gca to Gcb
       GCor(1,Gca + 1 : Gcb)= GCor(2, Gca + 1 : Gcb);
       GCor(2,Gca + 1 : Gcb)= middle;
       for i = 1 : Gca % Check Whether there exist same number
           while find(GCor(1,Gca + 1: Gcb) == GCor(1, i))
               Loc = find(GCor(1,Gca + 1: Gcb) == GCor(1, i));
               y = GCor(2,Gca + Loc);
               GCor(1, i) = y;
           end
           while find(GCor(2,Gca + 1 : Gcb) == GCor(2, i))
               Loc = find(GCor(2, Gca + 1 : Gcb) == GCor(2, i));
               y = GCor(1, Gca + Loc);
               GCor(2, i) = y;
           end
       end
       for i = Gcb + 1 : length
           while find(GCor(1, 1 : Gcb) == GCor(1, i))
               Loc = logical(GCor(1, 1 : Gcb) == GCor(1, i));
               y = GCor(2, Loc);
               GCor(1, i) = y;
           end
           while find(GCor(2, 1 : Gcb) == GCor(2, i))
               Loc = logical(GCor(2, 1 : Gcb) == GCor(2, i));
               y = GCor(1, Loc);
               GCor(2, i) = y;
           end
       end
    end
end