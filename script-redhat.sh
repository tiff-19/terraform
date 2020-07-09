#! /bin/bash

#update redhat
echo "=============== update CentOS ==============="
sudo yum update -y
echo "=============== install nginx ==============="
sudo yum install nginx -y
echo "=============== copy file index to root dir nginx ==============="
echo "<h1><center>Welcome to my websites</center></h1>" > /usr/share/nginx/html/index.html
echo "=============== start nginx ==============="
sudo service nginx start
echo "=============== install mysql ==============="
sudo yum install wget -y
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
sudo yum install mysql-server -y
echo "=============== allow remote access ==============="
sudo ufw enable -y
sudo ufw allow mysql
echo "=============== start mysql ==============="
sudo systemctl start mysqld