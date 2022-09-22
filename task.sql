use Labor_SQL;
-- 73 variant
-- 1
SELECT
    model,
    ram,
    price
FROM
    Laptop
WHERE
    ram = 64
ORDER BY
    screen ASC;

-- 2
SELECT
    name
FROM
    Ships
WHERE
    name RLIKE '^W.*n$';

-- 3
SELECT
    DISTINCT pc1.model,
    pc2.model,
    pc1.hd,
    pc1.ram
FROM
    PC AS pc1
    JOIN PC AS pc2 ON pc1.ram = pc2.ram
    AND pc1.hd = pc2.hd
WHERE
    pc1.model < pc2.model;

-- 4
SELECT
    ship,
    battle,
    date
FROM
    Outcomes AS oc
    LEFT JOIN Battles AS bt ON oc.battle = bt.name
WHERE
    ship IN(
        SELECT
            ship
        FROM
            Outcomes AS oc_i
            LEFT JOIN Battles AS bt_i ON oc_i.battle = bt_i.name
        WHERE
            date < bt.date
            AND result = 'damaged'
    );

-- 5
SELECT
    maker
FROM
    Product right join PC on Product.model = PC.model
group by maker
having max(PC.speed) >=750;

-- 6
SELECT
    concat(year(date), '.', MONTH(date), '.', DAY(date))
FROM
    Income;

SELECT
    date_format(date, '%Y.%m.%d')
FROM
    Income;

-- 7
SELECT
    maker,
    count(maker)
FROM
    Product
WHERE
    TYPE = 'PC'
GROUP BY
    maker
HAVING
    count(maker) >= 2;

-- 8
SELECT
    maker,
    min(speed)
FROM
    Product AS pr
    RIGHT JOIN Laptop AS lp ON pr.model = lp.model
GROUP BY
    maker
HAVING
    600 <= max(speed);

-- 9
SELECT
    trip_no,
    name,
    plane,
    town_from,
    town_to,
    CASE
        WHEN time_in < time_out THEN timediff(Date_add(time_in, INTERVAL 1 DAY), time_out)
        ELSE timediff(time_in, time_out)
    END AS duration
FROM
    Trip AS tp
    LEFT JOIN Company AS cp ON tp.ID_comp = cp.ID_comp;

-- 10
SELECT
    *
FROM
    (
        SELECT
            name
        FROM
            Ships
        UNION
        DISTINCT
        SELECT
            ship AS name
        FROM
            Outcomes
    ) AS ships
WHERE
    name RLIKE '.+\\s.+\\s.+';