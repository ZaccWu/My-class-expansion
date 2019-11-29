function GCor=Gene_Cross(Pop,GSel,cross)
%   Cross Process
%   'cross' is the probability of the occurance

    length=size(Pop,2);
    crossProb=Whether(cross);    % 1 means yes and 0 means no
    GCor(1,:) = Pop(GSel(1), :);
    GCor(2,:) = Pop(GSel(2), :);
    if crossProb == 1
       c1 = round(rand * (length - 2)) + 1;  % generate cross position c1
       c2 = round(rand * (length - 2)) + 1;  % generate cross position c2
       chb1 = min(c1, c2);
       chb2 = max(c1,c2);
       middle = GCor(1,chb1+1:chb2); % change the chromosome slice from chb1 to chb2 
       GCor(1,chb1 + 1 : chb2)= GCor(2, chb1 + 1 : chb2);
       GCor(2,chb1 + 1 : chb2)= middle;
       for i = 1 : chb1 % Check Whether there exist same number
           while find(GCor(1,chb1 + 1: chb2) == GCor(1, i))
               location = find(GCor(1,chb1 + 1: chb2) == GCor(1, i));
               y = GCor(2,chb1 + location);
               GCor(1, i) = y;
           end
           while find(GCor(2,chb1 + 1 : chb2) == GCor(2, i))
               location = find(GCor(2, chb1 + 1 : chb2) == GCor(2, i));
               y = GCor(1, chb1 + location);
               GCor(2, i) = y;
           end
       end
       for i = chb2 + 1 : length
           while find(GCor(1, 1 : chb2) == GCor(1, i))
               location = logical(GCor(1, 1 : chb2) == GCor(1, i));
               y = GCor(2, location);
               GCor(1, i) = y;
           end
           while find(GCor(2, 1 : chb2) == GCor(2, i))
               location = logical(GCor(2, 1 : chb2) == GCor(2, i));
               y = GCor(1, location);
               GCor(2, i) = y;
           end
       end
    end
end