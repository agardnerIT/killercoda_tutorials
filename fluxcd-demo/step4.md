# Bonus: Create a Namespace

Your cluster is now manageable via GitOps principles. Whatever is in Git is hte source of truth and Flux will maintain that sync.

Define a new namespace called `space1` and watch Flux create it for you:

```
cat << EOF > ~/fleet-infra/clusters/my-cluster/namespace.yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: space1
  labels:
    created-by: flux
EOF

git add -A
git commit -m "add space1 namespace"
git push
```{{exec}}

After a few moments, `kubectl get namespaces`{{exec}} should show `space1`:

```
$ kubectl get ns
NAME              STATUS
default           Active
flux-system       Active
kube-node-lease   Active
kube-public       Active
kube-system       Active
space1            Active
```