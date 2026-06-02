#!/bin/bash
USER=$(id -u)
LOGS_DIR=/var/log/shell-script
LOGS_FILE="$LOGS_DIR/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

if [ $USER -ne 0 ]; then
    echo -e "$Y please run the script with root user $N"
    exit 1
fi

validate(){
    if [ $2 -eq 0 ]; then
       echo -e "$TIMESTAMP [INFO] $1 is install $G success $N" | tee -a $LOGS_FILE
    else
       echo -e "$TIMESTAMP [ERROR] $1 is not installed ..$Y failure $N" | tee -a $LOGS_FILE
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
        echo -e "$TIMESTAMP [INFO] $package already installed ... $B skipping $N"
    fi         
done    