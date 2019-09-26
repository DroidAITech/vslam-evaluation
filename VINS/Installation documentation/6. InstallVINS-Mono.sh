#!/bin/bash
#######################
#
#install eigen3
#
#######################
echo "安装eigen3......"
sudo apt-get install libeigen3-dev 
#######################
#
#install opencv3.4.5
#
#######################
echo "安装opencv......"
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
cd ~
git clone https://github.com/opencv/opencv.git
cd ~/opencv
mkdir build
cd build
cmake ..
make
sudo make install
#######################
#
#install ceres-solver
#
#######################
echo "安装ceres-solver......"
sudo apt-get install liblapack-dev libsuitesparse-dev libcxsparse3.1.2 libgflags-dev 
sudo apt-get install libgoogle-glog-dev libgtest-dev
cd ~
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake ..
make
sudo make install
#######################
#
#Install VINS-Mono
#
#######################
echo "安装VINS-Mono......"
sudo apt-get install ros-kinetic-cv-bridge ros-kinetic-tf ros-kinetic-message-filters ros-kinetic-image-transport
cd ~
mkdir -p vins_ws/src
cd ~/vins_ws/src
git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git
cd ../
catkin_make
source devel/setup.bash



































