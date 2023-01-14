# Update system and install base tooling
sudo apt-get update
sudo apt-get install -y wget gnupg

# Add the Pyrsia keys to verify packages
wget -q -O - https://repo.pyrsia.io/repos/Release.key |  gpg --dearmor  > pyrsia.gpg
sudo install -o root -g root -m 644 pyrsia.gpg /etc/apt/trusted.gpg.d/
rm pyrsia.gpg
echo "deb https://repo.pyrsia.io/repos/nightly focal main" | sudo tee -a /etc/apt/sources.list > /dev/null
sudo apt-get update

# Install
sudo apt-get install -y pyrsia

# Allow foreground script to proceed
touch /tmp/finished