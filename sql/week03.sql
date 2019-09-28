-- 用户存留分析

-- 查看时间序列
select * from y_emails order by occurred_at
select * from y_events order by occurred_at
select * from y_users order by created_at

-- step1 数据预处理
-- 处理时间字符、加入查询表中的时间列并将join之后的表格进行存储
select * 
into b_users  -- b开头的为备份文件
from y_users
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_users.created_at),0,11)

select *
into b_emails
from y_emails
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_emails.occurred_at),0,11)

select * 
into b_events
from y_events
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_events.occurred_at),0,11)

-- step2 数据探索
-- 各个类别的活动总和
select action as action_count, count(*) as times from b_emails group by action order by times desc
select event_type as event_type_count, count(*) as times from b_events group by event_type order by times desc
select event_name as event_name_count, count(*) as times from b_events group by event_name order by times desc
select company_id as comid_count, count(*) as times from b_users group by company_id order by times desc
-- 统计每个language中active和pending的总数
select language,
count(case when state='active' then state else null end) as active,
count(case when state='pending' then state else null end) as pending
from b_users group by language
order by active desc,pending desc
-- 统计每个company_id中active和pending的总数
select company_id,
count(case when state='active' then state else null end) as active,
count(case when state='pending' then state else null end) as pending
from b_users group by company_id
order by active desc,pending desc
-- 统计每个period_id中用户总数的变化（去除重复）
select period_id,
count(distinct user_id) as num_users
from b_events group by period_id order by period_id
select period_id,
count(distinct user_id) as num_users
from b_emails group by period_id order by period_id

-- 以下输出结果将会进行曲线图的绘制
-- 分别统计每个period_id中注册的active和panding用户
select period_id, time_id,
count(case when state='active' then state else null end) as active_users,
count(case when state='pending' then state else null end) as pending_users
from b_users group by time_id,period_id order by time_id
-- 分别统计每天注册的active和panding用户
select date, period_id, time_id,
count(case when state='active' then state else null end) as active_users,
count(case when state='pending' then state else null end) as pending_users
from b_users group by date,time_id,period_id order by date
-- emails中各类action的数量变化（每周）
select period_id, time_id,
count(case when action='sent_weekly_digest' then action else null end) as sent_weekly_digest,
count(case when action='email_open' then action else null end) as email_open,
count(case when action='email_clickthrough' then action else null end) as email_clickthrough,
count(case when action='sent_reengagement_email' then action else null end) as sent_reengagement_email
from b_emails group by time_id,period_id order by time_id
-- event_type中的数量变化（每周）
select period_id, time_id,
count(case when event_type='engagement' then event_type else null end) as engagement,
count(case when event_type='signup_flow' then event_type else null end) as signup_flow
from b_events group by time_id,period_id order by time_id
-- event_name的数量变化（每周）
select period_id, time_id,
count(case when event_name='home_page' then event_name else null end) as home_page,
count(case when event_name='like_message' then event_name else null end) as like_message,
count(case when event_name='view_inbox' then event_name else null end) as view_inbox,
count(case when event_name='login' then event_name else null end) as login,
count(case when event_name='send_message' then event_name else null end) as send_message,
count(case when event_name='search_autocomplete' then event_name else null end) as search_autocomplete,
count(case when event_name='search_run' then event_name else null end) as search_run,
count(case when event_name='create_user' then event_name else null end) as create_user,
count(case when event_name='enter_email' then event_name else null end) as enter_email
from b_events group by time_id,period_id order by time_id
