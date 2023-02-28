## Create Gitea configuration file
This file defines how Gitea will startup and behave. Create it now:

```
cat <<EOF > /etc/gitea/app.ini
APP_NAME = "Gitea: Git with a cup of tea"
RUN_USER = "git"
[server]
PROTOCOL = "http"
DOMAIN = "{{TRAFFIC_HOST1_3000}}"
ROOT_URL = "{{TRAFFIC_HOST1_3000}}"
HTTP_ADDR = "0.0.0.0"
HTTP_PORT = "3000"
[database]
DB_TYPE = "postgres"
HOST = "0.0.0.0:5432"
NAME = "giteadb"
USER = "gitea"
PASSWD = "gitea"
[repository]
ENABLE_PUSH_CREATE_USER = true
DEFAULT_PUSH_CREATE_PRIVATE = false
[security]
INSTALL_LOCK = true

EOF
chown -R git:git /etc/gitea
```{{exec}}

## Start Gitea

Start up and initialise Gitea:
```
systemctl start gitea
sudo -u git gitea migrate -c=/etc/gitea/app.ini
```{{exec}}

## Create Gitea User

Create a user so you can interact with Gitea.

```
su -l git
gitea admin user create \
   --username=openfeature \
   --password=openfeature \
   --email=me@openfeature.dev \
   --must-change-password=false \
   -c=/etc/gitea/app.ini

gitea admin user generate-access-token \
  --username=openfeature \
  --scopes=repo \
  -c=/etc/gitea/app.ini \
  --raw > /tmp/output.log
ACCESS_TOKEN=$(tail -n 1 /tmp/output.log)
rm /tmp/output.log

tea login add \
   --name=openfeature \
   --user=openfeature \
   --password=openfeature \
   --url={{TRAFFIC_HOST1_3000}} \
   --token=$ACCESS_TOKEN
```{{exec}}

## Create a repo

```
cd ~
tea create repo --name=flags --init=true
tea clone openfeature/flags
```{{exec}}
