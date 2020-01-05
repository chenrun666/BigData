# anaconda 安装流程与基本使用

## 安装教程

[传送门](https://www.jianshu.com/p/f18adb00b730)

### 基本使用

#### 创建环境

```bash
conda create -n data python=3.7
```

#### 激活环境

```bash
conda activate data
```

#### 查看所有的环境

```bash
conda env list
```

#### 安装第三方包

```bash
conda install requests
```

#### 卸载第三方包

```bash
conda remove requests
```

or

```bash
conda uninstall requests
```
