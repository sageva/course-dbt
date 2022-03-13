**PART 1**

**Questions:**
1. 80%. 
    *Query: SELECT ROUND(((count(distinct case when orders >= 2 then user_id else null end)) :: DECIMAL / count(distinct case when orders > 0 then user_id else null     end)),2) FROM (SELECT user_id, count(distinct order_id) as orders FROM orders GROUP BY 1 ORDER BY 1) s*
2. From the data we have, I think factors like speedy delivery, other website events and would be interesting to explore. It would also be interesting to see if some folks only buy when there are promos (indicating they won’t purchase again until there’s another promo). In terms of data we don’t have: user ratings/reviews of products would be helpful.

**Models**

Intermediate models:

1. PRODUCTS: Joining together orders and order items so we can have all basic info about orders in the same place. int_orders
2. CORE: Joining together users and addresses so we can have all basic info about users in one place. int_users
3. MARKETING: Joining together orders and promos as int_promos and removing non-promo-related columns so we can have all basic info about promos in the same     place. int_promos


Fact/dim models: 

1. PRODUCTS: Fact model that provides an overview of all products ordered; could use to see popular products, order trends, etc.
2. MARKETING: Fact model that perform some aggregation on the int_promos table to clearly see how promotions are being used.
3. CORE: Fact model that uses several of the int models to provide an overview of open orders; could be used for customer service inquiries. 

<img
src="https://github.com/sageva/course-dbt/blob/main/greenery/Screen%20Shot%202022-03-12%20at%2010.31.44%20PM.png"
raw=true
alt="DAG Visual"
style="margin-right: 10px;"
/>

**PART 2**

**Tests**

1.I added four tests; one in each mart, and one on the original tables from week 1. 

*Test 1:*
In the project 1 schema on the orders model, I added a test from the dbt_utils package, at_least_one, to the order_id column. The orders table is the center of the rest of our data, and the order_id column is its primary key; if there isn’t at least one order id coming through, there’s a big flaw with our data that will impact a lot of models. 

*Test 2:*
In the products mart on fact_products, I added a not null test to the product name column. This column is a critical part of how users will use this model, and it’s the main piece of information being joined at this layer, so I would want to know quickly if there was an error and null names were coming in.

*Test 3:*
In the core mart on int_users, I added a unique and a not null test on the user_id column. Both need to be true for this model to function properly, and errors would be tough to identify when using the table normally so a test running in the background is a good reassurance. 

*Test 4:*
In the marketing mart on fact_promo_use I added a test from the dbt_utils package, accepted_range, to the total discount column, to check if the value was over 0. Since we’re performing a couple different aggregations in this model, I wanted include a test that affirmed the data was aggregating properly. If the total is less than 1, then it is not. 

2. I did not find any bad data with my tests. I think my tests are more oriented towards identifying issues in the future though, such as pipelines running incorrectly, because that’s the main problem I see with the data I work with day to day! 

3. I would let the stakeholders know that we’ve identified the basic competencies that our data must pass every day, and that we run a check on them every morning before the business day starts. With our tests, we can either confirm everything is running correctly or know about problems quickly and be able to notify impacted parties and implement fixes proactively. In particular: if a test failed, we would put a flag on any impacted models and end-user products immediately, and post an automated notification in staff communication channels. Then we would work to resolve the error, including more communication to impacted parties if the fix will take more than a pre-agreed upon amount of time, and update all notifications and communications once the issue is fixed.
