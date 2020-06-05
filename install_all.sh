#!/usr/bin/env sh

rosdep update
sudo apt update

#2nd Level dependencies (will move)
sudo apt install python3-{numpy,scipy,matplotlib,sympy} -y

sudo apt install ros-melodic-laptop-battery-monitor  -y

# Bayesian Filtering Library
sudo apt install ros-melodic-bfl -y

# Sensor dependencies
sudo apt install libeigen3-dev ros-melodic-depthimage-to-laserscan ros-melodic-robot-pose-ekf ros-meldoic-joy -y

#Embedded control libraries
sudo apt-get install ros-melodic-ecl-streams -y

# Yujin Robot
sudo apt install ros-melodic-yujin-ocs  -y

#Kobuki Base
# https://github.com/turtlebot/turtlebot/issues/272 
sudo apt install ros-melodic-kobuki-core ros-melodic-kobuki-dock-drive \
ros-melodic-kobuki-driver ros-melodic-kobuki-ftdi ros-melodic-kobuki-msgs -y
#git clone https://github.com/yujinrobot/kobuki_desktop.git


mkdir -p src
cd src

catkin config --cmake-args -DOpenCV_DIR=/usr/share/opencv4/
#cv_bridge with OpenCV 4
git clone https://github.com/OAkyildiz/vision_opencv.git

# Turtlebot
#git clone https://github.com/turtlebot/turtlebot_simulator
git clone https://github.com/turtlebot/turtlebot.git
git clone https://github.com/turtlebot/turtlebot_apps.git #turtlebot_actions needs a little change
git clone https://github.com/turtlebot/turtlebot_msgs.git
git clone https://github.com/turtlebot/turtlebot_interactions.git

#Kobuki for Melodic
git clone --single-branch --branch melodic https://github.com/yujinrobot/kobuki.git

# Build
catkin build --start-with cv_bridge


# I have puck
# sudo apt install ros-melodic-velodyne -y

