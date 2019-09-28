#!/bin/bash
read -p "是否部署过SVO？请输入[y/n]" answer
if [ $answer = "n" -o $answer = "N" ] ; then
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

fi
##################
#
#部署usb_cam
#
##################
mkdir -p ~/usb_cam/src
cd ~/usb_cam/src
git clone https://github.com/ros-drivers/usb_cam.git
cd usb_cam
mkdir build
cd build
cmake ..
make
##################
#
#启动usb_cam
#
##################
read -p "请修改rpg_svo/svo_ros//param/camera_atan.yaml文件相机标定参数（修改教程参考“SVO使用自己的摄像头” ）修改完成按"y"继续" answer
if [ $answer = "y" -o $answer = "Y" ] ; then   
    gnome-terminal -x bash -c "cd  ~/usb_cam/;source devel/setup.bash;cd src/usb_cam/launch;roslaunch usb_cam-test.launch; exec bash"
    ##################
    #
    #启动svo
    #
    ##################
    sleep 5s
    sed -i 's/param name="cam_topic" value="/camera/image_raw" type="str" /param name="cam_topic" value="/usb_cam/image_raw" type="str" /' ~/SVO_demo/rpg_svo/svo_ros/launch/live.launch #修改订阅的Topic
    gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;roslaunch svo_ros live.launch; exec bash"
    sleep 7s
    gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;rosrun rviz rviz -d ~/SVO_demo/src/rpg_svo/svo_ros/rviz_config.rviz; exec bash"
    sleep 7s
    gnome-terminal -x bash -c "cd  ~/SVO_demo/;source devel/setup.bash;rosrun rqt_svo rqt_svo; exec bash"
    sleep 2s
fi

