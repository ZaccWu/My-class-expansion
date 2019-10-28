function [M]=graphic()
% 输入的为array的data
PATH='CA-GrQc';
data=readtable(PATH);
data=table2array(data);
s=size(data);
n=max(max(data))+1; % 所有数据的最大值
if(n>=30000) % 防止卡死并不超过边界
    n=min(s(1),30000);
end
%n=10000;
M=zeros(n,n);
for i=1:n
    for j=1:n
        if(data(i,2)==j)
            M(i,j)=1;
            M(j,i)=1;
            break
        end
    end
    M(i,i)=0;
end
b=sparse(M);
G=graph(b);
plot(G);
title(PATH);
end
