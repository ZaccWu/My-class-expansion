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

-- user_type的变化（每周）
select period_id, time_id,
count(case when user_type=1 then user_type else null end) as type1,
count(case when user_type=2 then user_type else null end) as type2,
count(case when user_type=3 then user_type else null end) as type3
from b_emails group by time_id,period_id order by time_id

-- device的变化（每周）
select period_id, time_id,
count(case when device='samsung galaxy s4' then device else null end) as d1,
count(case when device='nexus 5' then device else null end) as d2,
count(case when device='iphone 5s' then device else null end) as d3,
count(case when device='dell inspiron desktop' then device else null end) as d4,
count(case when device='iphone 4s' then device else null end) as d5,
count(case when device='asus chromebook' then device else null end) as d6,
count(case when device='ipad air' then device else null end) as d7,
count(case when device='acer aspire notebook' then device else null end) as d8,
count(case when device='hp pavilion desktop' then device else null end) as d9,
count(case when device='macbook pro' then device else null end) as d10,
count(case when device='lenovo thinkpad' then device else null end) as d11,
count(case when device='macbook air' then device else null end) as d12,
count(case when device='nexus 7' then device else null end) as d13,
count(case when device='mac mini' then device else null end) as d14,
count(case when device='htc one' then device else null end) as d15,
count(case when device='kindle fire' then device else null end) as d16,
count(case when device='windows surface' then device else null end) as d17,
count(case when device='samsung galaxy note' then device else null end) as d18,
count(case when device='amazon fire phone' then device else null end) as d19,
count(case when device='samsumg galaxy tablet' then device else null end) as d20,
count(case when device='nokia lumia 635' then device else null end) as d21,
count(case when device='nexus 10' then device else null end) as d22,
count(case when device='acer aspire desktop' then device else null end) as d23,
count(case when device='iphone 5' then device else null end) as d24,
count(case when device='dell inspiron notebook' then device else null end) as d25,
count(case when device='ipad mini' then device else null end) as d26
from b_events group by time_id,period_id order by time_id

-- 各种品牌的数量变化（每周）
select period_id, time_id,
count(case when device='acer aspire notebood' or device='acer aspire desktop' then device else null end) as acer,
count(case when device='asus chromebook' then device else null end) as asus,
count(case when device='dell inspiron notebook' or device='dell inspiron desktop' then device else null end) as dell,
count(case when device='amazon fire phone' then device else null end) as fire,
count(case when device='hp pavilion desktop' then device else null end) as hp,
count(case when device='htc one' then device else null end) as htc,
count(case when device='ipad air' or device='ipad mini' then device else null end) as ipad,
count(case when device='iphone 5' or device='iphone 5s' or device='iphone 4s' then device else null end) as iphone,
count(case when device='kindle fire' then device else null end) as kindle,
count(case when device='lenovo thinkpad' then device else null end) as lenovo,
count(case when device='macbook pro' or device='mac book air' or device='mac mini' then device else null end) as mac,
count(case when device='windows surface' then device else null end) as microsoft,
count(case when device='nexus 5' or device='nexus 7' or device='nexus 10' then device else null end) as nexus,
count(case when device='nokia lumia 635' then device else null end) as nokia,
count(case when device='samsung galaxy s4' or device='samsung galaxy note' or device='samsung galaxy tablet' then device else null end) as samsumg
from b_events group by time_id,period_id order by time_id

-- 不同时段注册用户的活跃度变化（每天）
select date,
count(case when user_id>=1 and user_id<=331 then user_id else null end) as r1,
count(case when user_id>=332 and user_id<=659 then user_id else null end) as r2,
count(case when user_id>=660 and user_id<=1042 then user_id else null end) as r3,
count(case when user_id>=1043 and user_id<=1452 then user_id else null end) as r4,
count(case when user_id>=1453 and user_id<=1938 then user_id else null end) as r5,
count(case when user_id>=1939 and user_id<=2423 then user_id else null end) as r6,
count(case when user_id>=2424 and user_id<=3031 then user_id else null end) as r7,
count(case when user_id>=3032 and user_id<=3667 then user_id else null end) as r8,
count(case when user_id>=3668 and user_id<=4366 then user_id else null end) as r9,
count(case when user_id>=4367 and user_id<=5192 then user_id else null end) as r10,
count(case when user_id>=5193 and user_id<=6008 then user_id else null end) as r11,
count(case when user_id>=6009 and user_id<=6980 then user_id else null end) as r12,
count(case when user_id>=6981 and user_id<=8063 then user_id else null end) as r13,
count(case when user_id>=8064 and user_id<=9117 then user_id else null end) as r14,
count(case when user_id>=9118 and user_id<=10348 then user_id else null end) as r15,
count(case when user_id>=10349 and user_id<=11767 then user_id else null end) as r16,
count(case when user_id>=11768 and user_id<=13364 then user_id else null end) as r17,
count(case when user_id>=13365 and user_id<=15092 then user_id else null end) as r18,
count(case when user_id>=15093 and user_id<=17075 then user_id else null end) as r19,
count(case when user_id>=17076 and user_id<=19065 then user_id else null end) as r20
from b_events group by date order by date

-- 不同时段注册用户的活跃度变化（每周）
select time_id, period_id,
count(case when user_id>=1 and user_id<=331 then user_id else null end) as r1,
count(case when user_id>=332 and user_id<=659 then user_id else null end) as r2,
count(case when user_id>=660 and user_id<=1042 then user_id else null end) as r3,
count(case when user_id>=1043 and user_id<=1452 then user_id else null end) as r4,
count(case when user_id>=1453 and user_id<=1938 then user_id else null end) as r5,
count(case when user_id>=1939 and user_id<=2423 then user_id else null end) as r6,
count(case when user_id>=2424 and user_id<=3031 then user_id else null end) as r7,
count(case when user_id>=3032 and user_id<=3667 then user_id else null end) as r8,
count(case when user_id>=3668 and user_id<=4366 then user_id else null end) as r9,
count(case when user_id>=4367 and user_id<=5192 then user_id else null end) as r10,
count(case when user_id>=5193 and user_id<=6008 then user_id else null end) as r11,
count(case when user_id>=6009 and user_id<=6980 then user_id else null end) as r12,
count(case when user_id>=6981 and user_id<=8063 then user_id else null end) as r13,
count(case when user_id>=8064 and user_id<=9117 then user_id else null end) as r14,
count(case when user_id>=9118 and user_id<=10348 then user_id else null end) as r15,
count(case when user_id>=10349 and user_id<=11767 then user_id else null end) as r16,
count(case when user_id>=11768 and user_id<=13364 then user_id else null end) as r17,
count(case when user_id>=13365 and user_id<=15092 then user_id else null end) as r18,
count(case when user_id>=15093 and user_id<=17075 then user_id else null end) as r19,
count(case when user_id>=17076 and user_id<=19065 then user_id else null end) as r20
from b_events group by time_id,period_id order by time_id
