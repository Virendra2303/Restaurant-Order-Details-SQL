-- Total Number Of User Using This App?
SELECT COUNT(DISTINCT O.customer_name) AS total_users
FROM orders as O;

-- Top 5 highest rating restaurants
SELECT (SELECT R1.RestaurantName
        FROM restaurants AS R1
        WHERE R1.RestaurantID = T.restaurant_id) AS restaurant_name,
       T.food_rating
FROM (SELECT O.restaurant_id, SUM(O.food_rating) AS food_rating
      FROM orders AS O
      GROUP BY O.restaurant_id) AS T
ORDER BY T.food_rating DESC
LIMIT 5;
  
-- Top 20 customer with most sales?
SELECT O.customer_name,SUM(O.quantity) AS total_qunatity
FROM orders AS O
GROUP BY O.customer_name
ORDER BY total_qunatity DESC
LIMIT 20;

-- Sales of each restaurants?
SELECT R1.RestaurantName AS restaurant_name,T.total_amount
FROM (SELECT O.restaurant_id,SUM(O.amount) AS total_amount
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
ORDER BY T.total_amount;

-- Most sales of each restaurants on the basis of zone?
SELECT R1.Zone AS zone,SUM(T.total_amount) AS amount
FROM (SELECT O.restaurant_id,SUM(O.amount) AS total_amount
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY zone
ORDER BY amount;

-- Most sales of each restaurants on the basis of Cuisine?
SELECT R1.Cuisine AS cuisine,SUM(T.total_quantity) AS quantity_ordered
FROM (SELECT O.restaurant_id,SUM(O.quantity) AS total_quantity
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY cuisine
ORDER BY quantity_ordered;
  
-- Most sales of each restaurants on the basis of Category?

SELECT R1.Category AS category,SUM(T.total_quantity) AS quantity
FROM (SELECT O.restaurant_id,SUM(O.quantity) AS total_quantity
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY category
ORDER BY quantity;


-- Average delivery time taken by each restaurant?
SELECT R1.RestaurantName AS restaurant_name,ROUND(T.dtime,0) AS avg_delivery_time
FROM (SELECT O.restaurant_id,AVG(O.delivery_time) AS dtime
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
ORDER BY avg_delivery_time;
