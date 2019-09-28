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
#install Pangolin
#
#######################
echo "安装Pangolin......"
sudo apt install libpython2.7-dev pkg-config libglew-dev libboost-dev libboost-thread-dev libboost-filesystem-dev
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake ..
make
sudo make install
#######################
#
#Install ORB-SLAM2
#
#######################
echo "安装ORB-SLAM2......"
git clone https://github.com/raulmur/ORB_SLAM2.git ORB_SLAM2
cd ORB_SLAM2
chmod +x build.sh
./build.sh



































