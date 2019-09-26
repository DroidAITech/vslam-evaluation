# VINS-Mono算法安装、配置、测试、运行仓库

#### 包含内容

- VINS-Mono理论文档
- 公开数据集测试VINS-Mono文档
- Realsense D435i运行VINS-Mono文档
- 联合标定IMU和相机kalibr_cailibration文档
- 小觅相机深度版在xbot上运行VINS-Mono文档
- VINS-Mono一键安装脚本
- 安装运行过程中可能遇到的问题及解决办法汇总文档

#### 说明

VIO（visual-inertial odometry）即视觉惯性里程计，也叫视觉惯性系统(VINS，visual-inertial system)，是融合相机和IMU数据实现SLAM的算法。VIO尤其是VIO中的紧耦合充分利用了传感器数据，可以实现更好的效果，是目前研究的重点。而VINS-Mono就是VIO实现比较好的开源框架之一，它是香港科技大学沈劭劼团队开源的单目视觉惯导SLAM方案，是视觉与IMU融合中的经典之作。VINS-Mono是基于优化和滑动窗口的VIO，使用IMU预积分构建紧耦合框架。并且具备自动初始化，在线外参标定，重定位，闭环检测，以及全局位姿图优化功能。由数据预处理、初始化、后端非线性优化、回环检测和全局位姿图优化五部分组成。

#### 文档说明

kalibr_calibration.md是联合标定相机和IMU的教程文档，使用的是小觅相机的D系列；

用小觅相机深度版在xbot上运行VINS-Mono.md利用上一个文档的标定信息，配置VINS-Mono的过程；

record_vins_bag.md说明录制VINS-Mono可以使用的bag文件方法。



