select * from walmart
-- Q1 Find different payment method and numbers and numbers of transactions, no. of qty sold

select payment_method,
count(*) as no_payments,
sum(quantity) as no_qty_sold from walmart
group by payment_method;

-- Q2 Display the highest- rated category in each branch, display the branch , category, AVG rating
select * from
(
select branch ,
category,
AVG(rating),
RANK() over (partition by branch order by AVG(rating)desc) as rating_ranked 
from walmart
group by branch ,category) as ranked_walmart
where rating_ranked =1;

-- Q3 Calculate the total qty of items sold per payment method. List payment_method  
Select payment_method,
sum(quantity) as no_qty_sold
 from walmart
 group by  payment_method;
 
 -- Q4 Determine the avg,min and max rating of category for each city.
 -- List the city, Avg_rating, min_rating and max_rating
 select city,
 category,
 min(rating) as min_rating,
 max(rating) as max_rating,
 avg(rating) as avg_rating
 from walmart
 group by city , category;
 
 -- Q5  Calculate the total profit for each category buy considering total_profit as (unit_price * quantity * profit_margin).
 -- List category and total_profit, order from higest to lowest profile.
 select
 category ,
 sum(total_price) as total_revenue,
 sum(total_price * profit_margin ) as profit
 from walmart
 group by category;
 
 -- Q6 Deterime the most common payment method for each branch.
 -- Display branch and the preferred_payment_method.
 select * from
 (select branch,
 payment_method,
 count(*)as total_trans,
 rank() over (partition by branch order by count(*)desc) as rating_rank
 from walmart
 group by branch , payment_method) as abc
 where rating_rank= 1;
 
 -- Q7 categorize the sales into 3 groups MORNIG, AFTERNOON, AND EVNING
 -- Find out each of the shifts and number of invoice
Select
case
When extract(hour from(time)) <12 then 'Moring'
when extract(hour from(time)) between 12 and 17 then 'Afternoon'
else 'Evning'
end as time_of_day,
count(invoice_id) as number_of_invoices
from walmart
 group by time_of_day;
 
 -- Q8 Identify 5 branch with highest decrese ratio in revevnue
 -- compare to the last year(current year is 2026 and last year was 2025)