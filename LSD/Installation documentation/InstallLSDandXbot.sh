#!/bin/bash
##################
#
#部署LSD
#
##################

###安装依赖

sudo apt-get install ros-kinetic-libg2o ros-kinetic-cv-bridge liblapack-dev libblas-dev freeglut3-dev libsuitesparse-dev libx11-dev
sudo apt install libqglviewer-dev-qt4
cd /usr/lib/x86_64-linux-gnu
sudo ln -s libQGLViewer-qt4.so libQGLViewer.so
###创建LSD工作空间
echo "创建LSD工作空间......"
mkdir -p ~/catkin_lsdws/src
cd ~/catkin_lsdws/src/
read -p "下载链接的lsd_slam.zip文件并解压到~/catkin_lsdws/src目录下 https://yt.droid.ac.cn/xbot-u/vslam-evaluation/blob/master/LSD/lsd_slam.zip ，并按y继续" LSD
if [ $LSD = "y" -o $LSD = "Y" ] ; then  
	cd  ~/catkin_lsdws/
	catkin_make 
	##################
	#
	#部署Xbot
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
		#启动Xbot
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
