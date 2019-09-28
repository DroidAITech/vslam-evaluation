# LSD在仿真xbot上的部署

### 环境

* Ubuntu 16.04
* bro2018fall-codes
* LSD代码(详见LSD部署教程)
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
rosrun lsd_slam_core live_slam /image:=/camera/rgb/image_raw  /camera_info:=/camera/rgb/camera_info
```
再开一个终端

```
cd catkin_lsdws #catkin_lsdws为LSD工作空间
source devel/setup.bash
rosrun lsd_slam_viewer viewer
```
再开一个终端

```
cd catkin_ws/ #catkin_ws为Xbot仿真环境的工作空间
source devel/setup.bash
rosrun robot_sim_demo robot_keyboard_teleop.py #启动键盘控制程序
```
控制Xbot移动并建图

![image](./images/LSD+Xbot.png)