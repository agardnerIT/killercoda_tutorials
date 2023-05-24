NATS_SERVER_VERSION=v2.9.17
NATS_CLI_VERSION=0.0.35
CD_EVENTS_SPEC_TAG=spec-v0.3
# Install NATS Server
wget https://github.com/nats-io/nats-server/releases/download/$NATS_SERVER_VERSION/nats-server-$NATS_SERVER_VERSION-amd64.deb
dpkg -i nats-server-$NATS_SERVER_VERSION-amd64.deb

# Install NATS CLI (Client)
wget https://github.com/nats-io/natscli/releases/download/v$NATS_CLI_VERSION/nats-$NATS_CLI_VERSION-amd64.deb
dpkg -i nats-$NATS_CLI_VERSION-amd64.deb

# Install Python NATS Package
pip install nats-py

# Retrieve example cloud events
git clone --depth 1 --branch $CD_EVENTS_SPEC_TAG https://github.com/cdevents/spec

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################