## Create a repo

```
cd ~/template
git remote set-url origin {{TRAFFIC_HOST1_3000}}/openfeature/flags
git push
```{{exec}}

[Login to Gitea]({{TRAFFIC_HOST1_3000}}/user/login)

[Open openfeature/flags repository]({{TRAFFIC_HOST1_3000}}/openfeature/flags)

## Start Flagd
```
flagd start \
  --port 8013 \
  --uri {{TRAFFIC_HOST1_3000}}/openfeature/flags/raw/branch/main/flags.json
```{{exec}}