#!/bin/bash

# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
K3D_VERSION=v5.3.0
KUBECTL_VERSION=v1.22.6
KEPTN_VERSION=0.17.0
ARGO_VERSION=v2.4.7
ARGO_USERNAME=admin
GITEA_VERSION=5.0.9
GITEA_CLI_VERSION=0.8.0
GITEA_PORT=3000
GITEA_ADMIN_USER=keptn
GITEA_ADMIN_PASSWORD=keptndemo
GITEA_ADMIN_EMAIL=keptn@keptn.sh
DEMO_APP_ORG=podtato-head
DEMO_APP_REPO=podtato-head

# --------------------------------------------#
#      Step X/Y: Clone Podtato Head App       #
# --------------------------------------------#
cd ~
git clone https://github.com/$DEMO_APP_ORG/$DEMO_APP_REPO

# ----------------------------------------#
#      Step X/Y: Installing Kubectl       #
# ----------------------------------------#
curl -LO https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# -----------------------------------------#
#      Step X/Y: Installing Keptn CLI      #
# -----------------------------------------#
curl -sL https://get.keptn.sh | KEPTN_VERSION=$KEPTN_VERSION bash

# -----------------------------------------#
#      Step X/Y: Installing ArgoCD CLI     #
# -----------------------------------------#
mkdir argocd && cd argocd
wget https://github.com/argoproj/argo-cd/releases/download/$ARGO_VERSION/argocd-linux-amd64
mv argocd-linux-amd64 argocd && chmod +x argocd && sudo mv argocd /usr/local/bin

# ------------------------------------------#
#      Step X/Y: Installing Gitea CLI (tea) #
# ------------------------------------------#
wget https://dl.gitea.io/tea/$GITEA_CLI_VERSION/tea-$GITEA_CLI_VERSION-linux-amd64
mv tea-$GITEA_CLI_VERSION-linux-amd64 tea && chmod +x tea && sudo mv tea /usr/local/bin

# -----------------------------------------#
#    Step X/Y: Initialising Kubernetes     #
# -----------------------------------------#
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=$K3D_VERSION bash
k3d cluster create mycluster \
-p "8080:80@loadbalancer" \
-p "3000:3000@loadbalancer" \
--k3s-arg "--no-deploy=traefik@server:*"

# -----------------------------------------#
#    Step X/Y: Install ArgoCD              #
# -----------------------------------------#
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# -----------------------------------------#
#    Step X/Y: Authenticate Argo CLI       #
# -----------------------------------------#
ARGO_IP=""
while [ -z "$ARGO_IP" ]; do
  sleep 2
  ARGO_IP=$(kubectl get service argocd-server -o jsonpath={.status.loadBalancer.ingress[0].ip})
done
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d ; echo)

argocd login $ARGO_IP --username $ARGO_USERNAME --password $ARGO_PASSWORD --insecure
CURRENT_CONTEXT=$(kubectl config current-context)
argocd cluster add -y $CURRENT_CONTEXT

# -----------------------------------------#
#    Step X/Y: Install Gitea with ArgoCD   #
# -----------------------------------------#
kubectl create ns gitea
argocd app create gitea \
--repo https://dl.gitea.io/charts/ \
--helm-chart gitea \
--revision $GITEA_VERSION \
--dest-namespace gitea \
--dest-server https://kubernetes.default.svc \
--helm-set service.http.type=LoadBalancer \
--helm-set service.http.port=$GITEA_PORT \
--helm-set gitea.admin.username=$GITEA_ADMIN_USER \
--helm-set gitea.admin.password=$GITEA_ADMIN_PASSWORD \
--helm-set gitea.admin.email=$GITEA_ADMIN_EMAIL
argocd app sync gitea

# -----------------------------------------#
#    Step X/Y: Authenticate Gitea CLI      #
# -----------------------------------------#
GITEA_IP=""
while [ -z "$GITEA_IP" ]; do
  sleep 2
  GITEA_IP=$(kubectl get service gitea-http -o jsonpath={.status.loadBalancer.ingress[0].ip})
done
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d ; echo)
tea login add --url http://$GITEA_IP:$GITEA_PORT/ --user $GITEA_ADMIN_USER --password $GITEA_ADMIN_PASSWORD

# ---------------------------------------------#
#    Step X/Y: Create Podtato Head Gitea Repo  #
# ---------------------------------------------#
tea repo create --name $DEMO_APP_REPO --branch main
cd ~/$DEMO_APP_REPO
git remote set-url origin http://$GITEA_ADMIN_USER:$GITEA_ADMIN_PASSWORD@$GITEA_IP:$GITEA_PORT/$GITEA_ADMIN_USER/$DEMO_APP_REPO
git push

# -----------------------------------------#
#    Step X/Y: Install Keptn with ArgoCD   #
# -----------------------------------------#
kubectl create ns keptn
argocd app create keptn \
--repo https://charts.keptn.sh \
--helm-chart keptn \
--revision $KEPTN_VERSION \
--dest-namespace keptn \
--dest-server https://kubernetes.default.svc \
--helm-set apiGatewayNginx.type=LoadBalancer
argocd app sync keptn

# touch a file that foreground.sh is waiting for before proceeding
touch /tmp/finished
