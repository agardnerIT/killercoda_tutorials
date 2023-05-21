# The Demo Application
For this demonstration, we use [the PodTatoHead application](https://github.com/podtato-head/podtato-head).

Let's attempt to deploy version 1 of the application now:

```
make deploy-version-1
```{{exec}}

Now view the pods:

```
kubectl -n podtato-kubectl get pods
```{{exec}}

## Expected Result

Version 1 has an issue meaning the pods are pending. We will now use the observability tooling to help understand why.

## View Observability Data

View the [Keptn Applications Grafana dashboard]({{TRAFFIC_HOST1_3000}}/d/nbiPNgN4z/keptn-applications?orgId=1&refresh=5s). Username = `admin`, password = `admin`.

The overview panels show the current status of the deployment. The traces table shows a list of OTEL traces for each deployment. Clicking a trace will take you to Jaeger.

You can also directly view the deployment traces by [clicking this link]({{TRAFFIC_HOST1_16686}}/search?limit=20&lookback=1h&maxDuration&minDuration&service=lifecycle-operator&tags=%7B%22keptn.deployment.app.name%22%3A%22podtato-head%22%2C%22otel.library.name%22%3A%22keptn%2Foperator%2Fapp%22%2C%22span.kind%22%3A%22server%22%7D).

If the trace hasn't yet failed, it will. Just keep refreshing the page every few seconds.

Investigating the trace will show the following errors:

```
pre-eval-app-pre-deploy-eval... has failed
event="evaluation of 'available-cpus' failed with value: '2' and reason: 'value '2' did not meet objective '>100''"
```

You can also see these metrics are written to Prometheus. Search for `keptn_` metrics [in Prometheus]({{TRAFFIC_HOST1_9090}}).

## Summary: Reason for Failed Deployment
Keptn was asked to perform a pre-deployment infrastructure check. This check ensures that workloads are only scheduled when the number of available CPUs is more than 100.

In this system, there are not 100 CPUs and so the deployment is prevented.

KLT has **protected the cluster by preventing the deployment** because we do not have the desired resources.

Click next to dig deeper into how this occurred.