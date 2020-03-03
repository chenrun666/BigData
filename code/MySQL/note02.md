## 查询数据-单表

### 数据准备

创建表

```sql
create table employee( 
    no int comment "员工编号", 
    name varchar(20) comment "姓名", 
    job varchar(40) comment "职位", 
    mgr int comment "上司id", 
    hiredate date comment "雇佣时间", 
    sal double(10, 2) comment "工资", 
    comm double(10, 2) comment "奖金", 
    deptno int comment "部分id" 
) charset=utf8;

```

插入数据

```sql
insert into employee values 
    (7369, "smith", "clerk", 7902, "1981-03-12", 800.00, NULL, 20), 
    (7499, "allen", "salesman", 7698, "1982-03-12", 1600.00, 300.00, 30), 
    (7521, "ward", "salesman", 7698, "1983-03-12", 1250.00, 500.00, 30), 
    (7566, "jones", "manager", 7839, "1981-03-12", 2975.00, NULL, 20), 
    (7654, "martin", "salesman", 7698, "1981-03-12", 1250.00, 1400.00, 30), 
    (7698, "blake", "manager", 7839, "1981-03-12", 2850.00, NULL, 30), 
    (7782, "clark", "manager", 7839, "1985-03-12", 2450.00, NULL, 10), 
    (7788, "scott", "analyst", 7566, "1981-03-12", 3000.00, NULL, 20), 
    (7839, "king", "president", NULL, "1981-03-12", 5000.00, NULL, 10), 
    (7844, "turner", "salesman", 7698, "1989-03-12", 1500.00, 0.00, 30), 
    (7876, "adams", "clerk", 7788, "1998-03-12", 1100.00, NULL, 20), 
    (7900, "james", "clerk", 7698, "1997-03-12", 950.00, NULL, 30), 
    (7902, "ford", "analyst", 7566, "1998-10-10", 3000.00, NULL, 20), 
    (7934, "miller", "clerk", 7782, "1981-03-12", 1300.00, NULL, 10);
```

### 简单记录查询

```sql
select field1, field2 from table_name;
```

查询所有字段

```sql
select * from employee;
```

避免重复数据查询 - distinct

```sql
select distinct job from employee;
```

|运算符|描述|
-|-|-
+|加法
-|减法
\*|乘法
/(DIV)|除法
%(MOD)|求余

### 包含数学运算的查询

一年的薪资

```sql
select name, sal * 12 from employee;
```

as 的用法

```sql
select name as "姓名", sal * 12 as "年薪" from employee;
```

格式化显示

```sql
select concat(name, "的年薪为:", sal * 12) as "薪资" from employee;
```

### 条件记录查询

|运算符|描述|
-|-
\>|大于
<|小于
=|等于
!=(<>)|不等于
\>=|大于等于
<=|小于等于

逻辑运算符

|运算符|描述|
-|-
AND(&&)|逻辑与
OR(\|\|)|逻辑或
XOR|逻辑异或
NOT(!)|逻辑非

单条件查询

```sql
select name from employee where job="clerk";
```

多条件查询

```sql
select name, job from employee where job="clerk" and sal > 800;
```

带between and 关键字的条件查询

```sql
select name, sal from employee where sal between 1000 and 2000;
```

or 

```sql
select name, sal from employee where sal >= 1000 and sal <=2000;
```

带is null 的条件查询

```sql
select name, comm from employee where comm is not null;
```

带 in 的条件查询

```sql
select name, job from employee where job in ("salesman", "clerk");
```

带 like 的关键字查询

- "_"表示匹配单个字符
- "%"表示可以匹配任意长度的字符串，即可以是0个可以是1个，可以是多个

```sql
select name from employee where name like "A%";
```

### 排序记录查询

```sql
select * from table_name condition order by field1 [asc|desc];
```

asc: 升序
desc: 降序
默认升序

```sql
select name, sal from employee order by sal asc;
```

多字段排序

```sql
select name, sal from employee order by sal asc, hiredate desc;
```

### 限制记录查询

```sql
select field1, field2 from table_name where condition limit offset_start, row_count;
```

这个在数据分页中很常见

```sql
select * from employee where comm is null limit 2;
```

```sql
select * from employee where comm is null limit 2, 2;
```

### 统计函数

- count(): 统计表中记录的条数
- avg(): 计算字段的平均值
- sum(): 计算字段的总和
- max(): 字段值的最大值
- min(): 字段的最小值

#### count

count(*): 统计所有记录，不管是null值还是非null值
count(field): 可以指定字段进行统计，统计时候将忽略null值

```sql
select count(*) from employee;
```

统计奖金的人数

```sql
select count(comm) from employee;

select count(*) from employee where comm is null;  # null 只能通过is null 判断
```

#### avg

```sql
select avg(comm) from employee;
```

avg 会忽略该字段为null的记录

#### sum

```sql
select sum(sal) from employee;
```
也会忽略null的记录

#### max

```sql
select max(sal) from employee;
```

#### min

```sql
select min(sal) from employee;
```

注意事项：
如果没有记录， count 返回是0， 其他函数返回的是null


### 分组记录查询

```sql
select function() from table_name where condition group by field;
```

简单分组

查询所有人的平均工资

```sql
select avg(sal) from employee;
```

查询文员的平均工资

```sql
select avg(sal) from employee where job='clerk';
```

查询销售的平均工资

```sql
select avg(sal) from employee where job='salesman';
```

让mysql按照工种分组

```sql
select job, avg(sal) from employee group by job;
```

分组之后不能显示其他的列

查看sql_mode

```sql
show variables like 'sql_mode';
```

结果中包含了 ONLY_FULL_GROUP_BY， 将其去掉之后便可以显示其他列

显示其他列 group_concat

```sql
select job, group_concat(name), avg(sal) from employee group by job;
```

显示各部门的分组

```sql
select deptno, group_concat(name, ":", sal) names from employee group by deptno;
```

显示各部门雇员的个数

```sql
select deptno, group_concat(name) names, count(name) as nums from employee group by deptno;
```
#### 实现多个字段分组查询

对员工分组： 先按照部门进行分组，然后按照雇佣日期进行分组

```sql
select deptno, hiredate from employee group by deptno, hiredate;
```

```sql
select deptno, hiredate, group_concat(name) names, count(name) from employee group by deptno, hiredate;
```

#### 分组加条件

获取工种平均工资大于2000元的

```sql
select job, avg(sal) from employee group by job having avg(sal) > 2000;
```

