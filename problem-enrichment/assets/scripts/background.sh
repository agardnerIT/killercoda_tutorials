#!/bin/bash

################################
#     Installing Software      #
#        Please wait           #
################################

######################
# Installing stress  #
######################
apt install -y stress

#########################
# Adding ansible PPA    #
#########################
apt install -y software-properties-common
apt-add-repository -y --update ppa:ansible/ansible

#######################
# Installing Ansible  #
#######################
apt install -y ansible

touch /tmp/finished

################################
#   Installation Complete      #
#        Please continue       #
################################