## Reset System

Use this Ansible playbook to:

1) Uninstall Apache
2) Install k3d (lightweight kubernetes)

```
ansible-playbook ~/playbooks/reset-system.yaml
```{{exec}}

## Start a Cluster

```
k3d cluster create mycluster -p "80:80@loadbalancer" --k3s-arg "--no-deploy=traefik@server:*"
```{{exec}}

## Verify Cluster

`kubectl get nodes`{{exec}} should now work.

## Deploy Nginx

```
cd
cat << EOF >> install_nginx.yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
EOF
kubectl apply -f ~/install_nginx.yaml
```{{exec}}

## Check Progress and Verify Deployment

Watch the output of `kubectl get pods`{{exec}} until the pods are Running.

Validate that Nginx is running on port 80 [here]({{TRAFFIC_HOST1_80}})

> Note: This will not show in the DT releases screen yet.