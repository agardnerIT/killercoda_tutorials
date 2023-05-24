# Install NATS Server
wget https://github.com/nats-io/nats-server/releases/download/v2.9.17/nats-server-v2.9.17-amd64.deb
dpkg -i nats-server-v2.9.17-amd64.deb

# Install NATS CLI (Client)
wget https://github.com/nats-io/natscli/releases/download/v0.0.35/nats-0.0.35-amd64.deb
dpkg -i nats-0.0.35-amd64.deb

# Install Python NATS Package
pip install nats-py

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################