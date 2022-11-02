# Invadium

Invadium runs exploits against one or more target applications in an intuitive, reproducable, and well-defined manner. It focuses on bridging the gap between developers that write exploits and presenters that use them for demos or educational purposes.

**Presenters** can easily navigate to the web UI of Invadium, chose from a selection of exploits and demo their individual attack steps, all within Invadium.

**Exploit developers** define exploits by specifying a container image for it, environment variables for customization, and the individual commands that will be run at each step.

Of course, Invadium is not only built for exploits, you may solve similar problems, e.g., showcasing new users how a tool of yours can be used, getting a web UI for a set of commands that developers may regularly encounter, etc.

## Wait...

Before continuing, wait until you see 🎉 Preparation Complete 🎉...

## Finalise Deployment

Click this to update the deployment.

```
sed -i 's#CHANGE-ME-PORT-3000#{{TRAFFIC_HOST1_3000}}/#g' ~/invadium_full_rollout.yaml
sed -i 's#CHANGE-ME-PORT-3001#{{TRAFFIC_HOST1_3001}}#g' ~/invadium_full_rollout.yaml
```{{exec}}

## Install Invadium
```
kubectl apply -f ~/invadium_full_rollout.yaml
```{{exec}}

Wait until all pods are ready (keep running this command to check):

```
kubectl -n invadium get pods
```{{exec}}

# Copy Data into PersistentVolume
Now copy the exploit data into the pods and restart the backend pods by clicking this:

```
chmod +x ~/invadium/k8s-manifests/hooks/copy-data.sh
~/invadium/k8s-manifests/hooks/copy-data.sh ~/invadium/exploits/config
kubectl -n invadium scale deployment invadium-backend --replicas=0
kubectl -n invadium scale deployment invadium-backend --replicas=1
```{{exec}}

Ensure all pods are Running:

```
kubectl -n invadium get pods
```{{exec}}

# Open Invadium

Invadium is now setup on your Kubernetes cluster.

[Click here to open Invadium]({{TRAFFIC_HOST1_3000}})