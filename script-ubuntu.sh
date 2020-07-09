#! /bin/bash

#update ubuntu
echo "=============== update ubuntu ==============="
sudo apt update
echo "=============== install nginx ==============="
sudo apt install nginx -y
echo "=============== copy file index to root dir nginx ==============="
echo "<h1><center>Welcome to my websites</center></h1>" > /var/www/html/index.html
echo "=============== start nginx ==============="
sudo service nginx start
echo "=============== install mysql ==============="
sudo apt-get update
sudo apt-get install mysql-server -y
echo "=============== allow remote access ==============="
sudo ufw enable -y
sudo ufw allow mysql
echo "=============== start mysql ==============="
sudo systemctl start mysql