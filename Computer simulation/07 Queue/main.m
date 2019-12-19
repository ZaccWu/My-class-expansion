clear;
total_time = 10.0;
lambda = 65;
mu = 60;
guests = sampling(total_time, lambda, mu);
arrive_time = guests(1, :);
service_time = guests(2, :);
total_num = size(guests, 2);
waitting_time = zeros(1, total_num);
service_start = zeros(1, total_num);
service_start(1) = arrive_time(1);
leaving_time = zeros(1, total_num);
leaving_time(1) = arrive_time(1) + service_time(1);

for i=2:total_num
    in_queue_time = leaving_time(i - 1) - arrive_time(i);
    if in_queue_time > 0
        waitting_time(i) = in_queue_time;
    end
    service_start(i) = arrive_time(i) + waitting_time(i);
    leaving_time(i) = service_start(i) + service_time(i);
end

get_queue(arrive_time,leaving_time) % 调用函数求每个时刻的队长
