#!/bin/bash
##################
#
#在仿真环境下用Xbot测试lsd-slam
#
##################
read -p "是否部署过Xobt？请输入[y/n]" answer
if [ $answer = "n" -o $answer = "N" ] ; then 
echo "创建Xot工作空间......"
mkdir -p ~/ROS/src
cd ~/ROS/src
git clone https://yt.droid.ac.cn/anchuanxu/simulation_base_environment.git
cd ~/ROS
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin_make
##################
#
#启动仿真环境和Xbot
#
##################
gnome-terminal -x bash -c "cd  ~/ROS;source devel/setup.bash;roslaunch robot_sim_demo robot_spawn.launch; exec bash"
elif [ $answer = "Y" -o $answer = "y" ] ; then
read -p "部署过Xobt的话请自行启动Xbot并按y继续" start
if [ $start = "y" -o $start = "Y" ] ; then 
echo "启动Xobt......"
fi
fi
##################
#
#启动LSD
#
##################
sleep 15s
gnome-terminal -x bash -c "cd ~/catkin_lsdws/;source devel/setup.bash;rosrun lsd_slam_core live_slam /image:=/camera/rgb/image_raw  /camera_info:=/camera/rgb/camera_info; exec bash"
sleep 10s
gnome-terminal -x bash -c "cd ~/catkin_lsdws/;source devel/setup.bash;rosrun lsd_slam_viewer viewer; exec bash"
sleep 5s
if [ $answer = "n" -o $answer = "N" ] ; then 
gnome-terminal -x bash -c "cd ~/ROS/src/simulation_base_environment/robot_sim_demo/scripts;./robot_keyboard_teleop.py; exec bash"
fi
if [ $answer = "Y" -o $answer = "y" ] ; then
echo "请自行启动Xbot控制脚本"
fi
fi
