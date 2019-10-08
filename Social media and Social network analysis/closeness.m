function cc=closeness(G)
    % 计算社交网络节点的紧密中心性
    D=distances(G);  % 计算节点对之间的距离
    S=sum(D,2);     % 距离和
    cc=1./S;        % 计算紧密中心性
    csvwrite('closeness.csv',cc);
end
