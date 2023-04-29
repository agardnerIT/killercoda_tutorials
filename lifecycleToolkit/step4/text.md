<br>
In this section of the demo we will try to deploy the second version of the application and try to pass all the evaluations to make the application running.
<br>

# Deploy the Demo Application (Version 2)

`make deploy-version-2`{{exec}}

# Checking the status of the pods after making second deployment
After making the second deployment of the application when you hit the following the command you will notice that the creation of the pre-deployment check containers begins.

`kubectl get pods -n podtato-kubectl`{{exec}}

After the processing of the command is completed we see on the terminal that creation of keptn pre-deployement check containers is completed and all the pods of the application starts running.

# Checking the status of both the applications

Now to check the details regarding the pre-deployment of the two versions of the applications we run the following command:

`kubectl get keptnappversions -A -owide`{{exec}}

In the output we see that the first version pre-deployment evaluations fails while the second version is succeeded.

