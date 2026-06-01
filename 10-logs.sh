#!/bin/bash
USER=$(id -u)
LOGS_DIR=/var/log/shell-script
LOGS_FILE="$LOGS_DIR/$0.log"

if [ $USER -ne 0 ]; then
    echo "please run the script with root user"
    exit 1
fi

validate(){
    if [ $2 -eq 0 ]; then
       echo "$1 is install success"
    else
       echo "$1 is not installed .. failure"
       exit 1
    fi
}

#echo "I am continuing"
dnf list installed mysql &>> $LOGS_FILE

if [ $? -eq 0 ]; then
    echo "already installed mysql so ... skipping"
else
    echo "Installing mysql"
    dnf install mysql -y &>> $LOGS_FILE
    validate mysql $?
fi

dnf list installed nginx &>> $LOGS_FILE

if [ $? -eq 0 ]; then
    echo "nginx is already installed ... SKIPPING"
else
    echo "Installing nginx"
    dnf install nginx -y &>> $LOGS_FILE
    validate nginx $?
fi