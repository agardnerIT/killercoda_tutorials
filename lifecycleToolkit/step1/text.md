
<br>
This is the initial step in which we will set up the Keptn Lifecycle Toolkit using helm and fetch the data of demo app from the GitHub repo.
<br>

# Install the Keptn Lifecycle Toolkit:

Add the Keptn Lifecycle Toolkit in the scenario with the use of helm charts.

```
helm repo add klt https://charts.lifecycle.keptn.sh
helm repo update
helm upgrade --install keptn klt/klt -n keptn-lifecycle-toolkit-system --create-namespace --wait
```{{exec}}

Now check the status of the namespace if it is deployed or not by running:

`helm list -A`{{exec}}

# Fetch Demo Applications:

For the further progress of this demo, we need a sample applications as well as some helpers which make it easier for you to set up your environment. These things can be found in our Getting Started repository which can be checked out as follows:

```
git clone https://github.com/keptn-sandbox/lifecycle-toolkit-examples.git
cd lifecycle-toolkit-examples
```{{exec}}

## We have successfully made the setup of Keptn Lifecycle Toolkit and the demo app.
