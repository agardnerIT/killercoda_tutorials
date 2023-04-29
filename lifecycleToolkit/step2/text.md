# The Demo Application
For this demonstration, we use [the PodTatoHead application](https://github.com/podtato-head/podtato-head).

Let's attempt to deploy version 1 of the application now:

```
make deploy-version-1
```{{exec}}

In the first version of the demo application, the Keptn Lifecycle Toolkit evaluates metrics provided by Prometheus mockserver and checks if the specified amount of CPUs are available before deploying the application.