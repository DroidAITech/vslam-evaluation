#!/bin/bash
#
#######################
#
#install eigen3
#
#######################

echo "安装eigen3......"
sudo apt-get install libsuitesparse-dev libeigen3-dev libboost-all-dev

#######################
#
#install opencv
#
#######################

echo "安装opencv......"
sudo apt-get install libopencv-dev

#######################
#
#install pangolin
#
#######################

echo "安装pangolin......"
cd ~
sudo apt-get install libglew-dev
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake ..
make
sudo make install

#######################
#
#install DSO
#
#######################

echo "安装DSO......"
cd ~
mkdir -p ~/catkin_dso/src
cd catkin_dso/src
catkin_init_workspace
cd ..
catkin_make
cd src
git clone https://github.com/JakobEngel/dso.git
cd dso 
mkdir build 
cd build 
cmake .. 
make 

#######################
#
#install dso_ros
#
#######################

echo "安装dso_ros......"
cd ~/catkin_dso/src

git clone https://github.com/anchuanxu/dso_ros.git
cd ..
source devel/setup.bash
cd src/dso_ros
export DSO_PATH=~/catkin_dso/src/dso
mkdir build
cd build
cmake ..
make
sudo make install
cd ~/catkin_dso
catkin_make

#######################
#
#install usb_cam
#
#######################
echo "安装usb_cam......"
cd ~/catkin_dso/src
git clone https://github.com/bosch-ros-pkg/usb_cam.git 
cd ..
catkin_make
source ~/catkin_dso/devel/setup.bash




