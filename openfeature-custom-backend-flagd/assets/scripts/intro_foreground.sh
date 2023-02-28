GITEA_VERSION=1.19
TEA_CLI_VERSION=0.9.2

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

# Create gitea DB
su -l postgres
cat <<EOF > ~/createdb.sql
CREATE ROLE gitea WITH LOGIN PASSWORD 'gitea';
CREATE DATABASE giteadb WITH OWNER gitea TEMPLATE template0 ENCODING UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
EOF
psql -f ~/createdb.sql
exit

# Add 'git' user
adduser \
   --system \
   --shell /bin/bash \
   --gecos 'Git Version Control' \
   --group \
   --disabled-password \
   --home /home/git \
   git

# Download 'gitea'
wget -O gitea https://dl.gitea.com/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64
chmod +x gitea
mv gitea /usr/local/bin

# Set up directory structure for 'gitea'
mkdir -p /var/lib/gitea/{custom,data,log}
chown -R git:git /var/lib/gitea/
chmod -R 750 /var/lib/gitea/
mkdir /etc/gitea
chown git:git /etc/gitea
chmod 770 /etc/gitea

# Create systemd service for 'gitea'
cat <<EOF > /etc/systemd/system/gitea.service
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target
###
# Don't forget to add the database service dependencies
###

Wants=postgresql.service
After=postgresql.service
###
# If using socket activation for main http/s
###
#
#After=gitea.main.socket
#Requires=gitea.main.socket
#
###
# (You can also provide gitea an http fallback and/or ssh socket too)
#
# An example of /etc/systemd/system/gitea.main.socket
###
##
## [Unit]
## Description=Gitea Web Socket
## PartOf=gitea.service
##
## [Socket]
## Service=gitea.service
## ListenStream=<some_port>
## NoDelay=true
##
## [Install]
## WantedBy=sockets.target
##
###

[Service]
# Uncomment the next line if you have repos with lots of files and get a HTTP 500 error because of that
# LimitNOFILE=524288:524288
RestartSec=2s
Type=simple
User=git
Group=git
WorkingDirectory=/var/lib/gitea/
# If using Unix socket: tells systemd to create the /run/gitea folder, which will contain the gitea.sock file
# (manually creating /run/gitea doesn't work, because it would not persist across reboots)
#RuntimeDirectory=gitea
ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini
Restart=always
Environment=USER=git HOME=/home/git GITEA_WORK_DIR=/var/lib/gitea
# If you install Git to directory prefix other than default PATH (which happens
# for example if you install other versions of Git side-to-side with
# distribution version), uncomment below line and add that prefix to PATH
# Don't forget to place git-lfs binary on the PATH below if you want to enable
# Git LFS support
#Environment=PATH=/path/to/git/bin:/bin:/sbin:/usr/bin:/usr/sbin
# If you want to bind Gitea to a port below 1024, uncomment
# the two values below, or use socket activation to pass Gitea its ports as above
###
#CapabilityBoundingSet=CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_BIND_SERVICE
###
# In some cases, when using CapabilityBoundingSet and AmbientCapabilities option, you may want to
# set the following value to false to allow capabilities to be applied on gitea process. The following
# value if set to true sandboxes gitea service and prevent any processes from running with privileges
# in the host user namespace.
###
#PrivateUsers=false
###

[Install]
WantedBy=multi-user.target
EOF

# Preconfigure 'gitea'
# Ref: https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini
cat <<EOF > /etc/gitea/app.ini
APP_NAME = "Gitea: Git with a cup of tea"
RUN_USER = "git"
[server]
PROTOCOL = "http"
DOMAIN = "https://8748a7e9-c8dc-4383-bf14-73eb63363e15-10-244-4-120-3000.papa.r.killercoda.com"
ROOT_URL = "https://8748a7e9-c8dc-4383-bf14-73eb63363e15-10-244-4-120-3000.papa.r.killercoda.com"
HTTP_ADDR = "0.0.0.0"
HTTP_PORT = "3000"
[database]
DB_TYPE = "postgres"
HOST = "0.0.0.0:5432"
NAME = "giteadb"
USER = "gitea"
PASSWD = "gitea"
[security]
INSTALL_LOCK = true
EOF
chown -R git:git /etc/gitea

# Start 'gitea' service
systemctl start gitea

# Initialise 'gitea' database
# Note: 'gitea' cannot run as root so first login as 'git' user
su -l git
gitea migrate -c=/etc/gitea/app.ini

# Create a 'gitea' user called 'openfeature'

gitea admin user create \
  --username=openfeature \
  --password=openfeature \
  --email=me@openfeature.dev \
  --must-change-password=false \
  -c /etc/gitea/app.ini
exit

# Download and install flagd
wget -O flagd.tar.gz https://github.com/open-feature/flagd/releases/download/v0.3.7/flagd_0.3.7_Linux_x86_64.tar.gz
tar -xf flagd.tar.gz
chmod +x flagd
mv flagd /usr/local/bin

# Download and install 'gitea' CLI: 'tea'
wget -O tea https://dl.gitea.com/tea/${TEA_CLI_VERSION}/tea-${TEA_CLI_VERSION}-linux-amd64
chmod +x tea
mv tea /usr/local/bin

# Authenticate CLI
tea login add \
  --name=openfeature \
  --user=openfeature \
  --password=openfeature \
  --url=https://8748a7e9-c8dc-4383-bf14-73eb63363e15-10-244-4-120-3000.papa.r.killercoda.com

# Create repo

