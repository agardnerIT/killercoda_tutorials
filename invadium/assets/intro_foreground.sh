# DEBUG_VERSION=7
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6

#####################################
#     Step 1/3: Install kubectl     #
#####################################
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#####################################
# Step 2/3: Install k3d Kubernetes  #
#####################################
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create myinvadium -p "3000:3000@loadbalancer" -p "3001:3001@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"

#####################################
#    Step 3/3: Clone Invadium       #
#####################################
git clone https://github.com/dynatrace-oss/invadium
cd invadium

# ---------------------------------------------#
#       🎉 Installation Complete 🎉           #
#           Please proceed now...              #
# ---------------------------------------------#