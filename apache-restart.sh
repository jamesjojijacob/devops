#!/bin/bash

#apache_restart function to restart apache service on linux servers

apache_restart () {
while true; do
    read -p "Restart apache?" yn
    case $yn in
        [Yy]* ) ssh root@"$1" "service apache2 restart"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
}


# Use this function in other scripts by defining server names as variables that contain respective ip addresses.
