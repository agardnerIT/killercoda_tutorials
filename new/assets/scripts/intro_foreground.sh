DEBUG_VERSION=3

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
git checkout feat/client-flags
cp .env.example .env

###################################################################
# Step [3/3]: Start things up!
###################################################################
docker compose up --build --detach

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#
