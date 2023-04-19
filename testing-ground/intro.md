# Intro

```
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
```{{exec}}

Install:

```
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait
```{{exec}}

Clone repo:

```
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git
cd lifecycle-toolkit-examples
```{{exec}}

Install Jaeger:

```
kubectl apply -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.42.0/jaeger-operator.yaml -n observability
kubectl wait --for=condition=available deployment/jaeger-operator -n observability --timeout=300s
kubectl apply -f config/jaeger.yaml -n "keptn-lifecycle-toolkit-system"
```{{exec}}