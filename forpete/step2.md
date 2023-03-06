# Install OpenFeature SDK
```
npm install @openfeature/js-sdk
```{{exec interrupt}}

Run the OpenFeature instrumented app:

```
node ~/app/app4.js
```{{exec interrupt}}

But that's pretty pointless... Text explaining minimalist provider.

```
npm install @moredip/openfeature-minimalist-provider
node ~/app/app5.js
```{{exec interrupt}}

Change `with-cows:true` to `with-cows:false` and restart the server.

```
sed -i 's/\'with-cows\':true/'with-cows':false/g' ~/app/app5.js
node ~/app/app5.js
```{{exec interrupt}}

[Refresh the browser]({{TRAFFIC_HOST1_3333}}) and you should be back to plain old `Hello, world!`{{}}. Feature flags in action.

All this text is to be replaced.