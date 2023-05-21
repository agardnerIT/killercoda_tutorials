## Deploy Version 2

```
make deploy-version-2
```{{exec}}

It will take a few moments for the frontend to start and until that time, the pre-deploy checks for the other pods will error and the other pods will stay pending.

After a few moments, all pods should start successfully.

```
kubectl -n podtato-kubectl get pods
```{{exec}}

should look like this:

```
NAME                                        READY   STATUS      RESTARTS   AGE
klc-pre-pre-deployment-check--77384-6hnlt   0/1     Completed   3          2m49s
klc-pre-pre-deployment-check--79731-zzpn5   0/1     Completed   2          2m44s
klc-pre-pre-deployment-check--80182-2c9cp   0/1     Completed   2          2m48s
podtato-head-frontend-5d4dc47-94bbl         1/1     Running     0          11m
podtato-head-hat-d5f5d5f64-sm2ck            1/1     Running     0          11m
podtato-head-left-arm-7775846574-zpjzr      1/1     Running     0          11m
podtato-head-right-arm-66878d7d9b-8thbh     1/1     Running     0          11m
```{{}}

## What is Different?

Version two has one crucial difference.

Try to find out why version 2 is allowed to start.

Hint:

- `KeptnEvaluationDefinition`{{copy}} called `app-pre-deploy-eval-2`{{copy}}).

## Explanation

Version 2 of the `KeptnApp`{{}} has a different pre-evaluation check configured.

```
cat ~/lifecycle-toolkit-examples/sample-app/version-2/app.yaml
```{{exec}}

The definition shows that the `evaluationTarget`{{}} for `available-cpus`{{}} has been lowered from `>100`{{}} to `>1`{{}},

Look for the `Evaluation Target`{{}} in the output of this command:

```
kubectl -n podtato-kubectl describe keptnevaluationdefinition app-pre-deploy-eval-2
```{{exec}}

Retrieving the metric shows the current value to be `>1`{{}}

```
kubectl -n podtato-kubectl get keptnmetrics
```{{exec}}

The pre-condition check is **met** and so the pods are allowed to be bound to the node.


