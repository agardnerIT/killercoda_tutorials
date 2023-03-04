# Visit Application

[View the OpenFeature Demo Application]({{TRAFFIC_HOST1_30000}})

# View the Feature Flag Configuration

The demo application pod is reading feature flag configurations from a CRD called `FeatureFlagConfiguration`{{}}.

Display the `featureflagconfigurations`:

```
kubectl -n open-feature-demo get featureflagconfigurations
```{{exec}}

# Update Application Color Flag

Change the application color by updating the feature flag.

The flag definition is already available as a YAML file.

Modify line `23`{{}} of `~/feature-flag-configuration.yaml` file and re-apply it.

You can use the built-in editor or just click this::
Change `defaultVariant: blue`{{}} to `defaultVariant: green`{{}} and apply the changes.

```
sed -i 's/defaultVariant: blue/defaultVariant: green/g' ~/feature-flag-configuration.yaml
kubectl apply -f ~/feature-flag-configuration.yaml
```{{exec}}

# View Changes

View the application again and within a few seconds the app should turn green.