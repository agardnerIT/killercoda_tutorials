We will now simulate what your application would do to retrieve a flag value.

Open a new tab and run this command:

```
curl -X POST {{TRAFFIC_HOST1_8013}}/schema.v1.Service/ResolveString \
  -H "Content-Type: application/json" \
  -d '{"flagKey": "headerColor", "context": {} }'
```{{exec}}

This should return `red` because the `defaultVariant` is set to `red` in Git ([see here]({{TRAFFIC_HOST1_3000}}/openfeature/flags/src/branch/main/flags.json#L91)).

## Change Flag Color

Using GitOps, change the `defaultVariant` from `red` to `yellow`:

Edit `~/template/flags.json` (or do it via the UI). Gitea username and password is `openfeature` for both.

Line `91` should now look like this:

```
      "defaultVariant": "yellow",
```{{}}

Commit the changes.

## Retrieve the Flag Value Again

This time you should receive `yellow`.

```
curl -X POST {{TRAFFIC_HOST1_8013}}/schema.v1.Service/ResolveString \
  -H "Content-Type: application/json" \
  -d '{"flagKey": "headerColor", "context": {} }'
```{{exec}}