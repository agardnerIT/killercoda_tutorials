GITEA_VERSION=1.19
TEA_CLI_VERSION=0.9.2
FLAGD_VERSION=0.3.7

# Download and install flagd
wget -O flagd.tar.gz https://github.com/open-feature/flagd/releases/download/v${FLAGD_VERSION}/flagd_${FLAGD_VERSION}_Linux_x86_64.tar.gz
tar -xf flagd.tar.gz
chmod +x flagd
mv flagd /usr/local/bin

# Download and install 'gitea' CLI: 'tea'
wget -O tea https://dl.gitea.com/tea/${TEA_CLI_VERSION}/tea-${TEA_CLI_VERSION}-linux-amd64
chmod +x tea
mv tea /usr/local/bin

#################
# Install postgresql for Gitea
###################
# Create the file repository configuration:
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update the package lists:
sudo apt-get update

# Install the latest version of PostgreSQL.
# If you want a specific version, use 'postgresql-12' or similar instead of 'postgresql':
sudo apt-get -y install postgresql

# Set up gitea DB
sudo -u postgres -H -- psql --command "CREATE ROLE gitea WITH LOGIN PASSWORD 'gitea';"
sudo -u postgres -H -- psql --command "CREATE DATABASE giteadb WITH OWNER gitea TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';"

# Add 'git' user
adduser \
  --system \
  --shell /bin/bash \
  --gecos 'Git Version Control' \
  --group \
  --disabled-password \
  --home /home/git \
  git

# Configure git for 'ubuntu' and 'git' users
sudo -u git git config --global user.email "me@openfeature.dev"
sudo -u git git config --global user.name "OpenFeature"

# Download 'gitea'
wget -O gitea https://dl.gitea.com/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64
chmod +x gitea
mv gitea /usr/local/bin
chown git:git /usr/local/bin/gitea

# Set up directory structure for 'gitea'
mkdir -p /var/lib/gitea/{custom,data,log}
chown -R git:git /var/lib/gitea/
chmod -R 750 /var/lib/gitea/
mkdir /etc/gitea
chown git:git /etc/gitea
chmod 770 /etc/gitea

# Create systemd service for 'gitea'
# Ref: https://github.com/go-gitea/gitea/blob/main/contrib/systemd/gitea.service
cat <<EOF > /etc/systemd/system/gitea.service
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target

Wants=postgresql.service
After=postgresql.service

[Service]
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/var/lib/gitea/
ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini
Restart=always
Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/var/lib/gitea

[Install]
WantedBy=multi-user.target
EOF