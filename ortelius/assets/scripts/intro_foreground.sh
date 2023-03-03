# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
DEBUG_VERSION=1
POD_WAIT_TIMEOUT_MINS=10
ORTELIUS_VERSION=10.0.132
NGINX_PORT=30000

# ----------------------------------------#
#      Step 1/3: Update Helm             #
# ----------------------------------------#
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh
./get_helm.sh

# ----------------------------------------#
#      Step 2/3: Install Ortelius        #
# ----------------------------------------#

helm upgrade --install \
-n ortelius --create-namespace \
--wait \
--set ms-nginx.ingress.nodePort=$NGINX_PORT \
--set global.postgresql.enabled=true \
ortelius https://github.com/ortelius/ortelius-charts/releases/download/ortelius-$ORTELIUS_VERSION/ortelius-$ORTELIUS_VERSION.tgz

# --------------------------------------------#
#   Step 3/3: Expose Ortelius on port 30000  #
# --------------------------------------------#
nohup kubectl port-forward svc/ms-nginx 30000:80 &

#################################
# 🎉 Installation Complete 🎉  #
# Please proceed...             #
#################################