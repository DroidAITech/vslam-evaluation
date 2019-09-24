# Ubuntu16.04 evo的安装与使用教程

### 安装步骤

##### 1.安装&&升级numpy

```
sudo pip install numpy -I
```

##### 2.检查user权限

```
sudo pip install . --user --upgrade
```

##### 3.pip安装evo

```
pip install . --upgrade --no-binary evo
```