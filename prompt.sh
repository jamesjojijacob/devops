#!/bin/sh
#This is a simple yes or no prompt script.

while true; do
    read -p "Question?" yn
    case $yn in
        [Yy]* ) echo "do this command"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
