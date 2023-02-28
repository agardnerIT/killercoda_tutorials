## Change to 'git' user
Gitea needs to run as a non-root user.

All commands related to `gitea` need to be executed as the `git` user. Switch to that user now.

```
su -l git
```{{exec}}

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
```

## Push Repository
A local Git repo has been created for you at `~/flags`.

Login and push it to Gitea now. When prompted, the username and password are both `openfeature`:
```
su -l git
cd ~/flags
git remote add openfeature/flags {{TRAFFIC_HOST1_3000}}/openfeature/flags


```{{exec}}

## Clone Repo
```
tea clone openfeature/flags
cd flags
```{{exec}}

## Add Flag Values

Create and push a new file to the repo called `flags.json`.
