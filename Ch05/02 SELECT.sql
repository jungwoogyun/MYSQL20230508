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













