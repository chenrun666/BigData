## <center>函数和索引</center>

### mysql常用函数

- 字符串函数
- 数值函数
- 系统函数

#### 字符串函数

##### 字符串合并 concat，concat_ws

concat(s1, s2..., sn) 将多个字符串合并起来

```sql
select concat("summy ", " is", " a", " teacher") as `desc`;
```

可接受不同类型

```sql
select concat(curdate(), "-", 12.34)
```

concat_ws(sep, s1, ...sn): 用分隔符拼接字符串

```sql
select concat_ws(" ", "sunny", "is", "a", "teacher") as `desc`;
```

##### 字符串比较 strcmp

strcmp(str1, str2): 如果str1大于str2返回结果1， 如果str1小于str2返回-1， str1等于str2返回0

```sql
select strcmp("abc", "bcd");
```

##### 字符串长度 length, char_length

显示英文个数

```sql
length(str)
```

正确显示中文个数

```sql
length("中文个数")
```

##### 大小写转换 lower，upper

```sql
select "sunny", upper("sunny")
```

```sql
select "SUNNY", lower("SUNNY")
```

##### 字符串查找

```sql
select FIND_IN_SET("sunny", "kai ke ba, python, teacher,sunny");
```

上述 查找结果为4

```sql
select field("sunny", "kai ke ba", "python", "teacher", "sunny")
```

上述 查找结果为4

```sql
select locate("unny", "sunny"), position("unny" in "sunny")
```

上述 查找结果为2， 2

##### 字符串截取子串

```sql
select left("sunny", 2)
```

上述 结果: su

```sql
select right("sunny", 2)
```

上述 结果: ny

```sql
select substring("sunny", 2, 2)
```

上述 结果: un

##### 去掉字符串首尾的空格

去掉开始空格

```sql
select concat("-", ltrim(" sunny"), "-")
```

去除结尾的空格

```sql
select concat("-", "sunny ", "-")
```

去掉首位空格

```sql
select concat("-", trim(" sunny "), "-")
```

##### 替换字符串

insert

```sql
select insert("这是mysql数据库", 3, 5, "oracle")
```

replace

```sql
select replace("这是mysql数据库", "mysql", "oracle")
```

#### 数值函数

##### 随机数

rand() 返回0-1之间的随机数

```sql
select rand(), rand()
```

###### 获取整数

ceil(x)

```sql
select ceil(4.3)
```

floor(x)

```sql
select floor(4.3)
```

##### 截取数值

truncate(x, y) 

```sql
-- 返回x保留到小数点后y位的值
select truncate(101.123123, 2)
```

##### 四舍五入

round(x)

```sql
select round(101.23456, 2)
```

#### 时间和日期函数

##### 获取当前时间

```sql
curdate()
```

年月日

##### 获取当前时间

```sql
curtime()
```

时分秒

##### 获取当前日期和时间

```sql
now()
```

年月日 时分秒

##### 返回日期为某一年中的第几周

```sql
week(date)
```

##### 返回time的小时值, 分钟值

```sql
hour(time)
```

```sql
minute(time)
```

##### 返回日期的月份名称

```sql
monthname(date)
```

#### 系统信息函数

版本，数据库，用户

```sql
select version(), database(), user()
```

### 索引的基本使用

#### 创建，查看索引

普通索引 index: 加速查找

唯一索引: 主键索引PRIMARY KEY 加速查找+约束 UNIQUE 加速查找+约束(不能重复)

联合索引: PRIMARY KEY(id, name): 联合主键索引 UNIQUE(id, name) 联合唯一索引 INDEX(id, name) 联合普通索引

##### 创建普通索引

```sql
create table name(
    field1 类型,
    field2 类型,
    ...
    fieldn 类型
    index|key [索引名](field1, [(长度)] [asc|desc])
);
```

案例

```sql
create table dept2(
    deptno int,
    name varchar(20),
    loc varchar(40),
    index index_deptno(deptno)
)
```

查看是否使用索引

```sql
explain select * from dept2 where deptno=1;
```

possible_keys和key字段的值都是创建的索引则说明索引已经存在而且使用

在已经存在的字段上建立索引

```sql
create index 索引名 on 表明 (属性名 [(长度)] [asc|desc]);
```

```sql
create index index_deptno on dept2(deptno);
```

通过alter来创建索引

```sql
alter table table_name add index|key 索引名(属性 [(长度)] [asc|desc]);
```

```sql
alter table dept2 add index index_deptno(deptno);
```

##### 创建唯一索引

```sql
create table table_name(
    field1 field_type,
    ...
    unique index|key [索引名] (属性名 [(长度)] [asc|desc]);
)
```

```sql
create table dept2(
    deptno int,
    name varchar(20),
    loc varchar(40),
    unique index index_deptno(deptno)
)
```

已有的表上建索引

```sql
create unique index index_deptno on dept2(deptno);
```

alter 添加索引

```sql
alter table dept2 add unique index index_deptno(deptno)
```

##### 创建全文索引

```sql
create table table_name(
    field field_type,
    ...
    funlltext index|key [索引名 (属性名 [(长度)] [asc|desc])]
)
```

全文索引主要关联在数据类型在char，varchar，和text的字段上，以便能够快速的查询数据量比较大的字符串类型的字段

##### 多列索引

多列索引是指创建索引的字段不是一个字段，而是多个字段，虽然可以通过关联的字段进行查询，但是只有查询条件中使用了所关联的字段中的第一个字段，多列索引才会被使用

```sql
create table name(
    field field_type,
    ...
    index|key [索引名 (属性名 [(长度)] [asc|desc], field2, [(长度)] [asc|desc])]
)
```

```sql
create table dept2(
    deptno int,
    name varchar(20),
    loc varchar(40),
    index index_name_loc(name, loc)
)
```

已经存在的表上创建索引

```sql
create index index_name_loc on dept2(name, loc);
```

```sql
alter table dept2 add index index_name_loc(name, loc)
```

##### 删除索引

```sql
drop index index_name on table_name;
```

```sql
drop index index_dept on dept2;
```

### 视图

#### 新建视图

```sql
create view view_name as 查询语句
```

视图名不能和表明，其他视图名重名，视图实际上就是封装了复杂的查询语句

```sql
create view v_employee as select no, name, job, mgr, hiredate, comm, deptno from employee;
```