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

# Configure git for 'ubuntu' and 'git' users
sudo -u git git config --global user.email "me@openfeature.dev"
sudo -u git git config --global user.name "OpenFeature"

# Download 'gitea'
wget -O gitea https://dl.gitea.com/gitea/${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64
chmod +x gitea
mv gitea /usr/local/bin
chown git:git

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

# MOVED TO INTERACTIVE DUE TO EXT. LB INPUT
# Preconfigure 'gitea'
# Ref: https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini
# cat <<EOF > /etc/gitea/app.ini
# APP_NAME = "Gitea: Git with a cup of tea"
# RUN_USER = "git"
# [server]
# PROTOCOL = "http"
# DOMAIN = "https://1bf76cde-c9bd-41f9-a0e9-34018429b4b6-10-244-3-224-3000.papa.r.killercoda.com/"
# ROOT_URL = "https://1bf76cde-c9bd-41f9-a0e9-34018429b4b6-10-244-3-224-3000.papa.r.killercoda.com/"
# HTTP_ADDR = "0.0.0.0"
# HTTP_PORT = "3000"
# [database]
# DB_TYPE = "postgres"
# HOST = "0.0.0.0:5432"
# NAME = "giteadb"
# USER = "gitea"
# PASSWD = "gitea"
# [security]
# INSTALL_LOCK = true
# EOF
# chown -R git:git /etc/gitea

# MOVED TO INTERACTIVE
# # Start 'gitea' service
# systemctl start gitea

# MOVED TO INTERACTIVE
# # Initialise 'gitea' database
# # Note: 'gitea' cannot run as root so first login as 'git' user
# su -l git
# gitea migrate -c=/etc/gitea/app.ini

# MOVED TO INTERACTIVE
# # Create a 'gitea' user called 'openfeature'
# # This user is not forced to change their password
# gitea admin user create \
#   --username=openfeature \
#   --password=openfeature \
#   --email=me@openfeature.dev \
#   --must-change-password=false \
#   -c=/etc/gitea/app.ini

# MOVED TO INTERACTIVE
# # Generate an access token with 'repo' scope
# # For use 'openfeature'
# # The '--raw' flag promises only to output the token
# # But it seems to ALSO output additional lines
# # So pipe to a temporary file
# # Then immediately read the last line (token) into an env_var
# # And immediately delete the file
# gitea admin user generate-access-token \
#   --username=openfeature \
#   --scopes=repo \
#   -c=/etc/gitea/app.ini \
#   --raw > /tmp/output.log
# ACCESS_TOKEN=$(tail -n 1 /tmp/output.log)
# rm /tmp/output.log
# echo $ACCESS_TOKEN

# Create repo
su -l git
cd ~
git init flags
cd flags
cat <<EOF > flags.json
{
  "flags": {
    "myBoolFlag": {
      "state": "ENABLED",
      "variants": {
        "on": true,
        "off": false
      },
      "defaultVariant": "on"
    },
    "myStringFlag": {
      "state": "ENABLED",
      "variants": {
        "key1": "val1",
        "key2": "val2"
      },
      "defaultVariant": "key1"
    },
    "myFloatFlag": {
      "state": "ENABLED",
      "variants": {
        "one": 1.23,
        "two": 2.34
      },
      "defaultVariant": "one"
    },
    "myIntFlag": {
      "state": "ENABLED",
      "variants": {
        "one": 1,
        "two": 2
      },
      "defaultVariant": "one"
    },
    "myObjectFlag": {
      "state": "ENABLED",
      "variants": {
        "object1": {
          "key": "val"
        },
        "object2": {
          "key": true
        }
      },
      "defaultVariant": "object1"
    },
    "isColorYellow": {
      "state": "ENABLED",
      "variants": {
        "on": true,
        "off": false
      },
      "defaultVariant": "off",
      "targeting": {
        "if": [
          {
            "==": [
              {
                "var": [
                  "color"
                ]
              },
              "yellow"
            ]
          },
          "on",
          "off"
        ]
      }
    },
    "fibAlgo": {
      "variants": {
        "recursive": "recursive",
        "memo": "memo",
        "loop": "loop",
        "binet": "binet"
      },
      "defaultVariant": "recursive",
      "state": "ENABLED",
      "targeting": {
        "if": [
          {
            "$ref": "emailWithFaas"
          }, "binet", null
        ]
      }
    },
    "headerColor": {
      "variants": {
        "red": "#FF0000",
        "blue": "#0000FF",
        "green": "#00FF00",
        "yellow": "#FFFF00"
      },
      "defaultVariant": "red",
      "state": "ENABLED",
      "targeting": {
        "if": [
          {
            "$ref": "emailWithFaas"
          },
          {
            "fractionalEvaluation": [
              "email",
              [
                "red",
                25
              ],
              [
                "blue",
                25
              ],
              [
                "green",
                25
              ],
              [
                "yellow",
                25
              ]
            ]
          }, null
        ]
      }
    }
  },
  "$evaluators": {
    "emailWithFaas": {
      "in": ["@faas.com", {
        "var": ["email"]
      }]
    }
  }
}
EOF

