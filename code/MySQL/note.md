# 数据库基础

## 数据库基本操作

### 新建数据库

```sql
create database name;
```

### 查询和选择数据库

```sql
show databases;  # 查看所有数据库

use name;  # 进入数据库
```

### 删除数据库

```sql
drop database name;
```

### 新建数据库指明编码 （不指明编码会使用系统的默认编码）

```sql
create database kaikeba charset utf8mb4 collate utf8mb4_general_ci;

show create database kaikeba;
```

### mysql 数据类型

|整数类型|字节|最小值|最大值
-|-|-|-
|TINYINT|1|有符号-128</br>无符号0|有符号127</br>无符号255
|SMALLINT|2|有符号-32768</br>无符号0|有符号32767</br>无符号65535
|MEDIUMINT|3|有符号-8388608</br>无符号0|有符号8388607</br>无符号16777215
|INT和INTEGER|4|有符号-(2\*\*32 / 2)</br>无符号0|有符号2\*\*32 - 1</br>无符号2\*\*32 - 1
|BIGINT|8|略|略

|浮点数类型|字节|
-|-|
FLOAT|4
DOUBLE|8

**选择存储小数类型，可以选择float或者double，具体选择哪一种，需要判断小数需要精确到小数点后多少位，如果超过10位选择double，其余选择float**

|日期和时间类型|字节
-|-
DATE|4
DATETIME|8
TIMESTAMP|4
TIMESTAMP|4
TIME|3
YEAR|1

- 1 . 表示年月日。比如生日使用DATE类型 
- 2 . 表示年月日时分秒，比如用户注册时间，使用DATETIME类型
- 3 . 需要经常插入或者更新日期为当前系统时间，使用TIMESTAMP
- 4 . 如果只需要时分秒，一般使用TIME类型， 比如跑步记时
- 5 . 如果需要年份 可以使用YEAR
- 6 . 如果系统是一个全球化的系统。不同的时间需要不同的地方显示当地的时间则需要TIMESTAMP类型

|CHAR系列字符串类型|字节|描述
-|-|-
CHAR(M)|M|M为0-255之间的整数
VARCHAR(M)|M|M为0-65535之间的整数

|TEXT系列字符串类型|字节
-|-
TINYTEXT|0-255
TEXT|0-65535
MEDIUMTEXT|0-167772150
LONGTEXT|0-4294967295

## 表的基本操作

### 新建表和删除表

```sql
create table name (列名 数据类型, 列明n 数据类型);
```

```sql
1.1
use kaikeba;
1.2 建表
create table user (name varchar(4), age int, birthday datatime);
1.3 查看所有的表
show tables;
1.4 查看建表语句
show create table user;
1.5 以表格方式查看表
describe user;
或
desc user;
1.6 删除表
drop table user;
```

### 列属性

> NULL / NOT NULL, default, primary key, unique key, auto_increment, comment

```sql
create table user(name varchar(4) not null, age int, birthday datetime);
```

### 列描述

> comment,没有实际含义，专门用来描述字段，会根据表创建语句保存。用来给数据管理员进行了解的。

> ```sql
> create table user(name varchar(4) not null comment "名字", age int, birthday datetime);
> ```

### 默认值

> ```sql
> create table user(name varchar(4) not null comment "名字", age int default 18, birthday datetime);
> ```

### 主键

> ```sql
> create table user(
>   id int primary key comment "用户ID",
>   name varchar(4) not null comment "名字",
>   age int default 18,
>   birthday datetime
> )
> ```

优点：非常简单

缺点：只能使用一个字段作为主键

> ```sql
> create table userFavorite(
>   user_id int comment "用户ID",
>   article_id int comment "文章ID",
>   add_time datetime comment "收藏时间",
>   primary key(user_id, article_id)    
> )
> ```

表创建好之后追加主键

> ```sql
> create table userFavorite(
>   user_id int comment "用户ID",
>   article_id int comment "文章ID",
>   add_time datetime comment "收藏时间"  
> )
> ```

> ```sql
> alter table userFavotire add primary key(user_id, article_id);
> ```

删除主键

```sql
alter table name drop primary key;
```

### 唯一值

> ```sql
> create table user(
>   id int unique comment "用户ID",
>   name varchar(4) not null comment "名字",
>   age int default 18,
>   birthday datetime
> )
> ```

> ```sql
> create table userFavorite(
>   user_id int comment "用户ID",
>   article_id int comment "文章ID",
>   add_time datetime comment "收藏时间",
>   unique key(user_id, article_id)
> )
> ```

> ```sql
> alter table userFavorite add unique key(user_id)
> ```

### 自增

> ```sql
> create table user(
>   id int primary key auto_increment comment "用户ID",
>   name varchar(4) not null comment "名字",
>   age int default 18,
>   birthday datetime
> )
> ```

修改自增长

> ```sql
> alter table user CHANGE COLUMN id id int auto_increment;
> ```

删除自增长

> ```sql
> alter table user modity id int;
> ```

### 建表指明编码

> ```sql
> create table user(
>   id int unique comment "用户ID",
>   name varchar(4) not null comment "名字",
>   age int default 19,
>   birthday datetime
> ) charset=utf8;
> ```


克隆列一张表结构

> ```sql
> create table user2 like user;
> ````

## 修改表

### 修改表名

> ```sql
> alter table `user` rename `user3`
> ```

### 增加列

> ```sql
> alter table user3 add mobile varchar(11) first;
> ```

### 删除列

> ```sql
> alter table user3 drop mobile;
> ```

### 修改列

修改列类型

> ```sql
> alter table user3 modify age varchar(11);
> ```

修改列名

> ```sql
> alter table user3 change id new_id int;
> ```

## 更新数据

### 更新特定数据

> ```sql
> update table_name set field1=value1, field2=value2 where condition;
> ```

> ```sql
> update user set name="sunny" where id=3;
> ```

### 跟新所有数据

> ```sql
> update user set name="sunny_all";
> ```

## 删除记录

### 删除指定数据

> ```sql
> delete from table_name where condition
> ```

> ```sql
> delete from user where id=2
> ```

### 删除所有数据

> ```sql
> delete from user;
> ```