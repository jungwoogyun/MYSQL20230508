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
 
 
