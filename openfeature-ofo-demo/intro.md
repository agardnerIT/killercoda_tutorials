# Intro

# Hold Tight, Install In Progress...

Everything is being installed on the k8s cluster.

- Cert Manager
- OpenFeature k8s Operator
- OpenFeature demo application

Wait here until you see `🎉 Installation Complete 🎉`

# Expose the application

```
kubectl -n open-feature-demo port-forward --address 0.0.0.0 service/open-feature-demo-service 30000
```{{exec}}

# Visit Application

[View the OpenFeature Demo Application]({{ TRAFFIC_HOST1_30000 }})

# View the Feature Flag Configuration

The demo application pod is reading feature flag configurations from a CRD called `FeatureFlagConfiguration`{{}}. Show them now:

```
kubectl -n open-feature-demo get featureflagconfigurations
```{{}}

# Update Application Color Flag

Change the application color by updating the feature flag.


Modify line `28`{{}} of the `end-to-end.yaml` file and re-apply it.

You can use the built-in editor or a text editor like nano:
```
nano ~/end-to-end.yaml
```{{exec}}

Change `defaultVariant: blue` to `defaultVariant: green`.

Apply those changes:

```
kubectl apply -f ~/end-to-end.yaml
```{{exec}}

# View Changes

View the application again and within a few seconds the app should turn green.