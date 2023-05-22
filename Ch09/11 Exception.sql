-- 예외발생
use shopdb;
select * from usertbl; 
select * from notable;
select * from buytbl;

-- 01,02
delimiter $$
create procedure Exception_Test02()
begin
	declare continue handler for 1146 select '해당 테이블이 없어요..' as 'Error_msg';
   	declare continue handler for 1136 select 'Insert시 value의 column이 다릅니다..' as 'Error_msg';

	select * from usertbl; 
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끝';
end $$
delimiter ;

call Exception_Test02();


show errors;
-- 03 모든 예외 받기..
delimiter $$
create procedure Exception_Test03()
begin
	declare continue handler for SQLEXCEPTION select '예외가 발생했어요..' as 'Error_msg';

	select * from usertbl; 
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끝';
end $$
delimiter ;

call Exception_Test03();


-- 04 예외코드 확인
drop procedure Exception_Test04;
delimiter $$
create procedure Exception_Test04()
begin
	declare continue handler for SQLEXCEPTION 
    begin
		show errors;
    end;

	select * from usertbl; 
	select * from notable;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끝';
end $$
delimiter ;
call Exception_Test04();


-- 05 Error_log 기록하는 테이블처리

create table tbl_std (id varchar(20) primary key, name char(10) , age int );
create table tbl_std_errlog(error_date date , error_code int ,error_msg text);
show errors;

delimiter $$
drop procedure tbl_std_proc;
create procedure tbl_std_proc(in id varchar(20),in name char(10),in age int)
begin 
	insert into tbl_std values(id,name,age);
    select * from tbl_std;
end $$
delimiter ;

call tbl_std_proc('aa','홍길동',10);
call tbl_std_proc('ab','남길동',20);




