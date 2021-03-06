Welcome!



### Week1 Short answers
1. How many users do we have?

130 users

``` select count(distinct id) from users; ```


2. On average, how many orders do we receive per hour?

8.16 checkouts in an average hour

``` select AVG(checkouts) checkouts from (select date_trunc('hour', created_at) AS hour_of_day, count(event_id) AS checkouts from events where event_type = 'checkout' group by 1) avg_co; ```



3. On average, how long does an order take from being placed to being delivered?

3 days 22:13:10.504451

``` select AVG(delivered_at - created_at) AS AVG_placed_to_delivery from snapshots.orders_snapshot; ```


4. How many users have only made one purchase? Two purchases? Three+ purchases?

25 users had 1 purchase 

22 users had 2 purchases

81 users had 3 purchases

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from snapshots.orders_snapshot group by 2 HAVING count(order_id) = 1) one_purchase; ```

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from snapshots.orders_snapshot group by 2 HAVING count(order_id) = 2) two_purchase; ```

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from snapshots.orders_snapshot group by 2 HAVING count(order_id) >= 3) three_purchase; ```

5. On average, how many unique sessions do we have per hour?

There are 7.4 sessions per hour on average

``` select AVG(sessions) AS hourly_avg_sessions from (select date_trunc('hour', created_at) AS hourOfDay, COUNT(distinct session_id) AS sessions from snapshots.events_snapshot.events group by 1) temp; ```

### Week2 Short answers
What is our user repeat rate? Repeat Rate = Users who purchased 2 or more times / users who purchased

Queries used:
1. total distinct users ```select count(distinct user_id) from dbt_renee_liu.stg_orders```
2. total repeat users ``` select count(user_id) from (select count(order_id) AS total_orders, user_id from stg_orders group by 2 HAVING count(order_id) > 1) one_purchase;```

~ 80% repeat users.

### week 3 short answers
1. null
2. Product conversion rate is (but they are not realistic)
![Product conversion rate](./prod_conv_rate.png)

### Model Dag
![Renee's first Dag](./project2_dags.png)

### Week 4 
![Product funnel conversion analysis](./product_funnel_result.png)

Reflection 2B: I want to look into the meta data on testing to see if I can create tests with lineage data to track how data quality issues are originated and pertuated downstream