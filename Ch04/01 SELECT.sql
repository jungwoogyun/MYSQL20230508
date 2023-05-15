-- 01 Select 
use shopdb;
select * from usertbl;
select userId,addr from usertbl;
select userId as '아이디',addr as '주소' from usertbl;

-- 02 Select where 비교연산자
select * from  usertbl where name='김경호';
select * from usertbl where userId='LSG';
select * from usertbl where birthyear>=1900;
select * from usertbl where height <=170;

-- 03 Select where 논리연산자(or,and)
-- 조건식 and 조건식	: 왼쪽/오른쪽 조건식 둘다 참인경우 
-- 조건식 or 조건식	: 왼쪽/오른쪽 둘중 하나라도 참인경우
select * from usertbl where birthyear>=1900 and height>=182;
select * from usertbl where birthyear>=1900 or height>=182;
-- 1910 <= birthYear <=1970
select * from usertbl where birthyear>=1910 and birthyear<=1970;
 select * from usertbl where birthyear between 1910 and 1970;
 
 -- 04 In , Like
 select * from usertbl;
 select * from usertbl where addr in('서울','경남');
 select * from usertbl where name like '김%'; -- 첫문자가 '김'인 모든 문자(길이제한x)
 select * from usertbl where name like '김__'; -- 첫문자가 '김'인 모든 문자(_만큼의길이제한)
 select * from usertbl where name like '%수'; -- 끝문자가 '김'인 모든 문자(길이제한x)
 select * from usertbl where name like '__수'; -- 끝문자가 '김'인 모든 문자(_만큼의길이제한)
 select * from usertbl where name like '%경%'; -- 경을 포함하는 모든 문자
 
 
-- 문제
--  1 구매양(amount)가 5개 이상인 행을 출력
select * from buytbl where amount=5;
--  2 가격이(price) 50 이상 500 이하인 행의 UserID와 prodName 만 출력
select userid,prodname from buytbl where price>=50 and price<=500;
select userid,prodname from buytbl where  price between 50 and 500;
--  3 구매양(amount)이 10 이상 이거나 가격이 100 이상인 행 출력
select * from buytbl where amount >=10 or price>=100;
--  4 UserID 가 K로 시작하는 행 출력
select * from buytbl where userid like 'k%';
--  5 ‘서적’ 이거나 ‘전자’ 인 행 출력
select * from buytbl where groupname in ('서적','전자');
--  6 상품(prodName)이 책이거나 userID가 W로 끝나는 행출력
select * from buytbl where prodname='책' or userid like '%w';
 -- 7 groupname이 비어있지 않는 행만 출력 (!= , <>)
 select * from buytbl where groupname!='null';
 
 
 -- 05 서브쿼리 
 -- 김경호보다 큰키를 가지는 모든열의 값
 select height from usertbl where name='김경호';
 select * from usertbl where height>(select height from usertbl where name='김경호');
 
 -- 성시경보다 나이가(birthYear) 많은 모든 값 출력
 select birthyear from usertbl where name='성시경';
 select * from usertbl where birthyear < (select birthyear from usertbl where name='성시경');
 
 -- 지역이 '경남'인 height 보다 큰 행 출력
 select height from usertbl where addr='경남'; -- 173,170
 
 select * from usertbl where height > any(select height from usertbl where addr='경남');
 select * from usertbl where height > all(select height from usertbl where addr='경남');
 
 
 
-- 1 amount가 10인 행의 price보다 큰 행을 출력하세요(서브쿼리)

select * from buytbl where price >(select price from buytbl where amount=10);
-- 2 userID 가 K로 시작하는 행의 amount 보다 큰 행을 출력하세요(서브쿼리 + ANY)
select * from buytbl where amount >any(select amount from buytbl where userid like 'k%');

-- 3 amount 가 5인 행의 price보다 큰 행을 출력하세요(서브쿼리 + ALL)
select * from buytbl where price>all(select price from buytbl where amount=5);
 
 
 -- 06 order by
 select * from usertbl order by mDate;
 select * from usertbl  where birthYear>=1970 order by mDate asc;
 
 select * from usertbl  where birthYear>=1970 order by mDate desc;
 
 select * from usertbl order by height,name asc;
 
 -- 07 distinct
 select distinct addr from usertbl;
 
 -- 08 limit 
  select * from usertbl;
 select * from usertbl limit 3; -- 0 idx부터  - 3라인까지 표시
 select * from usertbl limit 2,3;
 
 
 -- 09 테이블복사
 -- 1) 구조 + 값 복사(PK,FK 복사 x)
 create table tbl_buy_copy(select * from buytbl);
 select * from buytbl;
 select * from tbl_buy_copy;
 desc buytbl;
 desc tbl_buy_copy;
 
create table tbl_buy_copy2(select userid,prodname from buytbl);
select * from tbl_buy_copy2;
 
 -- 2) 구조만 복사(PK,FK 복사 o)
 drop table tbl_buy_copy3;
create table tbl_buy_copy3 like buytbl;
desc tbl_buy_copy3;
select * from tbl_buy_copy3;
 
 -- 3) 데이터만 복사
 insert into tbl_buy_copy3 select * from buytbl where amount>=2;
select * from tbl_buy_copy3;
 
 
 -- 문제
-- 1 userId 순으로 오름차순 정렬
select * from buytbl order by userid;
-- 2 price 순으로 내림차순 정렬
select * from buytbl order by price desc;
-- 3 amount 순으로 오름차순 prodName으로 내림차순정렬
select * from buytbl order by amount,prodname desc;
-- 4 prodName을 오름차순으로 정렬시 중복 제거
select distinct prodName from buytbl order by prodname;
-- 5 userID열의 검색시 중복된 아이디제거하고 select
select distinct userid from buytbl;
-- 6 구매양(amount)가 3이상인 행을 prodName 내림차순으로정렬
select * from buytbl where amount>=3 order by prodname desc;
-- 7 usertbl의 addr 가 서울,경기인 값들을 CUsertbl에 복사
create table cusertbl(select * from usertbl where addr in ('서울','경기'));
select * from cusertbl;


 
 
 
 
 
 
 
 
 
 
 
 
 
