# Restaurant-Order-Details-SQL
**Tools Used:** MySQL, PowerBI
[Datasets Used](https://www.kaggle.com/datasets/mohamedharris/restaurant-order-details/data?select=Orders.xlsx)


## Questions I Wanted To Answer From the Dataset:

## 1. Total Number Of User Using This App?
```mysql
SELECT COUNT(DISTINCT O.customer_name) AS total_users
FROM orders as O
```
Result: 
![Q1](https://ibb.co/Q6p82j1)
