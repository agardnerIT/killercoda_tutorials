## Create a repo

```
cd ~
tea repo create --name=flags --init=false
git clone https://github.com/agardnerIT/template
cd ~/template
git remote set-url origin {{TRAFFIC_HOST1_3000}}/openfeature/flags
git push
```{{exec}}

[Open Gitea]({{TRAFFIC_HOST1_3000}})