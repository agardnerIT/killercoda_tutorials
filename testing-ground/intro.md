# Intro

Test with:

```
<<<<<<< HEAD
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait
```{{exec}}

Clone repo:

```
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git
cd lifecycle-toolkit-examples
```{{exec}}
Install cert-manager (Jaeger requires it):

```
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.11.0 \
  --set installCRDs=true
```{{exec}}

Install Jaeger:

```
kubectl create ns observability
kubectl apply -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.42.0/jaeger-operator.yaml -n observability
kubectl wait --for=condition=available deployment/jaeger-operator -n observability --timeout=300s
kubectl apply -f ~/lifecycle-toolkit-examples/support/observability/config/jaeger.yaml -n keptn-lifecycle-toolkit-system
=======
pyrsia --version
>>>>>>> 1a6304457566d7d05a20c715b79fee489dd9a8c1
```{{exec}}