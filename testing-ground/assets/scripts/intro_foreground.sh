DEBUG_VERSION=9
PLAYGROUND_APP_VERSION=v0.7.1
JAEGER_VERSION=1.42
FLAGD_VERSION=v0.4.4
GO_FEATURE_FLAG_VERSION=v1.4.0

#################################################################
# Step [1/3]: Install docker compose plugin
#################################################################
sudo apt update  < "/dev/null"
sudo apt install -y ca-certificates curl gnupg lsb-release  < "/dev/null"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update  < "/dev/null"
sudo apt install -y docker-compose-plugin  < "/dev/null"

###################################################################
# Step [2/3]: Clone Repo and checkout feat/client-flags branch
###################################################################
git clone https://github.com/open-feature/playground
cd playground
git fetch --all --tags
git checkout tags/${PLAYGROUND_APP_VERSION}

# Pull images for faster startup
docker pull ghcr.io/open-feature/playground-app:${PLAYGROUND_APP_VERSION}
docker pull ghcr.io/open-feature/playground-fib-service:${PLAYGROUND_APP_VERSION}
docker pull jaegertracing/all-in-one:${JAEGER_VERSION}
docker pull ghcr.io/open-feature/flagd:${FLAGD_VERSION}
docker pull thomaspoignant/go-feature-flag-relay-proxy:${GO_FEATURE_FLAG_VERSION}


###################################################################
# Step [3/3]: Start things up!
###################################################################
#docker compose up --detach

# ---------------------------------------------#
#       🎉 Preparation Complete 🎉            #
#           Please proceed now...              #
# ---------------------------------------------#
