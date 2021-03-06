#!/bin/bash

# Update from OS install
yum update -y

# Common utilities
yum install -y nano zip unzip wget curl git

# Install Java 8
yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-headless.x86_64

# install Maven
MVN_VER=3.5.4

cd /usr/local
wget http://www-us.apache.org/dist/maven/maven-3/$MVN_VER/binaries/apache-maven-$MVN_VER-bin.tar.gz
tar -xvzf apache-maven-$MVN_VER-bin.tar.gz
ln -s apache-maven-$MVN_VER maven
chown -R root.root apache-maven-$MVN_VER
chmod 755 apache-maven-$MVN_VER
ln -s maven/bin/mvn /bin/mvn

# install Jenkins
cd /
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y
yum install -y jenkins java-1.8.0-openjdk-devel

systemctl start jenkins
systemctl enable jenkins

#install nginx using amazon-linux-extras
amazon-linux-extras install -y nginx1

#copy the conf file to conf.d
cd /etc/nginx/conf.d
wget https://raw.githubusercontent.com/fantasticVoyager/jenkins-bootcamp-course/master/aws/lightsail/lightsail-jenkins.conf

systemctl restart nginx
systemctl enable nginx
