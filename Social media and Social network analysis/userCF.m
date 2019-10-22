 %%% 1. 载入数据 %%%          

b = readtable('trainingSet.csv');


%%% 2. 转换矩阵 %%%

sparse_UI = sparse(b.userId,b.movieId,b.rating);                      
UI=full(sparse_UI);  % 转换成全矩阵
heatmap(UI(1:20,1:30));


%%% 3. 计算user-to-user的相似度 %%%
% Suggested steps:
% 1. compute the row norm
% 2. use the formula to compute the similarity.. (tips: transform the UI)
% 3. change the diagonal elements to 0
simU = [];
for i = 1:size(UI,1)
    for j = 1:size(UI,1)
        a=UI(i,1:size(UI,2));
        b=UI(j,1:size(UI,2));  % a\b是用户向量，维数和电影数量相等
        f1=sum(a.*b); % 余弦相似度的分子部分
        f2=sqrt(sum(a.*a))*sqrt(sum(b.*b)); % 余弦相似度的分母部分
        if f2==0
            simU(i,j)=0; % 分母为零的处理
            break
        end
        simU(i,j)=f1/f2;  % 余弦相似度
        if i==j
            simU(i,j)=0;
        end
    end
end
% 现在simU是165*165的用户相似度矩阵

%%% 4. 计算用户x对testingSet.csv中的电影的预测值 %%%
testing = readtable('testingSet.csv');

x = 100;
%%读取用户x想要评分的电影
toTest = testing(testing.userId == x,:);
%%相似度从高到低排序
[simScore, neighbors] = sort(simU(x,:),'descend');
k = 165;           % 总共165名用户

for j=1:size(toTest,1)  % 给j部电影预测
    estR1 = 0;
    %%mid为当前计算的movie的id，即公式中的i%%
    mid = toTest.movieId(j);
    simsum=0;
    for i=1:k
        if(UI(neighbors(i),mid)~=0)
            % i就是公式中的u，neighbors(i)就是公式中的v
            simsum=simsum+simU(x,neighbors(i));
            estR1 = estR1 + simU(x,neighbors(i))*(UI(neighbors(i),mid)-sum(UI(neighbors(i),:))/sum(~~UI(neighbors(i),:)));
            %%此处写代码，计算公式的右半部分，即sim*(rvi-rv)/sum(sim(1:k))%%
        end
    end
    %%公式的左半部分，注意非0项的平均值不可用mean()直接得到，下式estRating即为预测值%%
    estRating = sum(UI(x,:),2)./sum(~~UI(x,:),2) + estR1/simsum;
    %%将值写入toTest表中%%
    toTest.estRating(j) = estRating;
end

%%% 5. Evaluate the Estimation Using RMSE %%%
c=toTest.estRating-toTest.rating;
rmse = sqrt(sum(c.*c)/size(c,1))
