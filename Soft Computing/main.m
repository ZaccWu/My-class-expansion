
% load data
b=xlsread('data.xlsx');
opt=[133,334,388,2614,2558,2617,2461,2397,2460,2852]; % optimal solution
cap=[100,200,300,1000,1000,1000,1000,1000,1000,1000]; % capability
% Ten groups of testing data
D1=b(3:7,1:2);
D2=b(3:10,3:4);
D3=b(3:12,5:6);
D4=b(3:102,7:8);
D5=b(3:102,9:10);
D6=b(3:102,11:12);
D7=b(3:102,13:14);
D8=b(3:102,15:16);
D9=b(3:102,17:18);
D10=b(3:102,19:20);
% Use the data:
% Weight: D(:,1); Value: D(:,2)
T=4;    % Which we choose
DWeight=(D4(:,1))';        % Weight
DValue=(D4(:,2))';         % Value
Cap=cap(T);                % Capability

% Input
% PSO(Weight,Value,Capability,Init_size,generation,c1,c2,w);

% PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.8);

% plot
% Change c1,c2;w=0.7
% for w=[0.5,0.8,0.9]
%     disp(w);
%     for c2=[0.5,0.75,1,1.5]
%         disp(c2);
%         Opt=zeros(400,1)+opt(T);
%         plot(Opt, 'r','LineWidth',2);
%         hold on
%         FGbest=PSO(DWeight,DValue,Cap,20,400,0.5,c2,w);
%         plot(FGbest, 'Color',[1 0 0.8],'LineWidth',1.2); 
%         hold on
%         FGbest=PSO(DWeight,DValue,Cap,20,400,0.75,c2,w);
%         plot(FGbest, 'Color',[0 0.9 0.9],'LineWidth',1.2);
%         hold on
%         FGbest=PSO(DWeight,DValue,Cap,20,400,1,c2,w);
%         plot(FGbest, 'Color',[1 0.5 0],'LineWidth',1.2);
%         hold on
%         FGbest=PSO(DWeight,DValue,Cap,20,400,1.5,c2,w);
%         plot(FGbest,'Color',[0 0.5 1],'LineWidth',1.2);
%         hold on
%         FGbest=PSO(DWeight,DValue,Cap,20,400,2,c2,w);
%         plot(FGbest,'Color',[0 0.7 0],'LineWidth',1.2);
%         grid;
%         title('Parameter of PSO');
%         legend('Opt','c1=0.5', 'c1=0.75','c1=1','c1=1.5','c1=2','location','southeast');
%         saveas(gcf,['change c1 (c2=',num2str(c2), ',w=',num2str(w), ').jpg']);
%         hold off
%     end
% end

% Change w;(c1,c2)=(0.7,0.7)
% Opt=zeros(400,1)+opt(T);
% plot(Opt, 'r','LineWidth',2);
% hold on
% FGbest=PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.5);
% plot(FGbest, 'Color',[1 0 0.8],'LineWidth',1.2); 
% hold on
% FGbest=PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.6);
% plot(FGbest, 'Color',[0 0.9 0.9],'LineWidth',1.2);
% hold on
% FGbest=PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.7);
% plot(FGbest, 'Color',[1 0.5 0],'LineWidth',1.2);
% hold on
% FGbest=PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.8);
% plot(FGbest,'Color',[0 0.5 1],'LineWidth',1.2);
% hold on
% FGbest=PSO(DWeight,DValue,Cap,20,400,0.7,0.7,0.9);
% plot(FGbest,'Color',[0 0.7 0],'LineWidth',1.2);
% grid;
% title('Parameter of PSO');
% legend('Opt','w=0.5', 'w=0.6','w=0.7','w=0.8','w=0.9','location','southeast');