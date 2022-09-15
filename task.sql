-- 73 variant
-- 1
select model, ram, price
from Laptop
where ram = 64
order by screen asc;

-- 2
select name
from Ships
where name rlike '^W.*n$';

-- 3
select distinct pc1.model, pc2.model, pc1.hd, pc1.ram
from PC as pc1 join PC as pc2 on pc1.ram = pc2.ram  and pc1.hd = pc2.hd
where pc1.model < pc2.model;

-- 4
select ship, battle, date
from Outcomes as oc left join Battles as bt on oc.battle = bt.name
where ship in(select ship
from Outcomes as oc_i left join Battles as bt_i on oc_i.battle = bt_i.name       
where date < bt.date and result = 'damaged'
);

-- 5
select maker
from (select distinct maker from Product) as pr
where exists(select 
            *
        from
            Product as pr_i
                left join
            PC as pc on pr_i.model = pc.model
		where pr_i.type = 'PC' and pr.maker = pr_i.maker and pc.speed >= 750);
        
-- 6
select concat(year(date), '.', month(date), '.', day(date))
from Income;

select date_format(date, '%Y.%m.%d')
from Income;

-- 7
select maker, count(maker)
from Product
where type = 'PC'
group by maker
having count(maker) >= 2;

-- 8
select maker, min(speed)
from Product as pr right join Laptop as lp on pr.model=lp.model
group by maker
having 600 <= max(speed);

-- 9
select trip_no, name, plane, town_from, town_to, case when time_in < time_out then timediff(Date_add(time_in, interval 1 day), time_out) else timediff(time_in, time_out) end as duration
from Trip as tp left join Company as cp on tp.ID_comp = cp.ID_comp;

-- 10
SELECT 
    name
FROM
    (SELECT 
        name
    FROM
        Ships UNION DISTINCT SELECT 
        ship AS name
    FROM
        Outcomes) AS ships
WHERE
    name RLIKE '\s.*\s';