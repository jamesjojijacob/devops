#!/bin/bash

## Deploying a Python Django project

## Initial setup

apt-get update
apt-get install -y python-pip apache2 libapache2-mod-wsgi python-virtualenv libmysqlclient-dev

## Creating empty project directory on apache root

export PROJECTPATH="/var/www/"

# prompt for name of file or directory

echo -n "Enter project name: "

# read the name

read PROJECTNAME

# Check if directory already exists

if [ -d "$PROJECTPATH""$PROJECTNAME" ]; then
  echo "Project exists in the root directory. Aborting..";
  exit 0;
fi

# create empty directory on project path

mkdir -p -- "$PROJECTPATH""$PROJECTNAME"
echo "$PROJECTNAME created."

## Place the project files as a compressed file in 
## the home directory to run the following commands

# uncompressing the project files to $PROJECTNAME

tar -xzvf "$PROJECTNAME".tar.gz -C "$PROJECTPATH"

## creating virtual environment

virtualenv "$PROJECTPATH""$PROJECTNAME"/"$PROJECTNAME"

## activating virtual environment
source "$PROJECTPATH""$PROJECTNAME"/"$PROJECTNAME"/bin/activate

##installing python requirements inside virtual environment
pip install -r "$PROJECTPATH""$PROJECTNAME"/requirements.txt

## to install without breaking
cat "$PROJECTPATH""$PROJECTNAME"/requirements.txt | while read PACKAGE; do pip install "$PACKAGE"; done

## deactivating virtual environment
deactivate

## Apache configuration

echo "<VirtualHost *:80>" > /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "ServerAdmin webmaster@localhost" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	DocumentRoot "$PROJECTPATH""$PROJECTNAME"" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	WSGIDaemonProcess "$PROJECTNAME" python-path="$PROJECTPATH""$PROJECTNAME":"$PROJECTPATH""$PROJECTNAME"/"$PROJECTNAME"/lib/python2.7/site-packages" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	WSGIProcessGroup "$PROJECTNAME"" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	WSGIScriptAlias / "$PROJECTPATH""$PROJECTNAME"/"$PROJECTNAME"/wsgi.py" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "	CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf
echo "</VirtualHost>" >> /etc/apache2/sites-enabled/"$PROJECTNAME".conf

## Remove default configuration file

mv /etc/apache2/sites-enabled/000-default.conf ~

## Restart apache

service apache2 restart
