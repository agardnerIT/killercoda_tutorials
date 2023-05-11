
The Keptn Lifecycle Toolkit is an open source, vendor-neutral tool that extends the Kubernetes API to offer 3 usecases:

1. [Deployment Observability](https://lifecycle.keptn.sh/#deployment-observability)
2. [Deployment Data Access](https://lifecycle.keptn.sh/#data-access)
3. [Deployment Check Orchestration](https://lifecycle.keptn.sh/#deployment-check-orchestration)

KLT does not depend on particular GitOps tooling - ArgoCD, Flux, Gitlab or others - KLT works with them all.

The Keptn Lifecycle Toolkit emits signals at every stage (k8s events, OpenTelemetry metrics and traces) to ensure your deployments are observable.

Available steps (applicable to both workload and application entities):

- Pre-Deployment Tasks: e.g. checking for dependant services, checking if the cluster is ready for the deployment, etc.
- Pre-Deployment Evaluations: e.g. evaluate metrics before your application gets deployed (e.g. layout of the cluster)
- Post-Deployment Tasks: e.g. arbitrary, scriptable logic written in TypeScript. Send notifications, close tickets, trigger tests, perform any action you can write in JavaScript.
- Post-Deployment Evaluations: e.g. Ensure workload and application level SLOs are met.

# Please Wait...

We are installing the KLT, cloning the demo code and installing observability tooling. These commands are automatically being executed for you on the right, but for reference, the commands to do so are:

```
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git
cd ~/lifecycle-toolkit-examples
make install-observability
make restart-lifecycle-toolkit
```{{copy}}

Wait until you see `# 🎉 Installation Complete 🎉` before continuing.