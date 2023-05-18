use shopdb;

select json_object('name','홍길동','height',182) as 'JSON Data';

set @var=10;
select @var;

set @Json_Data = json_object('name','홍길동','height',182);
select @Json_Data;

set @Json_Data2 = '{"name":"홍길동","height":182}';
select @Json_Data2;

set @Json_Data3='{
	"userInfo" :
	[
		{"name" : "홍길동" , "age" : 55 , "addr" : "대구"},
        {"name" : "남길동" , "age" : 22 , "addr" : "울산"},
        {"name" : "홍길동" , "age" : 33 , "addr" : "인천"}
    ]
}';

select @Json_Data3;
select json_valid(@Json_Data3);
select json_search(@Json_Data3,'one','홍길동');
select json_extract(@Json_Data3,'$.userInfo[2].name');
select json_insert(@Json_Data3,'$.userInfo[1].mData','2023-05-18');
select @Json_Data3;
set @Json_Data3 = json_insert(@Json_Data3,'$.userInfo[1].mData','2023-05-18');
select @Json_Data3;

select json_replace(@Json_Data3,'$.userInfo[1].name','이태수');
select json_remove(@Json_Data3,'$.userInfo[0]');

-- 테이블 생성

create table tbl_Json
(
	id int primary key,
    json_data json not null
);
desc tbl_Json;

insert into tbl_Json values(1,@Json_Data3);
select * from tbl_Json;

select json_valid(json_data) from tbl_Json;
select json_search(json_data,'one','홍길동') from tbl_Json;
select json_extract(json_data,'$.userInfo[2].name') from tbl_Json;
select json_insert(json_data,'$.userInfo[1].mData','2023-05-18') from tbl_Json;
update tbl_Json 
set json_data=json_insert(json_data,'$.userInfo[1].mData','2023-05-18') 
where id=1;
select * from tbl_Json;

insert into tbl_Json values(2,'{"name":"정우균","age":"38","addr":"대구"}');
select * from tbl_Json;
select json_search(json_data,'one','정우균') from tbl_Json where id=2;

delete from tbl_Json where id=3;
insert into tbl_Json values(3,json_object(
"name","아무무",
"age",555,
"addr","LOL"
));
select * from tbl_Json;

insert into tbl_Json values(4,json_object(
"name","티모",
"age",111,
"addr","LOL",
"skill",json_array('Q-실명','W-몰라','E-','R')
));
select * from tbl_Json;
select json_data from tbl_Json where id=4;
select json_search(json_data,'one',"Q-실명") from tbl_Json;
select json_extract(json_data,'$.skill[0]') from tbl_Json;

