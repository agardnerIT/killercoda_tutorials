# Create a New Docker Network

By default, docker starts containers on the `bridge` network. In this mode, containers can only address each other via their IPs.

That's a bit clunky so let's make life easier and create a new network called `tracegen-demo-net` just for this demo. That way, containers can address each other via their name instead - which is easier for us humans and easier to automate.

```
docker network create tracegen-demo-net
```{{exec}}

You can see all docker networks with the following command. You should see 4 networks, one of which is `tracegen-demo-net`{{}}.

```
docker network ls
```{{exec}}

# Run Collector

Run the collector on the `tracegen-demo-net`{{}} network.

Give the container a name: `otelcol` which means other containers can find it via the name instead of a unique ID or IP (which will change at some point).

```
docker run \
--net tracegen-demo-net \
--name otelcol \
-v ~/config.yaml:/etc/otelcol-contrib/config.yaml \
ghcr.io/open-telemetry/opentelemetry-collector-releases/opentelemetry-collector-contrib:0.63.0
```{{exec}}

# Generate Trace Data

Open a second terminal window; click the `+`{{}} next to `Tab 1` at the top of the screen.

Run the trace generator utility. Again give the container a name (just for consistency). Also set the network so the container runs in the same network. The following command does all that for you.

Notice we're passing the endpoint as `otelcol:4317` which means "send trace data to the `otelcol` container on port `4317`" (the default OpenTelemetry gRPC port).

The `-otlp-insecure` flag is needed because we don't have a proper TLS cert configured on the demo system.

```
docker run \
--net tracegen-demo-net \
--name tracegenerator \
ghcr.io/open-telemetry/opentelemetry-collector-contrib/tracegen:v0.63.0 -traces 1 -otlp-insecure -otlp-endpoint otelcol:4317
```{{exec}}

If it works, you should see lots of output that ends with: `stopping the exporter`{{}}

## View Traces In Dynatrace

Open Dynatrace and go to `Distributed Traces`{{}} then toggle over to `Ingested traces`{{}}.

In a few seconds you should see a trace called `lets-go`{{}} (that's what `tracegen`{{}} names the traces it sends).

Generate more trace data by re-running:

```
docker run \
--net tracegen-demo-net \
--name tracegenerator \
ghcr.io/open-telemetry/opentelemetry-collector-contrib/tracegen:v0.63.0 -traces 1 -otlp-insecure -otlp-endpoint otelcol:4317
```{{exec}}