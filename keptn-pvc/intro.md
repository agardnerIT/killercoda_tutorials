# Port forward to open up the bridge
```
kubectl -n keptn port-forward svc/api-gateway-nginx --address=0.0.0.0 80:80
```