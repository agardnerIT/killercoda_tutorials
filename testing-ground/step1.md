# Visit Application

[View the OpenFeature Demo Application]({{TRAFFIC_HOST1_30000}})

# View Feature Flag

For this demo, we get flag definitions from the `FeatureFlag`{{}} custom resource definitions (CRDs) (see `end-to-end.yaml`{{}}).

The resource type is FeatureFlag and there are two instances defined:

- `ui-flags` (for the front-end)
- `app-flags` (for the back-end).

Below, you'll see how you can modify these instances to change your feature flags.

The `~/end-to-end.yaml`{{}} file also contains service and deployment definitions, but these need not be modified as part of this demo. You may be interested in the openfeature.dev/* annotations though, which the OpenFeature operator uses to detect which workloads require flagd.

- `openfeature.dev/enabled` setting this to true make operator to inject flagd as a sidecar
- `openfeature.dev/featureflagsource` refers to the FeatureFlagSource CRD which define flagd configurations, including its feature flag sources

In the given example, there's a FeatureFlagSource custom resource (CR) named `flag-sources`{{}}, configured to use the `FeatureFlag`{{}} CRs mentioned above.

In simple terms, you can think of a `FeatureFlagSource`{{}} instance as a resource that associates a workload with one or many `FeatureFlag`{{}} instances (though it has other purposes as well). You can lean more about these configurations from [flag source configuration documentation](https://github.com/open-feature/open-feature-operator/blob/main/docs/feature_flag_source.md)

Next, let's get started learning how OpenFeature is helping Fib3r manage this landing page!

The company has been in the process of changing the name of our app, but legal hasn't quite finished the process yet. Here, we've defined a simple feature flag that can be use to update the name instantly without redeploying our application.

Modify `~/end-to-end.yaml` (use `nano`{{}} or open the editor pane) and change the `"defaultVariant"`{{}} of the feature flag `new-welcome-message`{{}} to `"on"`{{}} in the `ui-flags`{{}} CR, then redeploy the change with:

```
kubectl apply -n default -f ~/end-to-end.yaml
```{{exec}}

Notice that the welcome message has changed from "Welcome to FaaS: Fibonacci as a Service!" to "Welcome to Fib3r: Fibonacci as a Service!".

Great! Now let's help the design team experiment with new color palette...