<br>

# The Demo Application
For this demonstration, we use a slightly modified version of the PodTatoHead application.

Over time, we will evolve this application from a simple manifest to a Keptn-managed application:

We install it with kubectl then add pre and post deployment tasks.
For this, we check if the entry service is available before the other services are scheduled.
We then add evaluations to ensure that our infrastructure is in good shape before we deploy the application.
Finally, we evolve to a GitOps driven deployment and notify an external webhook service when the deployment has finished.

# Deploy the Demo Application (Version 1)
In the first version of the Demo application, the Keptn Lifecycle Toolkit evaluates metrics provided by Prometheus and checks if the specified amount of CPUs are available before deploying the application

To install it, simply apply the manifest:

`make deploy-version-1`{{exec}}

# Watch workload state
When the Lifecycle Toolkit detects workload labels (“app.kubernetes.io/name” or “keptn.sh/workload”) on a resource, a KeptnWorkloadInstance (kwi) resource is created. Using this resource you can watch the progress of the deployment.

`kubectl get keptnworkloadinstances -n podtato-kubectl`{{exec}}

# Watch application state
Although you didn't specify an application in your manifest, the Lifecycle Toolkit assumes that this is a single-service application and creates an ApplicationVersion (kav) resource for you.

`kubectl get pods -n podtato-kubectl`{{exec}}

After running the above command you will notice that the pod status shows that all the pods are in pending state. This shows that the pre-deployement evaluations for version 1 of the demo application fails.

To check the status of pre-deployment status of the current version, use the following command:

`kubectl get keptnappversions -A -owide` {{exec}}

In the output you will notice that the pre-deployment status is completed but the pre-deployment evaluations are failed for the `podtato-head-0.1.1-1` application.

## In the next and final step we will fix the errors and finally make the application running