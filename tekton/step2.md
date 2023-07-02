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

## Show PipelineRun Logs

```
kubectl get logs... TODO
```{{exec}}