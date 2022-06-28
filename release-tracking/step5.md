# Track Deployments in Dynatrace

Modify the deployment [following the Dynatrace documentation](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation/release-monitoring/version-detection-strategies#kubernetes).

Add labels to the deployment:

1. `app.kubernetes.io/version` tracks the version (equivalent to `DT_RELEASE_VERSION` environment variable).
2. `app.kubernetes.io/part-of` tracks the product (equivalent to `DT_RELEASE_PRODUCT` environment variable).
3. `dynatrace-release-stage` tracks the stage (equivalent to `DT_RELEASE_STAGE` environment variable).

Clicking the following code block will make these changes for you and re-deploy Nginx.

```
cat << EOF > ~/upgrade_nginx.yaml
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
        app.kubernetes.io/version: 1.14.2
        app.kubernetes.io/part-of: product2
        dynatrace-release-stage: dev
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
        env:
        - name: DT_RELEASE_VERSION
          value: "1.14.2"
        - name: DT_RELEASE_PRODUCT
          value: "product2"
        - name: DT_RELEASE_STAGE
          value: "dev"
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
kubectl apply -f ~/upgrade_nginx.yaml
```{{exec}}