SELECT * FROM dominos.`copy of pizza_sales_excel_file`;
use dominos;

-- Total revenue
SELECT sum(total_price) from pizza_sales;
-- 817860.049999993

-- Average Order Value
SELECT sum(total_price)/count(distinct order_id)from pizza_sales;
-- 38.307262295081635

-- Total Pizzas Sold
SELECT sum(quantity) from pizza_sales;
-- 49574

-- Total orders placed
SELECT count(distinct order_id) as total_orders from pizza_sales;
-- 21350

-- Average pizzas per Order
SELECT cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))  from pizza_sales;
-- 2.32         

-- chart requirements
-- daily trends for total orders
SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day, COUNT(distinct order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day;
-- Friday	2973
-- Monday	3538
-- Saturday	3024
-- Sunday	3239
-- Thursday	2794
-- Tuesday	3158
-- Wednesday	2624

-- Monthly trends for total orders
SELECT  MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month, COUNT(distinct order_id) AS total_orders
FROM pizza_sales
GROUP BY order_month;
/*September	1661
  October	1646
  November	1792
  May	1853
  March	1840
  June	1773
  July	1935
  January	1845
  February	1685
  December	1680
  August	1841
   April	1799 */
   
-- Percentage of sales by pizza category
select pizza_category,cast(cast(sum(total_price)*100 as decimal (10,2))/cast( (select sum(total_price) from pizza_sales)as decimal(10,2))  as decimal(10,2))as percentage_of_sales
from pizza_sales
group by pizza_category
/*Classic	26.91
Veggie	23.68
Supreme	25.46
Chicken	23.96*/

-- Percentage of sales by pizza size
select pizza_size,cast(cast(sum(total_price)*100 as decimal (10,2))/cast( (select sum(total_price) from pizza_sales)as decimal(10,2))  as decimal(10,2)) as percentage_of_sales
from pizza_sales
group by pizza_size;
/*M	30.49
L	45.89
S	21.77
XL	1.72
XXL	0.12*/

-- Total pizzas sold by pizza_category
select pizza_category,sum(quantity) as units
from pizza_sales
group by pizza_category;
/*Classic	14888
Veggie	11649
Supreme	11987
Chicken	11050*/

-- TOop 5 sellers by revenue,total quanttity,total orders
-- revenue
select pizza_name,sum(total_price) as revenue
from pizza_sales
group by pizza_name
order by revenue desc
limit 5;
/*The Thai Chicken Pizza	43434.25
The Barbecue Chicken Pizza	42768
The California Chicken Pizza	41409.5
The Classic Deluxe Pizza	38180.5
The Spicy Italian Pizza	34831.25*/

-- quantity
select pizza_name,sum(quantity) as quantity
from pizza_sales
group by pizza_name
order by quantity desc
limit 5;
/*The Classic Deluxe Pizza	2453
The Barbecue Chicken Pizza	2432
The Hawaiian Pizza	2422
The Pepperoni Pizza	2418
The Thai Chicken Pizza	2371*/

-- orders
select pizza_name,count(distinct order_id) as orders
from pizza_sales
group by pizza_name
order by orders desc
limit 5;
/*The Classic Deluxe Pizza	2329
The Hawaiian Pizza	2280
The Pepperoni Pizza	2278
The Barbecue Chicken Pizza	2273
The Thai Chicken Pizza	2225*/

-- Bottom 5 sellers by revenue,total quanttity,total orders
-- revenue
select pizza_name,sum(total_price) as revenue
from pizza_sales
group by pizza_name
order by revenue asc
limit 5;
/*The Brie Carre Pizza	11588.4999999999
The Green Garden Pizza	13955.75
The Spinach Supreme Pizza	15277.75
The Mediterranean Pizza	15360.5
The Spinach Pesto Pizza	15596*/

-- quantity
select pizza_name,sum(quantity) as quantity
from pizza_sales
group by pizza_name
order by quantity asc
limit 5;
/*The Brie Carre Pizza	490
The Mediterranean Pizza	934
The Calabrese Pizza	937
The Spinach Supreme Pizza	950
The Soppressata Pizza	961*/

-- orders
select pizza_name,count(distinct order_id) as orders
from pizza_sales
group by pizza_name
order by orders asc
limit 5;
/*The Brie Carre Pizza	480
The Mediterranean Pizza	912
The Calabrese Pizza	918
The Spinach Supreme Pizza	918
The Chicken Pesto Pizza	938*/