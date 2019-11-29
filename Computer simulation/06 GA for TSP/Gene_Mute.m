function GMNew=Gene_Mute(Gene,mute)
%   Mute Process
%   'mute' is the probability of the occurance

    length=size(Gene,2);
    GMNew=Gene;
    muteProb=Whether(mute); % 1 means yes and 0 means no
    
    if muteProb == 1
        c1 = round(rand*(length - 2)) + 1;  % generate mute position c1
        c2 = round(rand*(length - 2)) + 1;  % generate mute position c2
        chb1 = min(c1, c2);
        chb2 = max(c1, c2);
        x = Gene(chb1 + 1 : chb2);
        GMNew(chb1 + 1 : chb2) = fliplr(x); % If mute, than inverse
    end
end