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
        {"name" : "동길동" , "age" : 33 , "addr" : "인천"}
    ]
}';

select @Json_Data3;
select json_search(@Json_Data3,'one','길동');


