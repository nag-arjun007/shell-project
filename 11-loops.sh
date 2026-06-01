#!/bin/bash
USER=$(id -u)
LOGS_DIR=/var/log/shell-script
LOGS_FILE="$LOGS_DIR/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USER -ne 0 ]; then
    echo "please run the script with root user"
    exit 1
fi

validate(){
    if [ $2 -eq 0 ]; then
       echo "$TIMESTAMP [INFO] $1 is install success" | tee -a $LOGS_FILE
    else
       echo "$TIMESTAMP [ERROR] $1 is not installed .. failure" | tee -a $LOGS_FILE
       exit 1
    fi
}

#echo "I am continuing"

for package in $@
do   
    echo "Installing $package"
    dnf list installed $package
    if [ $? -ne 0 ]; then
        dnf install $package -y &>> $LOGS_FILE
        validate "installing $package" $?
    else
        echo "$TIMESTAMP [INFO] $package already installed ... skipping"
    fi         
done    