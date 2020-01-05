# Jupyter 环境配置

## 安装jupyter

### conda 安装

```bash
conda install jupyter notebook
```

### pip 安装

```bash
pip install --upgrade pip
```

```bash
pip install jupyter
```

## Jupyter配置文件设置

### 寻找配置文件路径

- 1

```bash
jupyter notebook --generate-config
```

- 2
找到文件jupyter_notebook_config.py

```python
c.NotebookApp.notebook_dir = ""  # 默认打开的文件路径

```

## Jupyter 插件安装

```bash
conda install -c conda-forge jupyter_contrib_nbextensions
```

```bash
conda install -c conda-forge jupyter_nbextensions_configurator
```
