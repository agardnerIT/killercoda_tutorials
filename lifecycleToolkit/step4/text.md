## Putting It All Together

Version 1 of the application has been deployed. A pre-deployment task is defined on each workload (except frontend) which forces each workload to wait until the frontend is first running.

A pre-deployment evaluation is defined at the KeptnApp level which retrieves the available-cpus metric from prometheus and ensures that the number of available CPUs is greater than 100.

If this fails, all of the pods in the KeptnApp will not be allowed to be scheduled and remain in a pending state.

## Why is it Pending?

```
kubectl -n podtato-kubectl get pods
```{{exec}}

Shows that all pods are pending. Why?

Because the pre-deployment task failed. We do not have > 100 CPUs available and so the pods are still pending.

**This is the desired behaviour.**

As previously explained, in a real scenario you would use pre-checks to ensure downstream systems or third parties are operation before allowing a deployment. Here we simulate the fact that you **should not** be allowed to deploy.

KLT has protected the deployment because we do not have the desired resources.