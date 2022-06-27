################################
#     Installing Software      #
#        Please wait           #
################################

# Adding ansible PPA 
apt install -y software-properties-common
apt-add-repository -y --update ppa:ansible/ansible

# Installing Ansible
apt install -y ansible

# Installing stress
apt install -y stress

################################
#  🎉 Installation Complete    #
#        Please continue       #
################################