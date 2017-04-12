#!/bin/bash
#This is a centralized menu driven script to run updates for applications running on linux machines served using apache.

#server ip addresses to be defined and uncommented

#project1=
#project2=
#project3=

#apache_restart function to restart apache
#root login using keys must be enabled on all servers for the function to work

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

#local git repositories and update scripts have to bvbe maintained

echo "Choose project:"
select yn in "project1" "project2" "project3" "exit"; do
    case $yn in
        project1 ) /path/to/git-update script for project1; apache_restart $project1; break;;
        project1 ) /path/to/git-update script for project2; apache_restart $project2; break;;
        project1 ) /path/to/git-update script for project3; apache_restart $project3;  break;;
        exit ) exit;;
    esac
done
