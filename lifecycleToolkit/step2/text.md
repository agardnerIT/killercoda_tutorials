## Prefer to read code?
If you prefer to dig through the code, you'll find it in the various folders here: `cd ~/lifecycle-toolkit-examples/sample-app/`{{exec}}.

## Step 1: Namespace Annotation

The Lifecycle toolkit first relies on the target namespace being annotated. This causes KLT to act upon that namespace. Describe the `podtato-kubectl`{{}} namespace:

```
kubectl describe namespace podtato-kubectl
```{{exec}}

It has an annotation: `keptn.sh/lifecycle-toolkit: enabled`{{}}

You can see this in the demo code:

```
head -n 7 ~/lifecycle-toolkit-examples/sample-app/base/manifest.yaml
```{{exec}}

## Step 2: Workload Labels

Keptn only targets workloads with certain labels.

You can either use the Kubernetes recommended labels:

```
app.kubernetes.io/part-of: myAwesomeAppName
app.kubernetes.io/name: myAwesomeWorkload
app.kubernetes.io/version: myAwesomeWorkloadVersion
```

or Keptn ones. Both sets are equivalent - choose whichever you prefer:

```
keptn.sh/app: myAwesomeAppName
keptn.sh/workload: myAwesomeWorkload
keptn.sh/version: myAwesomeWorkloadVersion
```

You can see this in the demo code:

```
cat ~/lifecycle-toolkit-examples/sample-app/base/manifest.yaml
```{{exec}}

## Step 3: Create KeptnApp Custom Resource

In real-life, your "application" rarely consists of only a single `Deployment`{{}}. Your `application`{{}} will most be a set of related `Deployment`{{}} manifests.

Kubernetes does not (yet) have the concept of an application, so [KeptnApp](https://lifecycle.keptn.sh/docs/concepts/apps/) is a Custom Resource that allows you to bundle multiple workloads into a single logical application.

The `name`{{}} and `version`{{}} fields must match the labels you applied above.

You can see a sample here:

```
cat ~/lifecycle-toolkit-examples/sample-app/base/app.yaml
```{{exec}}

## Step 4: Pre and Post Deployment Actions

KLT allows two types of pre and post deployment action on both the (individual) workload level and at the KeptnApp level:

- [KeptnTaskDefinitions](https://lifecycle.keptn.sh/docs/concepts/tasks/)
- [KeptnEvaluationDefinitions](https://lifecycle.keptn.sh/docs/concepts/evaluations/)

### Pre-Deployment Actions

Pre-deployment actions fire **before** the pod has been bound to the node. Tasks fire before evaluations. If pre-deployment actions fail, the pod will not be allowed to be bound and will result in a pending pod.

Pre-deployment actions are useful for:

- Checking that dependencies are available
- Ensuring you are not in a maintenance window
- Checking any other pre-conditions that may prevent or hinder a successful deployment.

### Post-Deployment Actions

Post-deployment actions fire **after** the pod has been successfully bound to the node and is in a running state.

Post-deployment actions are useful for:

- Performing arbitrary, complex logic (beyond the scope of Kubernetes readiness probes) to ensure the application is actually running and useful for users
- Ensuring downstream systems and third parties are still operational
- Checking SLOs to ensure the deployment hasn't caused a service degradation 

Workload level actions fire before application level actions.

Looking at the `v1`{{}} manifest, notice a label applied to each workload:

```
keptn.sh/pre-deployment-tasks: pre-deployment-check-frontend
```{{}}

View the file by clicking this text:

```
cat ~/lifecycle-toolkit-examples/sample-app/version-1/manifest.yaml
```{{exec}}

This references a [KeptnTaskDefinition](https://lifecycle.keptn.sh/docs/concepts/tasks/) called `pre-deployment-check-frontend`{{}}  which you write. Multiple (comma separated) tasks are allowed.

View all [KeptnTaskDefinitions](https://lifecycle.keptn.sh/docs/concepts/tasks/) in a given namespace:

```
kubectl -n podtato-kubectl get keptntaskdefinitions
```{{exec}}

Inspect the [KeptnTaskDefinition](https://lifecycle.keptn.sh/docs/concepts/tasks/):

```
kubectl -n podtato-kubectl describe keptntaskdefinition pre-deployment-check-frontend
```{{exec}}

This task takes a parameter (the URL) and a [remotely hosted JavaScript function](https://raw.githubusercontent.com/keptn-sandbox/lifecycle-controller/main/functions-runtime/samples/ts/http.ts) which simply does a fetch of the application endpoint in the cluster to check it is running.

A post-deployment task is configured using the label: `keptn.sh/post-deployment-tasks`{{}}.

## Pre and Post Deployment Evaluations

Similar to tasks, evaluations can occur at both the workload and application levels. 

During evaluations, KLT will retrieve [KeptnMetrics](https://lifecycle.keptn.sh/docs/concepts/metrics/#keptn-metric) from a [KeptnMetricsProvider](https://lifecycle.keptn.sh/docs/concepts/metrics) source (eg. Prometheus or any other metric storage solution) and evaluate a condition.

In the demo system, the workloads do not have any evaluations, but the [KeptnApp](https://lifecycle.keptn.sh/docs/concepts/apps) has a single `preDeploymentEvaluation`.

```
cat ~/lifecycle-toolkit-examples/sample-app/version-1/app.yaml 
```{{exec}}

View the definition:

```
kubectl -n podtato-kubectl describe keptnevaluationdefinition app-pre-deploy-eval-1
```{{exec}}

The evaluation uses a [KeptnMetric](https://lifecycle.keptn.sh/docs/concepts/metrics/#keptn-metric) called `available-cpus`{{}} and has a threshold of `>100`{{}}. If the value of `available-cpus`{{}} is `<=100`{{}} this pre-evaluation will fail and thus the pod will remain in a pending state.

To understand **where** the `available-cpus`{{}} data is retrieved from, look at the `KeptnMetric`{{}}.

```
kubectl -n podtato-kubectl describe keptnmetric available-cpus
```{{exec}}

Data is retrieved from Prometheus with the query: `sum(kube_node_status_capacity{resource='cpu'})`{{}}


[KeptnMetricsProvider](https://lifecycle.keptn.sh/docs/concepts/metrics/) CRDs describe metric sources. Take a look at the `my-provider`{{}} one:

```
kubectl -n podtato-kubectl describe keptnmetricsprovider my-provider
```{{exec}}

The `targetServer`{{}} field shows where the data is being retrieved from. KLT supports retrieval from **any** metric storage system.