function get_queue(arriving_time,leaving_time)
    N=size(arriving_time,2);    % 相当于顾客数
    queue=zeros(2,N*2); % 初始化队列，一行记录时间点，一行记录该时间点对应的人数
    i=1;    % 到达时间脚标
    j=1;    % 离开时间脚标
    k=1;    
    % 顾客开始到达
    queue(1,1)=arriving_time(1);    % 第一个人到达
    queue(2,1)=1;                   % 第一个人到达后队列长度为1
    k=k+1;
    i=i+1;
    while i~=N      
        if arriving_time(i)<leaving_time(j) % 下一个人来的时候上一个人还在排队
            queue(1,k)=arriving_time(i);    % 到达时间点k
            queue(2,k)=queue(2,k-1)+1;      % 来了一个人，时间点k对应的队伍长度+1
            k=k+1;
            i=i+1;
        else
            queue(1,k)=leaving_time(j);     % 离开时间点k
            queue(2,k)=queue(2,k-1)-1;      % 离开一个人，时间点k对应的队伍长度-1
            k=k+1;
            j=j+1;
        end
    end
    % 所有顾客已经到达，剩余顾客离开
    while j~=N
        queue(1,k)=leaving_time(j);     % 离开时间
        queue(2,k)=queue(2,k-1)-1;      % 每离开一个人，队伍长度减一
        k=k+1;
        j=j+1;
    end
    queue=queue(2,1:k-1);    % 结束时队伍长度为零
    disp(queue);             % 输出结果
    plot(queue);             % 画图展示
        