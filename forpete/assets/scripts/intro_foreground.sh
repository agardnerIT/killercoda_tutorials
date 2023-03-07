# DEBUG VERSION: 6

# -----------------------------------
# Step 1/4: Installing Node
# -----------------------------------
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
apt install -y nodejs < /dev/null

# -----------------------------------
# Step 2/4: Installing jq
# -----------------------------------
apt install -y jq < /dev/null

# -----------------------------------
# Step 3/4: Installing NPM packages
# -----------------------------------
npm install express --save
npm install express-promise-router --save
npm install cowsay --save
npm install @openfeature/js-sdk --save
npm install --force @moredip/openfeature-minimalist-provider

# -----------------------------------
# Step 4/4: Initialising NPM package
# -----------------------------------
cd app
npm init -y
mv package.json package.BAK.json
cat package.BAK.json | jq '. += { "type": "module" }' > package.json
rm package.BAK.json

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#