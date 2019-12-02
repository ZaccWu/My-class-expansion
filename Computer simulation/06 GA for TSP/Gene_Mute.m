function GMNew=Gene_Mute(Gene,mute)
%   Mute Process
%   'mute' is the probability of the occurance

    length=size(Gene,2);
    GMNew=Gene;
    muteProb=Whether(mute); % 1 means yes and 0 means no
    
    if muteProb == 1
        a = round(rand*(length - 2)) + 1;  % generate mute position a
        b = round(rand*(length - 2)) + 1;  % generate mute position b
        Gca = min(a, b);
        Gcb = max(a, b);
        x = Gene(Gca + 1 : Gcb);
        GMNew(Gca + 1 : Gcb) = fliplr(x); % If mute, than inverse
    end
end