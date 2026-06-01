#!/bin/bash
USER=$(id -u)

if [ $USER -ne 0 ]; then
echo "please run the script with root user"
exit 1
fi

#echo "I am continuing"
dnf list installed mysql
if [ $? -eq 0 ]; then
echo "already installed mysql so ... skipping"
else
echo "Installing mysql"

dnf install mysql -y
if [ $? -eq 0 ]; then
echo "mysql is install success"
else
echo "mysql is not installed"
exit 1
fi