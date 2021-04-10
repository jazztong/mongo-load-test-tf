#! /bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install dependencies
yum install -y telnet python37 maven
amazon-linux-extras install java-openjdk11 -y
curl -O --location https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz
tar xfvz ycsb-0.17.0.tar.gz

# Report end
echo 'Done Initialization'