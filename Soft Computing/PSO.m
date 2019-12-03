function FGbest=PSO(DWeight,DValue,Cap,xSize,maxgen,c1,c2,w)
% xSize: 种群数
% maxgen：迭代次数
% c1,c2：因子
% w：惯性系数

%初始化种群
Dim=length(DWeight);           %维度

a=DWeight;
c=DValue;
b=Cap;

A=repmat(a,xSize,1);      % 1*Dim->xSize*Dim
C=repmat(c,xSize,1);     
x=round(rand(xSize,Dim)); % random position matrix
v=rand(xSize,Dim);        % random speed matrix
xbest=zeros(xSize,Dim);   % best position for individual initially
fxbest=zeros(xSize,1);    % fitness of xbest
gbest=zeros(1,Dim);       % global optimal
fgbest=0;                 % fitness of global optimal

% find the optimal in the group
iter=0;
% for plot
FXbest=zeros(maxgen,1);
FGbest=zeros(maxgen,1);

while iter<maxgen
    iter=iter+1;
    fx=sum((C.*x)');         % fitness of individual(weight)
    sx=sum((A.*x)');         % constrains (capability)
    for i=1:xSize
        if sx(i)>b
            fx(i)=0;         % more than capa. fitness=0
        end
    end
    for i=1:xSize
        if fxbest(i)<fx(i)   % substitute by a better solution
            fxbest(i)=fx(i);
            xbest(i,:)=x(i,:);
        end
    end
    if fgbest<max(fxbest)
        [fgbest,g]=max(fxbest);
        gbest=xbest(g,:);     % when idv best fitness 'fxbest(i)'>group best fitness 'fgbext(i)', substitute
    end
    avbest=mean(fxbest);
    
    for i=1:xSize
        if x(i,:)==gbest
            x(i,:)=round(rand(1,Dim));     % when idv at best position, reset to prevent local optimal
        end
    end
    R1=rand(xSize,Dim);
    R2=rand(xSize,Dim);
    v=v*w+c1*R1.*(xbest-x)+c2*R2.*(repmat(gbest,xSize,1)-x); % generate new speed (iteration)
    x=x+v;          
    for i=1:xSize   % generate new position of individuals
        for j=1:Dim
            if x(i,j)<0.5
                x(i,j)=0;
            else x(i,j)=1;   % position: 0 or 1
            end
        end
    end
    FXbest(iter)=avbest;
    FGbest(iter)=fgbest;
end

% plot(FXbest, 'm','LineWidth',1.5); 
% hold on
% plot(FGbest, 'c','LineWidth',1.5);
% grid;
% title('The Process of PSO');
% legend('Idv Average', 'Group Best');

disp(fgbest);
sgbest=sum((a.*gbest)');
% disp(gbest);
end

