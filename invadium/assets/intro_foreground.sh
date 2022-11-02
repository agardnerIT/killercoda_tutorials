# DEBUG_VERSION=2
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6

# kubectl
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# kubernetes
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create mykeptn -p "3000:3000@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"

# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh
./get_helm.sh

# clone invadium
git clone https://github.com/dynatrace-oss/invadium
cd invadium

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#