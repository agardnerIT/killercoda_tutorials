
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.10.1 \
  --set installCRDs=true \
  --wait


helm repo add openfeature https://open-feature.github.io/open-feature-operator/
helm install ofo openfeature/ofo --wait

kubectl apply -f ~/end-to-end.yaml

# Expose port 30000 and access via traffic selector
#kubectl -n open-feature-demo port-forward --address 0.0.0.0 service/open-feature-demo-service 30000

# Get the FeatureFlagConfiguration
#kubectl -n open-feature-demo get featureflagconfigs

# change color from blue to green
#kubectl apply -f e2e.ff.yaml

#refresh the app and the background colour has now changed to green