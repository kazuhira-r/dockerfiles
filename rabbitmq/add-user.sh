#!/bin/bash

USERNAME=$1
PASSWORD=$2

sudo -u rabbitmq rabbitmqctl add_user ${USERNAME} ${PASSWORD}
sudo -u rabbitmq rabbitmqctl set_permissions -p / ${USERNAME} ".*" ".*" ".*"
sudo -u rabbitmq rabbitmqctl set_user_tags ${USERNAME} management
