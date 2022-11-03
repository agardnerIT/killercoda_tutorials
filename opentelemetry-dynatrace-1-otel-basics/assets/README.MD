# Create a new Docker Network
By default, docker starts containers on the `bridge` network. In this mode, containers can only address each other via their IPs.

That's a bit clunky so let's make life easier and create a new network called `tracegen-demo-net` just for this demo. That way, containers can address each other via their name instead - which is easier for us humans and easier to automate.

```
docker network create tracegen-demo-net
```

You can see all docker networks by typing:

```
docker network ls
```

# Run Collector

Run the collector on the `tracegen-demo-net` network.

Give the container a name: `otelcol` which means other containers can find it via the name instead of a unique ID or IP (which will change at some point).

```
docker run ^
--net tracegen-demo-net ^
--name otelcol ^
-v %cd%/config.yaml:/etc/otelcol-contrib/config.yaml ^
ghcr.io/open-telemetry/opentelemetry-collector-releases/opentelemetry-collector-contrib:0.63.0
```

# Generate Trace Data

Open a second terminal window and run the trace generator utility. Again give hte container a name (just for consistency)
Also set the network so the container runs in the same network.

Notice we're passing the endpoint as `otelcol:4317` which means "send trace data to the `otelcol` container on port `4317` (the default gRPC port).

```
docker run ^
--net tracegen-demo-net ^
--name tracegenerator ^
ghcr.io/open-telemetry/opentelemetry-collector-contrib/tracegen:v0.63.0 -traces 1 -otlp-insecure -otlp-endpoint otelcol:4317
```