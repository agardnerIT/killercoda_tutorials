## Create and run your first Tekton Pipeline

This tutorial shows you how to:

- Create two Tasks.
- Create a Pipeline containing your Tasks.
- Use `PipelineRun`{{}} to instantiate and run the Pipeline containing your Tasks.

## Create and run a Second Task

You already have a “Hello World!” Task. To create a second “Goodbye!” Task, apply this YAML file:

```
kubectl apply --filename ~/files/goodbye-world.yaml
```{{exec}}

This Task takes one parameter, username. Whenever this Task is used a value for that parameter must be passed to the Task. When a Task is part of a Pipeline, Tekton creates a TaskRun object for every task in the Pipeline.

## Create and run a Pipeline

A Pipeline defines an ordered series of Tasks arranged in a specific execution order as part of the CI/CD workflow.

In this section you are going to create your first Pipeline, that will include both the “Hello World!” and “Goodbye!” Tasks.

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