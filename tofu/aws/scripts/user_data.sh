#!/bin/bash

# Updating and upgrading packages
yum update -y
yum upgrade -y

# Installing dependencies
yum install git nginx python3-pip -y

# Going to the user home directory
cd /home/ec2-user

# Cloning repository as ec2-user (instead of root user)
runuser -l ec2-user -c 'git clone https://github.com/lucasfacci/aws-django-sms-api.git'

# Going to the root of the project
cd aws-django-sms-api/django-sms-api/

# Installing Python requirements
pip install -r requirements.txt

# Creating database and static folder
runuser -l ec2-user -c 'cd aws-django-sms-api/django-sms-api && python3 manage.py migrate'
runuser -l ec2-user -c 'cd aws-django-sms-api/django-sms-api && python3 manage.py collectstatic'

# Creating Gunicorn service file
cp ../tofu/aws/scripts/gunicorn.service /etc/systemd/system
sed -i "s|VALUE1|$(openssl rand -base64 64 | tr -d '\n' | tr -d '/')|" /etc/systemd/system/gunicorn.service
sed -i "s/VALUE2/$(curl -s http://checkip.amazonaws.com)/" /etc/systemd/system/gunicorn.service

# Starting Gunicorn service
systemctl start gunicorn
systemctl enable gunicorn

# Creating Nginx config file
cp ../tofu/aws/scripts/nginx.conf /etc/nginx/nginx.conf
sed -i "s/CHANGE_HERE/$(curl -s http://checkip.amazonaws.com)/" /etc/nginx/nginx.conf

# Adding nginx user to the ec2-user group
usermod -a -G ec2-user nginx

# Giving execute permission in the home directory to the user group
chmod 710 /home/ec2-user

# Starting Nginx service
systemctl start nginx
systemctl enable nginx
