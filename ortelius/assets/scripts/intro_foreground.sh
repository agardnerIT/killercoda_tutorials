ORTELIUS_VERSION=10.0.97

helm install -n ortelius --create-namespace ortelius https://github.com/ortelius/ortelius-charts/releases/download/ortelius-$ORTELIUS_VERSION/ortelius-$ORTELIUS_VERSION.tgz

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################