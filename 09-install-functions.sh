#!/bin/bash
USER=$(id -u)

if [ $USER -ne 0 ]; then
    echo "please run the script with root user"
    exit 1
fi

validate(){
    if [ $2 -eq 0 ]; then
       echo "$1 is install success"
    else
       echo "$1 is not installed"
       exit 1
    fi
}

#echo "I am continuing"
dnf list installed mysql

if [ $? -eq 0 ]; then
    echo "already installed mysql so ... skipping"
else
    echo "Installing mysql"
    dnf install mysql -y
    validate mysql $?
fi

dnf list installed nginx

if [ $? -eq 0 ]; then
    echo "nginx is already installed ... SKIPPING"
else
    echo "Installing nginx"
    dnf install nginx -y
    validate nginx $?
fi