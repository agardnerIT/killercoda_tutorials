# DEBUG V2

add-apt-repository -y ppa:deadsnakes/ppa
apt install -y python3.10

wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
tar -xf node-v16.18.0-linux-x64.tar.xz
mv node-v16.18.0-linux-x64/bin/node /usr/bin/node
mv node-v16.18.0-linux-x64/bin/npm /usr/bin/npx

curl -sSL https://install.python-poetry.org | python3 -

git clone https://github.com/dynatrace-oss/Kalm-Benchmark

poetry install

echo PATH=/usr/bin/python3.10:/root/.local/bin:$PATH >> ~/.bashrc
. ~/.bashrc