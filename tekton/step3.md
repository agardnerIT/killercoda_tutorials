## Getting started with Tekton Triggers

You can use Tekton Triggers to modify the behavior of your CI/CD Pipelines depending on external events. The basic implementation you are going to create in this guide comprises three main components:

1. An `EventListener`{{}} object that listens to the world waiting for "something" to happen.
2. A `TriggerTemplate`{{}} object, which configures a `PipelineRun`{{}} when this event occurs.
3. A `TriggerBinding`{{}} object, that passes the data to the `PipelineRun`{{}} created by the `TriggerTemplate`{{}} object.

An optional `ClusterInterceptor`{{}} object can be added to validate and process event data.

You are going to create a Tekton Trigger to run the `hello-goodbye`{{}} Pipeline when the `EventListener`{{}} detects an event.

![tekton trigger flow](assets/images/TriggerFlow.svg)

## Install Tekton Triggers

```
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
```{{exec}}

Monitor the installation with the following command. When `tekton-triggers-controller`{{}}, `tekton-triggers-webhook`{{}}, and `tekton-triggers-core-interceptors`{{}} show "1/1" under the "READY" column, you are ready to continue. 

```
kubectl get pods --namespace tekton-pipelines --watch
```{{exec}}

## Create TriggerTemplate and TriggerBinding

The PipelineRun object that you created in the previous tutorial is now included in the template declaration. This trigger expects the username parameter to be available; if it’s not, it assigns a default value: “Kubernetes”.

A TriggerBinding executes the TriggerTemplate, the same way you had to create a PipelineRun to execute the Pipeline.

Apply both now:

```
kubectl apply --filename ~/files/trigger-binding.yaml
kubectl apply --filename ~/files/trigger-template.yaml
```{{exec}}

## Create an EventBinding

The EventListener object encompasses both the TriggerTemplate and the TriggerBinding.

The EventListener also requires a ServiceAccount to run, this is all defined in `rbac.yaml`{{}}

Apply both files now:

```
kubectl apply --filename ~/files/rbac.yaml
kubectl apply --filename ~/files/event-listener.yaml
```{{exec}}

## Send Triggering Event

The event listener is now configured. Port forward so that you can access it then send an event to the trigger.

Run this in Tab 1:

```
kubectl port-forward service/el-hello-listener 8080
```{{exec}}

Keep this running, do not close the tab.

Open a new tab and in Tab 2, send an event to the trigger:

```
curl -v \
   -H 'content-Type: application/json' \
   -d '{"username": "Tekton"}' \
   http://localhost:8080
```{{exec}}

You can change “Tekton” for any string you want. This value will be ultimately read by the goodbye-world Task.

The response is successful:

```
< HTTP/1.1 202 Accepted
< Content-Type: application/json
< Date: Fri, 30 Sep 2022 00:11:19 GMT
< Content-Length: 164
<
{"eventListener":"hello-listener","namespace":"default","eventListenerUID":"35dd0858-3692-4bb5-8c4f-1bf6d705bb73","eventID":"1a0a1120-7833-4078-9f30-0e3688f27dde"}
* Connection #0 to host localhost left intact
```{{}}

## Check PipelineRuns

This event triggers a PipelineRun, check the PipelineRuns on your cluster :
```
kubectl get pipelineruns
```{{exec}}

The output confirms the pipeline is working:

```
NAME                      SUCCEEDED   REASON      STARTTIME   COMPLETIONTIME
hello-goodbye-run         True        Succeeded   24m         24m
hello-goodbye-run-8hckl   True        Succeeded   81s         72s
```{{}}

You see two PipelineRuns, the first one created in the previous guide, the last one was created by the Trigger.

Check the PipelineRun logs. The name is auto-generated adding a suffix for every run, in this case it’s hello-goodbye-run-8hckl. Use your own PiepelineRun name in the following command to see the logs:

```
tkn pipelinerun logs <my-pipeline-run> -f
```{{exec}}

And you get the expected output:

```
[hello : echo] Hello World

[goodbye : goodbye] Goodbye Tekton!
```{{}}

Both Tasks completed successfuly. Congratulations!