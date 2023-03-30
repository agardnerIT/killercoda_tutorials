# Intro.md

```
kubectl version --short
```{{exec}}

```
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait
```{{exec}}

```
kubectl get pods -n keptn-lifecycle-toolkit-system
```{{exec}}

```
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git
cd lifecycle-toolkit-examples
```{{exec}}

```
make install-observability
```{{exec}}

```
```{{exec}}

```
```{{exec}}