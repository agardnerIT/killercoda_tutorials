#!/bin/bash

apt install -y stress

apt install -y software-properties-common
apt-add-repository -y --update ppa:ansible/ansible

apt install -y ansible

# touch a file that foreground.sh is waiting for before proceeding
touch /tmp/finished
