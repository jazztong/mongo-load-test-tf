#! /bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Configure Cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm

# Use cloudwatch config from SSM
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s

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

# install yq for config setting
wget https://github.com/mikefarah/yq/releases/download/v4.6.3/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

# Create users
mongo --eval "db.getSiblingDB('admin').createUser({ user: 'root', pwd: 'mypassword', roles: [{role: 'root', db: 'admin'}] })"

systemctl stop mongod
sleep 1
# Allow external connection
cat /etc/mongod.conf | yq e '.net.bindIp = "0.0.0.0"' - | tee /etc/mongod.conf
# Enable authorization to prevent full access
cat /etc/mongod.conf | yq e '.security.authorization = "enabled"' - | tee /etc/mongod.conf
echo 'Override mongod.conf'

systemctl start mongod

# Report end
echo 'Done Initialization'