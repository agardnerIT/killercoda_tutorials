# DEBUG_VERSION=3
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6

# kubectl
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# kubernetes
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create mykeptn -p "3000:3000@loadbalancer" -p "3001:3001@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"

# clone invadium
git clone https://github.com/dynatrace-oss/invadium
cd invadium
wget https://gist.githubusercontent.com/agardnerIT/cb209f6d3f6678b0332f5f87d6eec16b/raw/6bfda1f7cd125956629571a395fccce87311a7eb/invadium_total.yaml

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#