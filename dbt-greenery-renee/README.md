Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### short answers
1. How many users do we have?

130 users

``` select count(distinct id) from users; ```


2. On average, how many orders do we receive per hour?

8.16 checkouts in an average hour

``` select AVG(checkouts) checkouts from (select date_trunc('hour', created_at) AS hour_of_day, count(event_id) AS checkouts from events where event_type = 'checkout' group by 1) avg_co; ```



3. On average, how long does an order take from being placed to being delivered?

3 days 22:13:10.504451

``` select AVG(delivered_at - created_at) AS AVG_placed_to_delivery from orders; ```


4. How many users have only made one purchase? Two purchases? Three+ purchases?

25 users had 1 purchase 

22 users had 2 purchases

81 users had 3 purchases

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from orders group by 2 HAVING count(order_id) = 1) one_purchase; ```

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from orders group by 2 HAVING count(order_id) = 2) two_purchase; ```

``` select count(user_id) from (select count(order_id) AS total_orders, user_id from orders group by 2 HAVING count(order_id) >= 3) three_purchase; ```

5. On average, how many unique sessions do we have per hour?

There are 7.4 sessions per hour on average

``` select AVG(sessions) AS hourly_avg_sessions from (select date_trunc('hour', created_at) AS hourOfDay, COUNT(distinct session_id) AS sessions from events group by 1) temp; ```
