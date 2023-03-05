# Step 1

Run the server which runs on `3333`{{}}
```
node ~/app/app.js
```{{exec}}

[Open the page in a browser]({{TRAFFIC_HOST1_3333}}) and / or open a new Tab and click this:

```
curl http://localhost:3333
```{{exec}}

Flick back to tab 1 and run the new server:

```
node ~/app/app2.js
```{{exec interrupt}}

# Enable Cowsay

Obviously we need real content here to explain...

Run with cowsay enabled:

```
node ~/app/app3.js
```{{exec interrupt}}