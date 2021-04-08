#! /bin/bash
set -e

# Install git
#yum install git -y

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Make sure we have all the latest updates when we launch this instance
#yum update -y
#yum upgrade -y

# Setup mongo
cat <<EOF > /etc/yum.repos.d/mongodb-org-4.4.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

yum install -y mongodb-org
systemctl start mongod
systemctl enable mongod
systemctl status mongod

# Create users
mongo --eval "db.getSiblingDB('admin').createUser({ user: 'root', pwd: 'mypassword', roles: [{role: 'root', db: 'admin'}] })"

# # Override setting
# cat <<EOF > /etc/mongod.conf
# # mongod.conf

# # for documentation of all options, see:
# #   http://docs.mongodb.org/manual/reference/configuration-options/

# # where to write logging data.
# systemLog:
#   destination: file
#   logAppend: true
#   path: /var/log/mongodb/mongod.log

# # Where and how to store data.
# storage:
#   dbPath: /var/lib/mongo
#   journal:
#     enabled: true
# #  engine:
# #  wiredTiger:

# # how the process runs
# processManagement:
#   fork: true  # fork and run in background
#   pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
#   timeZoneInfo: /usr/share/zoneinfo

# # network interfaces
# net:
#   port: 27017
#   bindIp: 0.0.0.0

# security:
#   authorization: 'enabled'
# EOF

#systemctl restart mongod
# Report end
echo 'Done Initialization'