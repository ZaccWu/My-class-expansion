-- 用户存留分析

-- 查看时间序列
select * from y_emails order by occurred_at
select * from y_events order by occurred_at
select * from y_users order by created_at

-- 处理时间字符并加入查询表中的时间列
select * from y_users
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_users.created_at),0,11)
select * from y_emails
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_emails.occurred_at),0,11)
select * from y_events
left join time_pc
on time_pc.date=substring(convert(varchar(10),y_events.occurred_at),0,11)
