-- 学生表
CREATE TABLE Student
(
    Sid varchar(10),
    Sname varchar(10),
    Sage datetime,
    Sgender varchar(10)
);

-- 课程表
CREATE TABLE Course 
(
    Cid varchar(10),
    Cname varchar(10),
    Tid varchar(10)
);

-- 老师表
CREATE TABLE Teacher
(
    Tid varchar(10),
    Tname varchar(10)
);

-- 成绩表
CREATE TABLE SC
(
    Sid varchar(10),
    Cid varchar(10),
    score float
);

