function s=TSPGA(init,genMax,cross,mute)
%     Parameters Instruction£º
%     init: Initial Size of the Group
%     genMax: Maximum Iteration Times
%     cross: Probability of Cross-Transformation
%     mute: Probability of Mutation
    
    load('cityXY.mat'); % load the data
    x = cityXY;
    n = length(x); % number of cities
    
    % Calculate the distance matrix
    D=zeros(n,n);
    for i=1:n
        for j=1:n
            D(i,j)=norm(cityXY(:,i)-cityXY(:,j));
        end
    end
    
    % Initialize the Population
    Pop = zeros(init, n);
    for i=1:init
        Pop(i,:)=randperm(n);
    end
    [~,GV_Prob]=Genefit_value_all(Pop,D);
    
    % Heredity Process
    GNum=1;    % number of generation
    GVMean=zeros(GNum,1);   % average distance of each generation
    GVMin=zeros(GNum,1);    % shortest distance of each generation
    BestIdvGe=zeros(init,n);  % best individual in each generation
    NewPop=zeros(init,n);   % new population
    while GNum < genMax+1
        for j=1:2:init
            GSel=Gene_Select(GV_Prob);  % Select the Parents
            GCor=Gene_Cross(Pop,GSel,cross);    % Cross Process
            % Mutation Process
            NewPop(j,:)=Gene_Mute(GCor(1,:),mute);  
            NewPop(j+1,:)=Gene_Mute(GCor(2,:),mute);
        end
    
        Pop=NewPop; % Generate New Population
        [Popfit_value,GV_Prob]=Genefit_value_all(Pop,D);  % Calculate the fitness value of new generation

        [fmax,nmax]=max(Popfit_value);
        GVMean(GNum)=1/mean(Popfit_value);
        GVMin(GNum)=1/fmax;
        BestIdv=Pop(nmax,:);    % record the best individual
        BestIdvGe(GNum,:)=BestIdv;  % record the best individual in each generation
        GNum=GNum+1;
        
        % Show the Schedule
        if mod(GNum,100)==0
            disp(GNum);
        end
    end
    [BestValue,idx]=min(GVMin);
    disp(BestValue);
    plotcities(BestIdvGe(idx,:));
    
    
    figure(2);
    plot(GVMin, 'r');  
    hold on;
    plot(GVMean, 'b'); 
    grid;
    title('Searching Process');
    legend('Best Solution', 'Average Solution');
    
end
    