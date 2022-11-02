# Invadium Intro

Wait until you see 🎉 Installation Complete 🎉

Then modify `~/invadium/invadium_total.yaml` (you can also use the editor) and search for `CHANGE-ME-PORT-3000` (line `207`{{}}).

Replace with: `{{TRAFFIC_HOST1_3000}}`

Search for `CHANGE-ME-PORT-3001` (line `208`{{}}).

Replace with: `{{TRAFFIC_HOST1_3001}}`

It should look similar to this:

```
data:
  INVADIUM_CONFIG_PATH: /config
  INVADIUM_API_ROOT: "/api"
  INVADIUM_API_PORT: "3001"
  INVADIUM_CORS_ORIGINS: "[\"https://12345abc-1234-abcd-1111-3c6206d243d9-10-244-7-223-3000.papa.r.killercoda.com/\"]"
  INVADIUM_BACKEND_API_URL: "https://12345abc-1234-abcd-1111-3c6206d243d9-10-244-7-223-3001.papa.r.killercoda.com/api"
```{{}}

Save and exit the file.

```
kubectl apply -f ~/invadium/total.yaml
```

# Copy Data into PersistentVolume

```
chmod +x ~/invadium/k8s-manifests/hooks/copy-data.sh
~/invadium/k8s-manifests/hooks/copy-data.sh ~/invadium/exploits/config
```

# Restart backend to pick up data

```
ki scale deployment invadium-backend --replicas=0
ki scale deployment invadium-backend --replicas=1
```

# Open Invadium

Invadium is now setup on your Kubernetes cluster.

[Click here to open Invadium]({{TRAFFIC_HOST1_3000}})






