# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
DEBUG_VERSION=1
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6
POD_WAIT_TIMEOUT_MINS=10

# ----------------------------------------#
#      Step 1/11: Installing Kubectl      #
# ----------------------------------------#
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# -----------------------------------------#
#    Step 2/11: Initialising Kubernetes    #
# -----------------------------------------#
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create mykeptn -p "30000:30000@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"

# ----------------------------------------#
#      Step 3/11: Installing Helm         #
# ----------------------------------------#
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh
./get_helm.sh

helm upgrade --install \
-n ortelius --create-namespace \
ortelius https://github.com/ortelius/ortelius-charts/releases/download/ortelius-$ORTELIUS_VERSION/ortelius-$ORTELIUS_VERSION.tgz

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################