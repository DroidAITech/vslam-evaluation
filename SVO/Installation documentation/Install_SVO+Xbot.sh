#!/bin/bash
read -p "是否部署过SVO？请输入[y/n]" answer
if [ $answer = "n" -o $answer = "N" ] ; then 
    read -p "请输入欲部署SVO的工作空间名称:" SVO_basepath
    echo "创建SVO工作空间......"
    mkdir -p ~/$SVO_basepath/src
    cd ~/$SVO_basepath/src
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
    cd ~/$SVO_basepath/src
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
    cd ~/$SVO_basepath/src
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
    cd ~/$SVO_basepath/src
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
    cd ~/$SVO_basepath/src
    git clone https://github.com/uzh-rpg/rpg_svo.git

    ##################
    #
    #编译SVO
    #
    ##################
    cd  ~/$SVO_basepath/
    catkin_make  
fi
##################
#
#创建Xbot工作空间
#
##################
echo "创建Xbot工作空间......"
read -p "请输入欲部署Xbot的工作空间名称:" Xbot_basepath
mkdir -p ~/$Xbot_basepath/src
cd ~/$Xbot_basepath/src
catkin_init_workspace
git clone https://yt.droid.ac.cn/anchuanxu/simulation_base_environment.git
cd ~/$Xbot_basepath
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin_make 
sed -i 's/param name="cam_topic" value="/camera/image_raw" type="str" /param name="cam_topic" value="/camera/rgb/image_raw" type="str" /' ~/$SVO_basepath/rpg_svo/svo_ros/launch/live.launch #修改订阅的Topic
cat > ~/$SVO_basepath/src/rpg_svo/svo_ros/param/camera_atan.yaml << EOF    
cam_model: Pinhole
cam_width: 1280
cam_height: 720
cam_fx: 1108.7654256452881
cam_fy: 1108.7654256452881
cam_cx: 640.5
cam_cy: 360.5
cam_d0: 0
cam_d1: 0
cam_d2: 0
cam_d3: 0
EOF
gnome-terminal -x bash -c "cd  ~/$Xbot_basepath/;source devel/setup.bash;roslaunch robot_sim_demo robot_spawn.launch; exec bash"
sleep 10s
if [ $answer = "n" -o $answer = "N" ] ; then  #之前没有部署过SVO 
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;roslaunch svo_ros live.launch; exec bash"
    sleep 5s 
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;rosrun rviz rviz -d ~/$SVO_basepath/src/rpg_svo/svo_ros/rviz_config.rviz; exec bash"
    sleep 5s
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;rosrun rqt_svo rqt_svo; exec bash"
else #之前部署过SVO
    read -p "请输入之前部署SVO的工作空间绝对路径，例如：~/SVO_demo:" SVO_basepath_1
    sed -i 's/param name="cam_topic" value="/camera/image_raw" type="str" /param name="cam_topic" value="/camera/rgb/image_raw" type="str" /' ~/$SVO_basepath/rpg_svo/svo_ros/launch/live.launch #修改订阅的Topic
cat > $SVO_basepath_1/src/rpg_svo/svo_ros/param/camera_atan.yaml << EOF    
cam_model: Pinhole
cam_width: 1280
cam_height: 720
cam_fx: 1108.7654256452881
cam_fy: 1108.7654256452881
cam_cx: 640.5
cam_cy: 360.5
cam_d0: 0
cam_d1: 0
cam_d2: 0
cam_d3: 0
EOF
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;roslaunch svo_ros live.launch; exec bash"
    sleep 5s 
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;rosrun rviz rviz -d ~/$SVO_basepath/src/rpg_svo/svo_ros/rviz_config.rviz; exec bash"
    sleep 5s
    gnome-terminal -x bash -c "cd  ~/$SVO_basepath/;source devel/setup.bash;rosrun rqt_svo rqt_svo; exec bash"
fi


