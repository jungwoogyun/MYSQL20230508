-- 01 Group by
use shopdb;
-- sum()
select userid,sum(amount) from buytbl group by userId;
select userid,sum(amount*price) from buytbl group by userId;
select userid,sum(amount*price) as '구매총액' from buytbl group by userId;
-- avg()
select userid,avg(amount) from buytbl group by userId;
select userid,truncate(avg(amount),2) from buytbl group by userId;
-- max() , min()
select max(height) from usertbl;
select min(height) from usertbl;
-- 가장 큰키와 가장 작은키를 가지는 유저의 모든 열값을 출력해보세요.
select * from usertbl where height=(select max(height) from usertbl);
select * from usertbl where height=(select min(height) from usertbl);
select * from usertbl 
where 
height=(select max(height) from usertbl)
or
height=(select min(height) from usertbl);
-- count() 
select count(*) from usertbl;
select count(mobile1) from usertbl;

-- 문제 
-- 1 buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select * from buytbl;
select userid,sum(amount) from buytbl group by userid;
-- 2 usertbl에서 키의 평균값을 구하세요
select  truncate(avg(height),2) from usertbl;
-- 3 buy테이블에서 최대구매량과 최소구매량을 userid와함께 출력하세요
select userid,amount from buytbl
where 
amount=(select min(amount) from buytbl)
or
amount=(select max(amount) from buytbl);
-- 4 buytbl의 groupname 의 개수를 출력하세요
select count(groupname) from buytbl;

select * from buytbl where groupname is null ;
select * from buytbl where groupname is not null ;


-- 1 customers테이블의 city 를 그룹으로 creditLimit의 평균을 구하세요 
use classicmodels;
select city,avg(creditLimit) from customers group by city;

-- 2 orderdetails테이블의 orderNumber를 그룹으로quntityOrdered의 총합을 출력하세요
select orderNumber,sum(quantityOrdered) from orderdetails group by orderNumber;

-- 3 products테이블의 productVendor를 그룹으로quantityInStock의 총합을 출력하세요 
select productVendor,sum(quantityInStock) from products group by productVendor;



-- 02 Group by  + Having

-- buytbl에서 userid별로 amount 총합
use shopdb;
select userid, sum(amount) as '총량' from buytbl group by userid
having sum(amount)>=5;

select * from buytbl;
select groupname, sum(amount) from buytbl group by groupname
having sum(amount)>=5;

select * from usertbl;

select addr,avg(height) from usertbl group by addr having avg(height)>=175;

-- 03 Rollup
select num,groupname, sum(price*amount) 
from buytbl 
group by groupname,num with rollup;

select groupname, sum(price*amount) 
from buytbl 
group by groupname with rollup;

select userid,addr,avg(height) from usertbl group by addr,userid with rollup;

select addr,avg(height) from usertbl group by addr with rollup;

-- 문제

-- 1. prodName별로 그룹화 한뒤 userID / prodName/Price*amount 순으로 출력될 수 있도록 설정

select userid,prodname,sum(price*amount) from buytbl group by prodname,userid;

-- 2. 1 번 명령어에서 price*amount 값이 1000이상인 행만 출력

select userid,prodname,sum(price*amount) from buytbl group by prodname,userid
having sum(price*amount)>=1000;

-- 3. price 가격이 가장 큰 행과 작은 행의 userid , prodName,price을 출력
select distinct userid,prodname,price from buytbl
where 
price=(select max(price) from buytbl)
or 
price=(select min(price) from buytbl);

-- 4. 다음 행중에 그룹네임이 있는 행만 출력
select * from buytbl where groupname is not null;

-- 5 prodName 별로 총합을 구해보세요(ROLLUP 사용)SELECT prodName ,SUM(price*aOM 
select prodname,sum(price*amount) from buytbl group by prodname with rollup;
select num,prodname,sum(price*amount) from buytbl group by prodname,num with rollup;







