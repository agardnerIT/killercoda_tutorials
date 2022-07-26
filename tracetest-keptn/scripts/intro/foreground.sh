# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
HELM_VERSION=v3.9.2
KEPTN_VERSION=0.17.0
JOB_EXECUTOR_SERVICE_VERSION=0.2.3

wget https://get.helm.sh/helm-$HELM_VERSION-linux-386.tar.gz
gzip -d helm-$HELM_VERSION-linux-386.tar.gz
tar -xf helm-$HELM_VERSION-linux-386.tar
sudo cp linux-386/helm /usr/local/bin/helm
git clone https://github.com/kubeshop/tracetest
cd tracetest
./setup.sh
kubectl --namespace tracetest patch svc/tracetest -p '{"spec": {"ports": [{"port": 8080,"targetPort": 8080,"name": "http"}],"type": "LoadBalancer"}}'

# ---------------------------------------------#
#       🎉 Installation Complete 🎉          #
#           Please proceed now...              #
# ---------------------------------------------#