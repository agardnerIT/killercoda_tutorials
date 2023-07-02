# Create and run a basic Task

A Task, represented in the API as an object of kind Task, defines a series of Steps that run sequentially to perform logic that the Task requires. Every Task runs as a pod on the Kubernetes cluster, with each step running in its own container.

```
kubectl apply -f ~/files/hello-world.yaml
```{{exec}}

## Create and apply TaskRun

```
kubectl apply -f ~/files/hello-world-run.yaml
```{{exec}}

## Verify everything worked

Run the following command repeatedly until the output says "Succeeded":

```
kubectl get taskrun hello-task-run
```{{exec}}

Then get the logs from this `TaskRun`{{}}:

```
kubectl logs --selector=tekton.dev/taskRun=hello-task-run
```{{exec}}

The output displays the message `Hello World`{{}}