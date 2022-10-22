# Add podinfo repository to Flux

This example uses a public repository [https://github.com/stefanprodan/podinfo](https://github.com/stefanprodan/podinfo), podinfo is a tiny web application made with Go.

Create a [GitRepository](https://fluxcd.io/flux/components/source/gitrepositories/) manifest pointing to `podinfo` repository’s master branch:

```
flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=30s \
  --export > ./clusters/my-cluster/podinfo-source.yaml
```

The output is similar to:

```
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
metadata:
  name: podinfo
  namespace: flux-system
spec:
  interval: 30s
  ref:
    branch: master
  url: https://github.com/stefanprodan/podinfo
```

## Commit and Push to GitHub

Commit and push the `podinfo-source.yaml` file to your `fleet-infra` repository:

```
git add -A && git commit -m "Add podinfo GitRepository"
git push
```

## Deploy podinfo application

Configure Flux to build and apply the [kustomize](https://github.com/stefanprodan/podinfo/tree/master/kustomize) directory located in the podinfo repository.

Use the `flux create` command to create a `Kustomization` that applies the podinfo deployment.

```
flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --interval=5m \
  --export > ./clusters/my-cluster/podinfo-kustomization.yaml
```

The output is similar to:

```
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: podinfo
  namespace: flux-system
spec:
  interval: 5m0s
  path: ./kustomize
  prune: true
  sourceRef:
    kind: GitRepository
    name: podinfo
  targetNamespace: default
```

## Commit and push the Kustomization manifest to the repository:

```
git add -A && git commit -m "Add podinfo Kustomization"
git push
```

The structure of the `fleet-infra` repo should be similar to:

```
fleet-infra
└── clusters/
    └── my-cluster/
        ├── flux-system/                        
        │   ├── gotk-components.yaml
        │   ├── gotk-sync.yaml
        │   └── kustomization.yaml
        ├── podinfo-kustomization.yaml
        └── podinfo-source.yaml
```

## Watch Flux sync the application

Use the `flux get` command to watch the podinfo app:

```
flux get kustomizations --watch
```
The output is similar to:

```
NAME          REVISION       SUSPENDED  READY   MESSAGE
flux-system   main/4e9c917   False      True    Applied revision: main/4e9c917
podinfo       master/44157ec False      True    Applied revision: master/44157ec
```

## Check podinfo has been deployed on your cluster:

```
kubectl -n default get deployments,services
```

The output is similar to:

```
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/podinfo   2/2     2            2           108s

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/podinfo      ClusterIP   10.100.149.126   <none>        9898/TCP,9999/TCP   108s
```

Changes made to the `podinfo` Kubernetes manifests in the main branch are reflected in your cluster.

When a Kubernetes manifest is removed from the `podinfo` repository, Flux removes it from your cluster. When you delete a `Kustomization` from the `fleet-infra` repository, Flux removes all Kubernetes objects previously applied from that `Kustomization`.

When you alter the `podinfo` deployment using `kubectl edit`, the changes are reverted to match the state described in Git.
