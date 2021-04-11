#! /bin/bash
set -e
# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install dependencies
echo ECS_CLUSTER=mongo-ecs-cluster >> /etc/ecs/ecs.config

# Report end
echo 'Done Initialization'