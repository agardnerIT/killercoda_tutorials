## Exercise: Add Post Deployment Notification

As a hands-on exercise, write and add a post-deployment notification task to the `KeptnApp`{{}} which does a `curl -X POST`{{}} to an endpoint.

## Hints

#1: Go to `https://webhook.site` to get a custom endpoint. Anything you send to this unique URL will be displayed on the browser window.

#2: You will need to create a new `KeptnTaskDefinition`{{}}.

Look at `https://github.com/keptn-contrib/klt-tasks/blob/main/http-get-example.keptntask.yaml` for inspiration.

#3: Modify `~/lifecycle-toolkit-examples/sample-app/version-2/app.yaml`{{}} to add your new task as a `postDeploymentTasks`{{}} array (see [this page](https://lifecycle.keptn.sh/docs/concepts/apps/)).