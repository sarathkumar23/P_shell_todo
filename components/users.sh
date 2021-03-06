#!/bin/bash

source components/common.sh
OS_PREREQ

Head "Install java"
apt-get install openjdk-8-jdk -y &>>$LOG
Check $?

Head "Install maven"
apt install maven -y &>>$LOG
Check $?

DOWNLOAD_COMPONENT

Head "Extract Downloaded Archive"
cd /home/ubuntu && rm -rf users  && apt install unzip &>>$LOG &&  unzip -o /tmp/users.zip &>>$LOG && mv users-main users  && cd users && mvn clean package &>>$LOG && mv target/users-api-0.0.1.jar users.jar
Check $?

Head "Setup the systemd Service"
mv /home/ubuntu/users/systemd.service /etc/systemd/system/users.service && systemctl daemon-reload && systemctl start users && systemctl enable users &>>$LOG
Check $?