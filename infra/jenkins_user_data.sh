#!/bin/bash
apt update -y
apt install -y openjdk-11-jdk docker.io git
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update -y
apt install -y jenkins
systemctl enable jenkins
systemctl start jenkins
