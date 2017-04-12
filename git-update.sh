#!/bin/sh
# Script to update a git project
#Clone the project to local machine

cd /path/to/local/repo
git checkout developer
git pull
git checkout master
git pull
git merge developer
git push origin master

#The following code is used to pull code on the server

ssh user@ip "cd /path/to/project/ ; git pull "
