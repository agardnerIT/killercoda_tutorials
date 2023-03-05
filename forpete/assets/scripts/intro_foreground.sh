curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - &&\
apt install -y nodejs < /dev/null
apt install -y jq < /dev/null
mkdir app
cd app
npm init -y
mv package.json package.BAK.json
cat package.BAK.json | jq '. += { "type": "module" }' > package.json

npm install express --save
npm install express-promise-router --save
npm install cowsay --save