use shopdb;

-- 01 기본 프로시저
delimiter $$
create procedure proc1()
begin
	-- 변수 선언
    declare var1 int;
    set var1 = 100;
    if var1=100 then
		select 'var1 은 100입니다.';
	else
		select 'var1 은 100이 아닙니다.';
    end if;
end $$
delimiter ;
show procedure status;
show create procedure proc1;
call proc1();

-- 02 프로시저(Argument - Parameter)
delimiter $$
create procedure proc2( IN param int)
begin

    if param=100 then
		select 'param 은 100입니다.';
	else
		select 'param 은 100이 아닙니다.';
    end if;
end $$
delimiter ;
call proc2(5);

-- 03 프로시저 (테이블에 적용)
delimiter $$
create procedure proc3( IN amt int)
begin
	select * from buytbl where amount >=amt; 
end $$
delimiter ;

call proc3(3);


-- 04 프로시저 테이블에적용(if)
delimiter $$
create procedure proc4()
begin
	declare avg_amount int;
    set avg_amount=(select avg(amount) from buytbl);
    
	select * ,if(amount>=avg_amount,'평균이상','평균이하') as '구매량평균' from buytbl; 
end $$
delimiter ;

call proc4();


-- 문제
-- usertbl에서 출생년도를 입력받아 해당 출생년도보다 나이가 많은 행만 출력
-- birthyear열을 이용
-- 프로시저명 : older( IN param int)
delimiter $$
create procedure older( in birth int)
begin
	select * from usertbl where birthyear <birth;
end $$
delimiter ;

call older(1980);

-- 06 근태일 , 가입일로부터 지난일 구하기

-- 가입일로부터 지난날짜 확인
select curdate(); -- 현재 날짜(YYYY-MM-DD)
select now();	 -- 현재 날짜시간
select curtime();	-- 현재 시간
select *,ceil(datediff(curdate(),mDate)/365) from usertbl;
-- 가입한지 12년이 초과한 user는 삭제 
select *, if(ceil(datediff(curdate(),mDate)/365)>12,'삭제','유지') from usertbl;

create table c_usertbl(select * from usertbl);
select * from c_usertbl;

delimiter $$
create procedure delete_user( in del int)
begin
	select *  from c_usertbl where ceil(datediff(curdate(),mDate)/365)>del;
	delete from c_usertbl where ceil(datediff(curdate(),mDate)/365) > del;
end $$
delimiter ;

call delete_user(12);
select * from c_usertbl;

select mdate,year(mdate),month(mdate),day(mdate) from usertbl;

select mdate,birthyear,year(curdate()) from usertbl;
select mdate,year(curdate())-birthyear from usertbl;

select * from usertbl;

-- 0000년을 기준으로 현재 까지의 일수
select to_days(curdate());

-- 만 나이 계산 ('YYYY-MM-DD')
select *, DATE(CONCAT(birthyear, '-01-01')) from usertbl; 
select *,to_days( DATE(CONCAT(birthyear, '-01-01')) ) from usertbl;

select *,((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) from usertbl;
select *,
ceil((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) as '나이(만)' 
from usertbl;


