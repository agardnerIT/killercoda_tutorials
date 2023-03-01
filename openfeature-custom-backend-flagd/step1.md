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

## Retrieve a flag value

This is what your application would do to retrieve a flag value.

```
curl -X POST {{TRAFFIC_HOST1_8013}}/schema.v1.Service/ResolveString \
  -H "Content-Type: application/json" \
  -d '{"flagKey": "headerColor", "context": {} }'
```{{exec}}

This should return `red` because the `defaultVariant` is set to `red` in Git ([see here]({{TRAFFIC_HOST1_3000}}/openfeature/flags/src/branch/main/flags.json#L95)).

## Change Flag Color

Using GitOps, change the `defaultVariant` from `red` to `yellow`:

Edit `~/template/flags.json` (or do it via the UI). Gitea username and password is `openfeature` for both.

Line `95` should now look like this:

```
      "defaultVariant": "yellow",
```{{}}

Commit the changes.

## Retrieve the flag value again
```
curl -X POST {{TRAFFIC_HOST1_8013}}/schema.v1.Service/ResolveString \
  -H "Content-Type: application/json" \
  -d '{"flagKey": "headerColor", "context": {} }'
```{{exec}}

## TODO: Explain rules and fractional evaluations

## Summary
You now have a pure GitOps feature flagging system. You can change only a JSON file and your applicaiton will automatically leverage the changes.