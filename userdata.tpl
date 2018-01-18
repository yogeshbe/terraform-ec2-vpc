#!/bin/sh
sudo apt-get -y update
sudo apt-get install -y apache2
sudo service apache2 start
sudo apt-get install -y docker.io