tea login add \
  --name=openfeature \
  --user=openfeature \
  --password=openfeature \
  --url=https://fbd25e58-623b-45ff-b2e2-be6857cb6750-10-244-4-162-3000.papa.r.killercoda.com/ \
  --token=$ACCESS_TOKEN

# # Uneccessary due to above creation
# tea repo create \
#   --name=flags \
#   --init

# tea clone openfeature/flags
# cd flags
# cat <<EOF > flags.json
# {
#   "flags": {
#     "myBoolFlag": {
#       "state": "ENABLED",
#       "variants": {
#         "on": true,
#         "off": false
#       },
#       "defaultVariant": "on"
#     },
#     "myStringFlag": {
#       "state": "ENABLED",
#       "variants": {
#         "key1": "val1",
#         "key2": "val2"
#       },
#       "defaultVariant": "key1"
#     },
#     "myFloatFlag": {
#       "state": "ENABLED",
#       "variants": {
#         "one": 1.23,
#         "two": 2.34
#       },
#       "defaultVariant": "one"
#     },
#     "myIntFlag": {
#       "state": "ENABLED",
#       "variants": {
#         "one": 1,
#         "two": 2
#       },
#       "defaultVariant": "one"
#     },
#     "myObjectFlag": {
#       "state": "ENABLED",
#       "variants": {
#         "object1": {
#           "key": "val"
#         },
#         "object2": {
#           "key": true
#         }
#       },
#       "defaultVariant": "object1"
#     },
#     "isColorYellow": {
#       "state": "ENABLED",
#       "variants": {
#         "on": true,
#         "off": false
#       },
#       "defaultVariant": "off",
#       "targeting": {
#         "if": [
#           {
#             "==": [
#               {
#                 "var": [
#                   "color"
#                 ]
#               },
#               "yellow"
#             ]
#           },
#           "on",
#           "off"
#         ]
#       }
#     },
#     "fibAlgo": {
#       "variants": {
#         "recursive": "recursive",
#         "memo": "memo",
#         "loop": "loop",
#         "binet": "binet"
#       },
#       "defaultVariant": "recursive",
#       "state": "ENABLED",
#       "targeting": {
#         "if": [
#           {
#             "$ref": "emailWithFaas"
#           }, "binet", null
#         ]
#       }
#     },
#     "headerColor": {
#       "variants": {
#         "red": "#FF0000",
#         "blue": "#0000FF",
#         "green": "#00FF00",
#         "yellow": "#FFFF00"
#       },
#       "defaultVariant": "red",
#       "state": "ENABLED",
#       "targeting": {
#         "if": [
#           {
#             "$ref": "emailWithFaas"
#           },
#           {
#             "fractionalEvaluation": [
#               "email",
#               [
#                 "red",
#                 25
#               ],
#               [
#                 "blue",
#                 25
#               ],
#               [
#                 "green",
#                 25
#               ],
#               [
#                 "yellow",
#                 25
#               ]
#             ]
#           }, null
#         ]
#       }
#     }
#   },
#   "$evaluators": {
#     "emailWithFaas": {
#       "in": ["@faas.com", {
#         "var": ["email"]
#       }]
#     }
#   }
# }
# EOF
# # username: openfeature
# # password: openfeature
# git add -A && git commit -m "add flags" && git push


# flagd start \
#   --port 8013 \
#   --uri https://fbd25e58-623b-45ff-b2e2-be6857cb6750-10-244-4-162-3000.papa.r.killercoda.com/openfeature/foo/raw/branch/main/flags.json


# # Open a new terminal
# curl -X POST http://localhost:8013/schema.v1.Service/ResolveString \
#   -H "Content-Type: application/json" \
#   -d '{"flagKey": "headerColor", "context": {}}'

# curl -X POST http://localhost:8013/schema.v1.Service/ResolveString \
#   -H "Content-Type: application/json" \
#   -d '{"flagKey": "headerColor", "context": { "email": "user@faas.com"}}'

# BACKUP
# tea login add \
#   --name=openfeature \
#   --user=openfeature \
#   --password=openfeature \
#   --url={{TRAFFIC_HOST1_3000}} \
#   --token=$ACCESS_TOKEN