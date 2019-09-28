#!/bin/bash
#
###################
#
#创建SVO工作空间
#
##################
echo "创建SVO工作空间......"
mkdir -p ~/SVO_demo/src
cd ~/SVO_demo/src
catkin_init_workspace
##################
#
#安装Sophus
#
##################
echo "安装Sophus......"
git clone https://github.com/strasdat/Sophus.git 
cd Sophus 
git checkout a621ff 
mkdir build 
cd build 
cmake .. 
make
##################
#
#安装Fast
#
##################
echo "安装Fast......"
cd ~/SVO_demo/src
git clone https://github.com/uzh-rpg/fast.git
cd fast
mkdir build
cd build
cmake ..
make
##################
#
#安装g2o
#
##################
echo "安装g2o......"
cd ~/SVO_demo/src
git clone https://github.com/RainerKuemmerle/g2o.git
cd g2o
mkdir build
cd build
cmake ..
make
sudo make install
##################
#
#安装vikit
#
##################
echo "安装vikit......"
cd ~/SVO_demo/src
git clone https://github.com/uzh-rpg/rpg_vikit.git



##################
#
#Install dependencies
#
##################
echo "安装依赖......"
sudo apt-get install ros-indigo-cmake-modules 
##################
#
#安装SVO
#
##################
echo "安装SVO......"
cd ~/SVO_demo/src
git clone https://github.com/uzh-rpg/rpg_svo.git
sed -i 's/from python_qt_binding.QtGui import QWidget/from python_qt_binding.QtWidgets import QWidget/' ~/SVO_demo/src/rpg_svo/rqt_svo/src/rqt_svo/svo_widget.py #修改一个错误
##################
#
#编译SVO
#
##################
cd  ~/SVO_demo/
catkin_make  

##################
#
#下载数据集
#
##################
echo "下载数据集......"
read -p "是否下载数据集（1.8G）请输入“y”or “n”:" answer
if [ $answer = "y" -o $answer = "Y" ] ; then  
    cd ~/SVO_demo/src
    wget rpg.ifi.uzh.ch/datasets/airground_rig_s3_2013-03-18_21-38-48.bag
fi
##################
#
#启动SVO
#
##################

gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;roslaunch svo_ros test_rig3.launch; exec bash"
sleep 5s

gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;rosrun rviz rviz -d ~/SVO_demo/src/rpg_svo/svo_ros/rviz_config.rviz; exec bash"
sleep 5s
gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;rosrun rqt_svo rqt_svo; exec bash"
sleep 2s
if [ $answer = "y" -o $answer = "Y" ] ; then  
    gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;rosbag play ~/SVO_demo/src/airground_rig_s3_2013-03-18_21-38-48.bag; exec bash"
fi

