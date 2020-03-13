# 认识Hadoop

- 1 Hadoop的核心组件: HDFS, MapReduce, Yarn
- 2 Hadoop通常指的是Hadoop生态圈
- 3 Hadoop是云计算的PaaS层的解决方案之一，并不等同与PaaS
- 4 Hadoop用于数据服务基础平台建设，用于用户画像，网站点击流日志数据挖掘

## Hadoop生态圈

## Hadoop的组成

### HDFS: 块级别的分布式文件存储系统

### MapReduce: 分布式计算框架

### Yarn: 分布式资源管理器

## Hadoop的shell操作

### 1 启动/关闭Hadoop集群

```bash
start-all.sh

stop-all.sh
```

### 2 查看HDFS上的文件和目录

```bash
hadoop fs -ls -R /
```

### 3 在HDFS上的创建文件夹

```bash
hadoop fs -mkdir -p /test/kkb
```

### 4 上传文件

```bash
hadoop fs -put [source](本地文件路径) [dest](HDFS路径)
```

### 5 下载文件

```bash
hadoop fs -get [source](HDFS路径) [dest](本地文件路径) 
```

### 6 删除文件

```bash
hadoop fs -rm HDFS文件路径

hadoop fs - rm -r HDFS目录路径
```

### 7 查看文件内容

```bash
hadoop fs -cat HDFS文件路径
```

### 8 查看集群的工作状态

```bash
hdfs dfsadmin -report
```

