# Restaurant-Order-Details-SQL
**Tools Used:** MySQL, PowerBI

[Datasets Used](https://www.kaggle.com/datasets/mohamedharris/restaurant-order-details/data?select=Orders.xlsx)

[SQL Analysis (Code)]()


## Questions I Wanted To Answer From the Dataset:

## 1. Total Number Of User Using This App?
```mysql
SELECT COUNT(DISTINCT O.customer_name) AS total_users
FROM orders as O
```
Result: 

![Q1](https://i.imgur.com/bSHgldx.png)

## 2. Top 5 highest rating restaurants?
```mysql
SELECT (SELECT R1.RestaurantName
        FROM restaurants AS R1
        WHERE R1.RestaurantID = T.restaurant_id) AS restaurant_name,
       T.food_rating
FROM (SELECT O.restaurant_id, SUM(O.food_rating) AS food_rating
      FROM orders AS O
      GROUP BY O.restaurant_id) AS T
ORDER BY T.food_rating DESC
LIMIT 5
```
Result:

![Q2](https://i.imgur.com/AT8SGGS.png)

## 3. Top 20 customer with most sales?
```mysql
SELECT O.customer_name,SUM(O.quantity) AS total_qunatity
FROM orders AS O
GROUP BY O.customer_name
ORDER BY total_qunatity DESC
LIMIT 20
```
Result:

![Q3](https://i.imgur.com/fxTNKd5.png)

## 4. Sales of each restaurants?
```mysql
SELECT R1.RestaurantName AS restaurant_name,T.total_amount
FROM (SELECT O.restaurant_id,SUM(O.amount) AS total_amount
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
ORDER BY T.total_amount
```
Result:

![Q4](https://i.imgur.com/7qeo7jk.png)

## 5. Most sales of each restaurants on the basis of zone,cuisine and category?
- By Zone
```mysql
SELECT R1.Zone AS zone,SUM(T.total_amount) AS amount
FROM (SELECT O.restaurant_id,SUM(O.amount) AS total_amount
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY zone
ORDER BY amount
```
Result:

![Q5](https://i.imgur.com/0H7UZ5N.png)

- By Cuisine
```mysql
SELECT R1.Cuisine AS cuisine,SUM(T.total_quantity) AS quantity_ordered
FROM (SELECT O.restaurant_id,SUM(O.quantity) AS total_quantity
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY cuisine
ORDER BY quantity_ordered
```
Result:

![Q6](https://i.imgur.com/QaL1Oef.png)

-By Category
```mysql
SELECT R1.Category AS category,SUM(T.total_quantity) AS quantity
FROM (SELECT O.restaurant_id,SUM(O.quantity) AS total_quantity
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
GROUP BY category
ORDER BY quantity
```
Result:

![Q7](https://i.imgur.com/L33hjpn.png)

## 6. Average delivery time taken by each restaurant?
```mysql
SELECT R1.RestaurantName AS restaurant_name,ROUND(T.dtime,0) AS avg_delivery_time
FROM (SELECT O.restaurant_id,AVG(O.delivery_time) AS dtime
FROM orders AS O
GROUP BY O.restaurant_id ) AS T
INNER JOIN restaurants AS R1
ON T.restaurant_id=R1.RestaurantID
ORDER BY avg_delivery_time
```
Result:

![Q8](https://i.imgur.com/6xFmmhU.png)
