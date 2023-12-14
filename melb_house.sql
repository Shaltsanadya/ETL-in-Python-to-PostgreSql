WITH count1 as(
	select date_trunc('year', date)as year_sold, 
	count(date_trunc('year', date)) as qty_sold
from melbourne
group by 1),

type_h as(
select sellerg, count(sellerg), count(sellerg)*100/(select count(*)
												   from melbourne) as percentage
from melbourne
where type= 'h'
group by 1
order by 2 desc
limit 5),

alltab as(
select*
from melbourne),

a as(select yearbuilt, count(yearbuilt)
from melbourne
group by 1
order by 2 desc),

type_t as(
select sellerg, count(sellerg), count(sellerg)*100/(select count(*)
												   from melbourne) as percentage
from melbourne
where type= 'h'
group by 1
order by 2 desc
limit 5),

type_u as(
select sellerg, count(sellerg), count(sellerg)*100/(select count(*)
												   from melbourne) as percentage
from melbourne
where type= 'h'
group by 1
order by 2 desc
limit 5),

low as(select suburb, yearbuilt, buildingarea, method, distance, propertycount, landsize, bathroom, max(price)
from melbourne
group by 1,2,3,4,5,6,7,8
order by 9 desc),

top_perform as (
	select type, (select sellerg
			  from (select sellerg, count (sellerg)
				   from melbourne
				   group by 1
				   order by 2 desc)
			  limit 1), 
			count(sellerg) as qty_sold, 
			count(sellerg)*100/(select count(*)
								from melbourne) 
								as percentage
	from melbourne
	group by 1
	order by 3 desc),

sold16 as (
	select 
	sellerg,
	count(sellerg) as qty_sold16
	from melbourne
	where date_trunc('year', date)= '2016-01-01'
	group by 1
	order by 2 desc),
	
sold17 as (
	select 
	sellerg,
	count(sellerg) as qty_sold17
	from melbourne
	where date_trunc('year', date)= '2017-01-01'
	group by 1
	order by 2 desc),
	
growth as(select sold17.sellerg,qty_sold16,qty_sold17,
Round((qty_sold17-qty_sold16)*100/qty_sold16,1) as growth_rate
from
sold17
inner join 
sold16
on
sold17.sellerg= sold16.sellerg
order by 3 desc
)

select Avg(price)
from melbourne