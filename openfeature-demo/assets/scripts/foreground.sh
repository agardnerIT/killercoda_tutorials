# Step [1/3]: Install docker compose
sudo apt update
sudo apt install -y docker-compose

# Step [2/3]: Clone Repo and check out PR
git clone https://github.com/open-feature/playground
cd playground
git pull origin pull/59/head

# Step [3/3]: Start things up!
docker compose up

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#