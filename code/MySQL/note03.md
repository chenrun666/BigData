## <center>多表查询</center>

### 创建表

建表的时候指明外键

```sql
create table employee(
    no int comment "员工编号",
    name varchar(20) comment "姓名",
    job varchar(40) comment "工作",
    mgr int comment "上司ID",
    hiredate date comment "雇佣时间",
    sal double(10, 2) comment "工资",
    comm double(10, 2) comment "奖金",
    deptno int comment "部门ID",
    constraint 'fk' foreign key(`deptno`) references dept(`deptno`) on delect set null on update set null
) charset=utf8mb4
```

添加外键关联

```sql
alter table employee add constraint `fkdd` foreign key(`deptno`) references dept(`deptno`) on delete set null on update set null;
```

### 数据准备

新建部门表

```sql
create table dept(
    deptno int comment "部门编号",
    name varchar(20) comment "部门名称",
    loc varchar(40) comment "所在城市"
);
```

插入数据

```sql
insert into dept values
(10, "accounting", "new_york"),
(20, "research", "dalas"),
(30, "sales", "beijing"),
(40, "financial", "shanghai")
```

使用union all 的注意事项


第一个select语句的字段名称被用作最后结果的字段名
在联合查询中， 当使用order by的时候，需要对select语句添加括号，并且与limit结合使用才生效

### 内连接

表的链接分为：
- 1,内连接(inner join)
- 2,外连接(outter join)
- 3,自然连接
- 4,全连接
- 5,union

#### 内连接

```sql
select field1, ... fieldn from table1 inner join table2 [inner join tablen] on join_condition
```

inner 可以省略

加on语句

```sql
select * from employee join dept on employee.deptno=dept.deptno;
```

使用using简化上述用法

```sql
select * from employee join dept using(deptno);
```

#### 外连接

```sql
select field1, ...fieldn from table [left|right] [outer] join table2 on join_condition;
```



### 子查询

查询比smith工资高的员工信息

```sql
select * from employee where sal > (select sal from employee where name='smith')
```

查询和smith工作薪资一样的员工信息

```sql
select name, sal, job from employee where (sal, job) = (select sal, job from employee where name='smith')
```

in 关键字

any 关键字
- =any 和in一样
- \>any 大于其中任意一个
- <any 小于其中任意一个

all 关键字

- \>all 大于所有
- <all 小于所有