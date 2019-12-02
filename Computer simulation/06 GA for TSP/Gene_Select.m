function GSel=Gene_Select(GV_Prob)
% Select the Chromosome

    GSel=zeros(2,1);
    % Choose 2 Parent Gene
    for i=1:2
        r=rand; % Random number
        prand=GV_Prob-r;
        j=1;
        while prand(j)<0
            j=j+1;
        end
        GSel(i)=j;  % index of chosen Gene
        if i == 2 && j == GSel(i - 1)    % Do not Select the Same one
           r = rand; 
           prand = GV_Prob - r;
           j = 1;
           while prand(j) < 0
               j = j + 1;
           end
        end
    end
end
