#!/bin/bash
##################
#
#LSD安装编译
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
git clone https://github.com/anchuanxu/LSD.git
cd  ~/catkin_lsdws/
catkin_make 
##################
	
