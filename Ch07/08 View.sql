-- ---------------------------
-- View
-- ---------------------------
-- Select 의 조회 결과를 반복적으로 사용해야 할때 마치 테이블처럼 사용하도록 문법
-- 가상테이블

use shopdb;
select * from usertbl;
select * from buytbl;

create or replace view view_usertbl
as
select *,concat(mobile1,'-',mobile2) as phone 
from usertbl 
where addr in ('서울','경기','경남');

select * from view_usertbl;
select * from view_usertbl where height >=175;
-- 확인
show tables;
select * from information_schema.views where table_schema='shopdb';

create or replace view view_user_buytbl
as
select usertbl.userid,name,addr,sum(price*amount) as TotalPay
from usertbl 
inner join buytbl
on usertbl.userid=buytbl.userid
group by usertbl.userid
;

select * from view_user_buytbl;

select * from view_user_buytbl where TotalPay>=100;



-- 문제

use classicmodels;
create or replace view view_Test
as
select *
from customers C
inner join employees E
on E.employeeNumber=C.salesRepEmployeeNumber
inner join payments P
on C.customerNumber = P.customerNumber
inner join offices O
on E.officeCode = O.officeCode;



