####################
# Installing NATS
#
# Please wait...
####################

helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm install my-nats nats/nats -n nats --create-namespace --wait

#################################
# 🎉 Installation Complete 🎉
# Please proceed...
#################################