#!/usr/bin/env sh

mkdir -p src
cd src

DEFAULT="melodic"

if [[ -z "$1" ]]
  then
    DISTRO=$1
else
	DISTRO=${DEFAULT}    
fi

rosdep update
sudo apt update

#2nd Level dependencies (will move)
sudo apt install python3-{numpy,scipy,matplotlib,sympy} -y

sudo apt install ros-${DISTRO}-laptop-battery-monitor  -y

# Bayesian Filtering Library
sudo apt install ros-${DISTRO}-bfl -y

# Sensor dependencies
sudo apt install libeigen3-dev ros-${DISTRO}-depthimage-to-laserscan ros-${DISTRO}-robot-pose-ekf ros-meldoic-joy ros-${DISTRO}--joint-state-publisher-gui -y

#Embedded control libraries
sudo apt-get install ros-${DISTRO}-ecl-streams -y

# Yujin Robot
if [[ $DISTRO -eq "noetic" ]]
  then
	https://github.com/yujinrobot/yujin_ocs
    
else
	sudo apt install ros-${DISTRO}-yujin-ocs ros-${DISTRO}-yocs-cmd-vel-mux -y
fi


#Kobuki Base
# https://github.com/turtlebot/turtlebot/issues/272 
sudo apt install ros-${DISTRO}-kobuki-core ros-${DISTRO}-kobuki-dock-drive \
ros-${DISTRO}-kobuki-driver ros-${DISTRO}-kobuki-ftdi ros-${DISTRO}-kobuki-msgs -y
#git clone https://github.com/yujinrobot/kobuki_desktop.git

if [[ $DISTRO -eq "noetic" ]]
  then
  	git clone https://github.com/yujinrobot/kobuki_core.git    
	git clone https://github.com/yujinrobot/kobuki_msgs.git    
	git clone https://github.com/yujinrobot/kobuki_dock_drive.git    
	git clone https://github.com/yujinrobot/kobuki_driver.git    
	git clone https://github.com/yujinrobot/kobuki_ftdi.git    
    
else
	sudo apt install ros-${DISTRO}-kobuki-core ros-${DISTRO}-kobuki-dock-drive \
	ros-${DISTRO}-kobuki-driver ros-${DISTRO}-kobuki-ftdi ros-${DISTRO}-kobuki-msgs -y
fi


catkin config --cmake-args -DOpenCV_DIR=/usr/share/opencv4/
#cv_bridge with OpenCV 4
git clone https://github.com/OAkyildiz/vision_opencv.git

# Turtlebot
#git clone https://github.com/turtlebot/turtlebot_simulator
git clone https://github.com/turtlebot/turtlebot.git
git clone https://github.com/turtlebot/turtlebot_apps.git #turtlebot_actions needs a little change
git clone https://github.com/turtlebot/turtlebot_msgs.git
git clone https://github.com/turtlebot/turtlebot_interactions.git

#Kobuki for ${DISTRO}
git clone --single-branch --branch ${DISTRO} https://github.com/yujinrobot/kobuki.git

# Build
catkin build --start-with cv_bridge


# I have puck
# sudo apt install ros-${DISTRO}-velodyne -y

