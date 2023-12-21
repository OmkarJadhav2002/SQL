USE datamanip;

-- SQL GROUPING AND SORTING ***

-- SORTING DATA 
-- Que. 1: Find top 5 samsung smartphones with biggest screen size 
SELECT brand_name, model, screen_size FROM smartphones 
where brand_name = "samsung"
order by screen_size desc limit 5;

-- Que.2: Find top 5 phones with maximum number of total cameras 
select brand_name, model, num_rear_cameras+num_front_cameras as "total_cameras" from smartphones
order by total_cameras desc limit 5;
 
-- Que.3: Sort data on the basis of PPI value in decreasing order 
select brand_name, model, round(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size, 2) as "PPI"
from smartphones
order by PPI DESC;

-- Que.4: Find the phone with 2nd largest battery 
select brand_name, model, battery_capacity from smartphones
order by battery_capacity desc limit 1, 1;

-- Que.5: Find the name and rating of the worst apple phone.
select brand_name, model, rating from smartphones
where brand_name = "apple"
order by rating asc limit 1;

-- Que.6: Sort phones alphabetically and then on the basis of rating in desc order.
select * from smartphones 
order by brand_name asc, rating desc;

-- Que.7: Sort phones alphabetically and then on the basis of price in asc order.
select * from smartphones 
order by brand_name asc, price asc;


-- GROUPING DATA 
-- Que.1: Group smartphones by brand and get the count, average price, max rating, avg screen size, avg battery capacity.
select brand_name, count(*) as "no_phones", round(avg(price), 2) as "avg_price", max(rating) as "max_rating", 
round(avg(screen_size), 2) as "avg_screen_size", round(avg(battery_capacity), 2) as "avg_battery_capacity"
from smartphones
group by brand_name
order by no_phones desc; 

-- Que.2: Group smartphones by whether they have NFC and get the average price and rating.
select has_nfc, round(avg(price), 2) as "avg_price", round(avg(rating), 2) as "avg_rating" from smartphones
group by has_nfc;

-- Que.3: Group smartphones by the extended memory available and get the avg price 
select extended_memory_available, avg(price) as "avg_price" from smartphones
group by extended_memory_available;

-- Que.4: Group smartphones by the brand and processor brand and get the count of models and the avg primary camera resolution(rear)
select brand_name, processor_brand, count(*) as "no_phones", round(avg(primary_camera_rear), 2) as "avg_resolution" from smartphones 
group by brand_name, processor_brand;

-- Que.5: Find top 5 most costly phone brands 
select brand_name, round(avg(price), 2) as "avg_price" from smartphones
group by brand_name
order by avg_price desc limit 5;

-- Que.6:  Which brand makes the smallest screen smartphones?
select brand_name, round(avg(screen_size), 2) as "avg_screen_size" from smartphones
group by brand_name 
order by avg_screen_size asc limit 1;

-- Que.7: avg price of 5G phones vs avg price of non 5G phones
select has_5g, round(avg(price), 2) as "avg_price" from smartphones
group by has_5g;

-- Que.8: Group smartphones by the brand, and find the brand with the highest number of models that has both NFC and IR blaster.
select brand_name, count(*) as "no_models" from smartphones 
where has_nfc = "True" and has_ir_blaster = "True"
group by brand_name
order by no_models desc limit 1;

-- Que.9: Find all samsung 5G enabled smartphones and find out the avg price for NFC and Non-NFC
select brand_name, has_nfc, round(avg(price), 2) as "avg_price" from smartphones
where has_5g = "True" and brand_name = "samsung"
group by has_nfc;

-- Que.10: Find phone name, price of the costliest phone 
select brand_name, model, price from smartphones 
order by price desc limit 1;


-- HAVING CLAUSE (filtering group by) -> like where for select, having for group by 
-- Que.1: Find the avg rating of smartphone brand have more than 20 phones 
select brand_name, count(*) as "count", round(avg(rating), 2) as "avg_rating" from smartphones
group by brand_name having count > 20
order by count desc;

-- Que.2: Find top 3 brands with highest avg ram that have a refresh rate of at least 90 Hz and fast charging available and dont consider 
-- brands which have less than 10 phones 
select brand_name, refresh_rate, count(*) as count, round(avg(ram_capacity), 2) as "avg_ram" from smartphones
where fast_charging_available = 1 and refresh_rate >= 90
group by brand_name having count > 10
order by avg_ram desc limit 3;

-- Que.3: Find the avg price of all the phone brands with rating > 70 and number of phones more than 10 among all 5G enabled phones.
select brand_name, count(*) as "count", rating, round(avg(price), 2) as "avg_price" from smartphones
where has_5g = "True"
group by brand_name having count > 10 and rating > 70 
order by avg_price desc;
