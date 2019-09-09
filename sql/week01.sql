-- 1.1
CREATE TABLE `学生基本资料` (
  `学号` int NOT NULL,
  `姓名` varchar(4) NOT NULL,
  `年级` int NOT NULL,
  PRIMARY KEY (`学号`,`姓名`,`年级`)
) DEFAULT CHARSET=utf8;
INSERT INTO `学生基本资料` (`学号`,`姓名`,`年级`) VALUES
  ('221', '小何', '2017'),
  ('222', '小赵', '2017'),
  ('225', '小宝', '2018');

select * from 学生基本资料

-- 1.2
CREATE TABLE items_ordered
    (`customerid` int, `order_date` datetime, `item` varchar(19), `quantity` int, `price` int)
;
    
INSERT INTO items_ordered
    (`customerid`, `order_date`, `item`, `quantity`, `price`)
VALUES
    (10330, '1999-06-30 00:00:00', 'Pogo stick', 1, 28.00),
    (10101, '1999-06-30 00:00:00', 'Raft', 1, 58.00),
    (10298, '1999-07-01 00:00:00', 'Skateboard', 1, 33.00),
    (10101, '1999-07-01 00:00:00', 'Life Vest', 4, 125.00),
    (10299, '1999-07-06 00:00:00', 'Parachute', 1, 1250.00),
    (10339, '1999-07-27 00:00:00', 'Umbrella', 1, 4.50),
    (10449, '1999-08-13 00:00:00', 'Unicycle', 1, 180.79),
    (10439, '1999-08-14 00:00:00', 'Ski Poles', 2, 25.50),
    (10101, '1999-08-18 00:00:00', 'Rain Coat', 1, 18.30),
    (10449, '1999-09-01 00:00:00', 'Snow Shoes', 1, 45.00),
    (10439, '1999-09-18 00:00:00', 'Tent', 1, 88.00),
    (10298, '1999-09-19 00:00:00', 'Lantern', 2, 29.00),
    (10410, '1999-10-28 00:00:00', 'Sleeping Bag', 1, 89.22),
    (10438, '1999-11-01 00:00:00', 'Umbrella', 1, 6.75),
    (10438, '1999-11-02 00:00:00', 'Pillow', 1, 8.50),
    (10298, '1999-12-01 00:00:00', 'Helmet', 1, 22.00),
    (10449, '1999-12-15 00:00:00', 'Bicycle', 1, 380.50),
    (10449, '1999-12-22 00:00:00', 'Canoe', 1, 280.00),
    (10101, '1999-12-30 00:00:00', 'Hoola Hoop', 3, 14.75),
    (10330, '2000-01-01 00:00:00', 'Flashlight', 4, 28.00),
    (10101, '2000-01-02 00:00:00', 'Lantern', 1, 16.00),
    (10299, '2000-01-18 00:00:00', 'Inflatable Mattress', 1, 38.00),
    (10438, '2000-01-18 00:00:00', 'Tent', 1, 79.99),
    (10413, '2000-01-19 00:00:00', 'Lawnchair', 4, 32.00),
    (10410, '2000-01-30 00:00:00', 'Unicycle', 1, 192.50),
    (10315, '2000-02-02 00:00:00', 'Compass', 1, 8.00),
    (10449, '2000-02-29 00:00:00', 'Flashlight', 1, 4.50),
    (10101, '2000-03-08 00:00:00', 'Sleeping Bag', 2, 88.70),
    (10298, '2000-03-18 00:00:00', 'Pocket Knife', 1, 22.38),
    (10449, '2000-03-19 00:00:00', 'Canoe paddle', 2, 40.00),
    (10298, '2000-04-01 00:00:00', 'Ear Muffs', 1, 12.50),
    (10330, '2000-04-19 00:00:00', 'Shovel', 1, 16.75)

-- 1.2
-- 1.从items_ordered表中选择customerid为10449的顾客购买的所有记录，展示这些记录的cutomerid，item以及price属性。
select `customerid`,`item`,`price` from `items_ordered` where customerid='10449';
 
-- 2.从items_ordered表中选择购买Tent的记录。
select * from `items_ordered` where item='Tent';
 
-- 3.从items_ordered表中选择那些购买以字母“S”开头的商品的记录。（提示：使用LIKE子句）
select * from `items_ordered` where item like 'S%'
-- 这里利用like语句进行关键词匹配，’%’在S的后面说明是以S关键字开头。
 

-- 4.从items_ordered表中选择所有包含不相同商品的记录，并只展示这些记录中购买的商品，也即item属性。
select distinct `item` from `items_ordered`;
-- 这里使用distinct关键词可以从item这一列中找出所有不重复的数据。
