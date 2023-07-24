## Putting It All Together

Version 1 of the application has been deployed. A pre-deployment task is defined on each workload (except frontend) which forces each workload to wait until the frontend is first running.

A pre-deployment evaluation is defined at the KeptnApp level which retrieves the `available-cpus`{{}} metric from prometheus and ensures that the number of available CPUs is greater than `100`{{}}.

**If this check fails, all of the pods in the KeptnApp will not be allowed to be scheduled and remain in a pending state.**

## Why is it Pending?

```
kubectl -n podtato-kubectl get pods
```{{exec}}

Shows that all pods are pending. Why?

Because the pre-deployment task failed. 

You can check the status of any `KeptnApp`{{}} with this command:

```
kubectl -n podtato-kubectl get keptnappversions -o wide
```{{exec}}

Notice that the `predeploymentevaluationstatus`{{}} is `failed`{{}}

Recall that the pre-evaluation step is checking a metric called `available-cpus`{{}} to ensure the value is `>100`{{}}. You can see the actual value of the metric with this command (look for the `.Status.Value`{{}} field):

```
kubectl -n podtato-kubectl describe keptnmetric available-cpus
```{{exec}}

The system does not have > 100 CPUs available. The pre-deployment check failed and so the pods are still pending.

**This is the desired behaviour.**

As previously explained, in a real scenario you would use pre-checks to ensure your infrastructure is ready and capable of the upcoming deployment, downstream systems or third parties are operational before allowing a deployment.

Version 1 of the demo application simulates a scenario whereby you **should not** be allowed to deploy.

KLT has **protected the cluster by preventing the deployment** because we do not have the desired resources.