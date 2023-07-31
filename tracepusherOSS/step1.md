## Start Jaeger

Jaeger will be used to store the spans that tracepusher generates.

Start Jaeger and an OpenTelemetry collector now.

```
jaeger-all-in-one
```{{exec}}

Leave it running and open Tab 2 to continue.

## Run tracepusher

Use tracepusher to generate and send a trace to Jaeger via the OpenTelemetry collector that is built into the Jaeger "all-in-one" image (and exposed on port 4318).

```
tracepusher \
  --endpoint http://localhost:4318 \
  --service-name service1 \
  --span-name span1 \
  --duration 2 \
  --duration-type s \
  --span-attributes app=killercoda-demo
```{{exec}}

## View Traces in Jaeger

To view the trace, [Open Jaeger UI by clicking here]({{TRAFFIC_HOST1_16686}}/search?service=service1), then click the span.

Notice that the span also has a *string* attribute added called "app: killercoda-demo".

For instructions on how to push other types of span attribute (Integers, booleans etc.) see [span attribute types](https://agardnerit.github.io/tracepusher/reference/span-attribute-types/).

## What Happened?

1. Jaeger all-in-one image was started. This image is a demo-ready system which includes an OpenTelemetry collector and a storage database
3. tracepusher generated a span and sent it to "http://localhost:4318"
4. The OpenTelemetry collector forwarded the span to Jaeger
5. Jaeger stored the span in the database
6. You used the Jaeger UI to retrieve and view the span