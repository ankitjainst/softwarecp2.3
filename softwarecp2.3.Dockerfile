from    ubuntu:14.04
run	mkdir -p /home/software
COPY	software/* /home/software/
run	tar -zxvf /home/software/jdk-8u121-linux-x64.tar.gz -C /home/software
run	tar -zxvf /home/software/ideaIC-2016.3.5.tar.gz -C /home/software
run	tar -zxvf /home/software/gitSettings.tar.gz -C /home/software
run	tar -zxvf /home/software/AnypointStudio.tar.gz -C /home/software
run	tar -zxvf /home/software/slack.tar.gz -C /home/software

#	GIT installed
run     apt-get update
run     apt-get install -y git-all

#	MAVEN installed 
run     apt-get update
run	apt-get install -y maven

#	VIM installed
run	apt-get update
run	apt-get install -y vim-gnome

#	SSH installed
run     apt-get update
run	apt-get install -y openssh-server
run	echo 'root:docker12$' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
ENTRYPOINT service ssh restart && bash

run  	echo 'export JAVA_HOME=/home/software/jdk1.8.0_121' >> /root/.bashrc 
run	echo 'export PATH="/home/host/path:$PATH"' >> /root/.bashrc
run	echo 'source /home/software/gitSettings/git-completion.bash' >> /root/.bashrc
run	echo 'source /home/software/gitSettings/gitBranchDisplay' >> /root/.bashrc

run 	echo 'JAVA_HOME=/home/software/jdk1.8.0_121' >> /etc/profile
run 	echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME/bin' >> /etc/profile
run 	echo 'export JAVA_HOME' >> /etc/profile
run 	echo 'export PATH' >> /etc/profile

run	update-alternatives --install "/usr/bin/java" "java" "/home/software/jdk1.8.0_121/bin/java" 1
run	update-alternatives --install "/usr/bin/javac" "javac" "/home/software/jdk1.8.0_121/bin/javac" 1
run	update-alternatives --install "/usr/bin/javaws" "javaws" "/home/software/jdk1.8.0_121/bin/javaws" 1

run	update-alternatives --set java /home/software/jdk1.8.0_121/bin/java
run	update-alternatives --set javac /home/software/jdk1.8.0_121/bin/javac
run	update-alternatives --set javaws /home/software/jdk1.8.0_121/bin/javaws

run	apt-get update
run	apt-get install screen
