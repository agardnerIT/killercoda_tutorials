# -----------------------------------------#
#        Setting Global variables          #
# -----------------------------------------#
DEBUG_VERSION=3
ORTELIUS_VERSION=10.0.462
NGINX_PORT=30000
ORTELIUS_NAMESPACE=ortelius

# ----------------------------------------#
#      Step 1/3: Update Helm             #
# ----------------------------------------#
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh
./get_helm.sh

# ----------------------------------------#
#      Step 2/3: Install Ortelius         #
# ----------------------------------------#
mkdir /tmp/postgres
helm repo add ortelius https://ortelius.github.io/ortelius-charts/
helm repo update
helm upgrade --install my-release ortelius/ortelius --set ms-general.dbpass=my_db_password --set global.postgresql.enabled=true --set ms-nginx.ingress.nodePort=${NGINX_PORT} --version "${ORTELIUS_VERSION}" --namespace ${ORTELIUS_NAMESPACE} --create-namespace --wait

# --------------------------------------------#
#   Step 3/3: Expose Ortelius on port 30000  #
# --------------------------------------------#
nohup kubectl port-forward svc/ms-nginx 30000:80 &

#################################
# 🎉 Installation Complete 🎉  #
# Please proceed...             #
#################################
