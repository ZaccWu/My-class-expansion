function cos_sim(G)
    % 用于计算每个社交网络节点的余弦相似度
    D=distances(G);  % 计算节点对之间的距离
    row=size(D,1);
    col=size(D,2);
    res=zeros(row,col);
    for i=1:row
        for j=1:col
            r1=sum(D(i,:)'.*D(:,j)); % 分子部分
            r2=sqrt(sum(D(i,:).^2)*sum(D(:,j).^2)); % 分母部分
            res(i,j)=r1./r2;    % 余弦相似度
        end
    end
    csvwrite('cos_sim.csv',res);
end
