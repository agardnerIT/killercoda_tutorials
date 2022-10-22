# Export GitHub.com Credentials

Modify then run the following in the the terminal. Replace `<your-token>` and `<your-username>` with your values:

```
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
```{{copy}}

# Install Flux onto Your Cluster

For information on how to bootstrap using a GitHub org, Gitlab and other git providers, see [Installation](https://fluxcd.io/flux/installation).

Run the bootstrap command:
```
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --personal
```{{exec}}

The output is similar to:
```
► connecting to github.com
✔ repository created
✔ repository cloned
✚ generating manifests
✔ components manifests pushed
► installing components in flux-system namespace
deployment "source-controller" successfully rolled out
deployment "kustomize-controller" successfully rolled out
deployment "helm-controller" successfully rolled out
deployment "notification-controller" successfully rolled out
✔ install completed
► configuring deploy key
✔ deploy key configured
► generating sync manifests
✔ sync manifests pushed
► applying sync manifests
◎ waiting for cluster sync
✔ bootstrap finished
```

The bootstrap command above does following:

- Creates a git repository called `fleet-infra` on your GitHub account
- Adds Flux component manifests to the repository
- Deploys Flux Components to your Kubernetes Cluster
- Configures Flux components to track the path `/clusters/my-cluster/` in the repository

# Clone the git repository

Clone the `fleet-infra` repository:

```
git clone https://github.com/$GITHUB_USER/fleet-infra
cd fleet-infra
```{{exec}}
