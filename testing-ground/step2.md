Let's change our landing page's color. Change the `"defaultVariant"`{{}} of the `"hex-color"`{{}} within the `ui-flags`{{}} CR and use kubectl to apply the change again. You should notice the color of the page changes immediately.

```
kubectl apply -f ~/end-to-end.yaml
```{{exec}}

Flag evaluations can take into account contextual information about the user, application, or action. The `"fib-algo"`{{}} flag returns a different result if our email ends with `"@faas.com"`{{}}.

## Run Calculator
Let's run the fibonacci calculator...

Run it once as a "customer" (without being logged in). Then login as an "employee" (use any email ending in ...@faas.com) and observe the impact.

This effect is driven by the rule defined in the app-flags CR, which controls our server-side flags, and is predicated on the email address of the user. Feel free to experiment with your own flag values and rules!