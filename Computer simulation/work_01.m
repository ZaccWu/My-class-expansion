function [T, S, i] = work_01(N)
    T = -1;
    S = 0;
    t = ones(N, 1) * -1;    % time 
    s = ones(N, 1) * -1;    % status
    i = 0;                  
    charging = 0;           % the rest of charging time 
    t(1) = 0;          
    s(1) = 2;
    % initial status
    r = randi(6);  % the time of the battery(1,2,3,4,5,6)
    alpha = [1 3]; prob = [0.5 0.5]; % generate the random number 1,3
    while (i < N - 1)  
        i = i + 1; 
        if (s(i) == 2)  % two batteries
            s(i + 1) = 1;
            t(i + 1) = t(i) + r;
            charging = randsrc(1,1,[alpha; prob]); % the random charging time
            r = randi(6);  
            
        elseif (s(i) == 1)  % one battery
            charging = charging - r; % till the using one empty
            if (charging > 0)
                % no power!
                t(i + 1) = t(i) + r; 
                s(i + 1) = 0;
                r = 0;  % the end
                T = t(i + 1);
                S = sum((t(2:end) - t(1:end-1)) .* s(1:end-1)) / T;
                return;  % the only way to stop
            else
                % already full, the using one just keep on using
                t(i + 1) = t(i) + charging;
                s(i + 1) = 2;
                charging = 0;
                r = r - randsrc(1,1,[alpha; prob]);  % the random charging time
                if (r < 0)
                    % assert!
                    fprintf("Error!\n");
                    return;
                end
            end
        end
    end
    fprintf("Not finish yet!\n");
    return;
end
