# LSD算法安装、测试、运行仓库

### 包含内容
- LSD算法理论文档
- LSD部署教程
- lsd安装及bug说明
- LSD部署到Xbot仿真平台教程
- LSD代码包lsd_slam.zip
- 部署LSD+Xbot脚本Install_LSD+Xbot.sh
## 启动Xbot+LSD

### 环境

* Ubuntu 16.04
* bro2018fall-codes
* LSD工作空间（catkin_lsdws）
* 仿真xbot自带摄像头

### 操作步骤

打开仿真环境:

```
cd catkin_ws/ # catkin_ws为Xbot仿真环境的工作空间
source devel/setup.bash
roslaunch robot_sim_demo robot_spawn.launch
```
再开一个终端

```
cd catkin_lsdws #catkin_lsdws为LSD工作空间
source devel/setup.bash
roslaunch lsd_slam_viewer lsd+Xbot.launch
```
再开一个终端

```
cd catkin_ws/ #catkin_ws为Xbot仿真环境的工作空间
source devel/setup.bash
rosrun robot_sim_demo robot_keyboard_teleop.py #启动键盘控制程序
```
控制Xbot移动并建图

![image](./images/LSD+Xbot.png)
