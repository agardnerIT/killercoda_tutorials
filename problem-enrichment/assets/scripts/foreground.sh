################################
#     Installing Software      #
#        Please wait           #
################################
apt update
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible stress -y

################################
#  🎉 Installation Complete    #
#        Please continue       #
################################