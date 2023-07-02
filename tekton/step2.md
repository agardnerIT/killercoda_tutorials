# Create and run your first Tekton Pipeline

This tutorial shows you how to:

- Create two Tasks.
- Create a Pipeline containing your Tasks.
- Use `PipelineRun`{{}} to instantiate and run the Pipeline containing your Tasks.

## Apply Goodbye World Task

```
kubectl apply --filename ~/files/goodbye-world.yaml
```{{exec}}

## Create and run a Pipeline

The Pipeline defines the parameter `username`{{}}, which is then passed to the `goodbye`{{}} Task.

A `PipelineRun`{{}}, represented in the API as an object of kind `PipelineRun`{{}}, sets the value for the parameters and executes a Pipeline.

```
kubectl apply --filename ~/files/hello-goodbye-pipeline.yaml
kubectl apply --filename ~/files/hello-goodbye-pipeline-run.yaml
```{{exec}}

Repeatedly run the following command until it shows "Succeeded: True":

```
kubectl get pipelineruns
```{{exec}}

## Show PipelineRun Logs

Use the [tkn CLI](https://tekton.dev/docs/cli/) to retrieve the PipeLine run logs:

```
tkn pipelinerun logs hello-goodbye-run -f -n default
```{{exec}}

Alternatively, use kubectl:

```
kubectl logs -l=tekton.dev/pipeline=hello-goodbye
```{{exec}}