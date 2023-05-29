## Create Docker Network

To communicate with one another, both Jaeger and tracepusher need to run on the same docker network. Create a network called `demo`{{}} now:

```
docker network create demo
```{{exec}}

## Start Jaeger

```
docker run -d --name jaeger \
  --network demo \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -e COLLECTOR_OTLP_ENABLED=true \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.45
```{{exec}}

## Run tracepusher

Use tracepusher to generate and send a trace to Jaeger via the OpenTelemetry collector that is built into the Jaeger "all-in-one" image (and exposed on port 4318).

```
docker run --network demo gardnera/tracepusher:v0.5.0 \
  --endpoint http://jaeger:4318 \
  --service-name service1 \
  --span-name span1 \
  --duration 2
```{{exec}}

## View Traces in Jaeger

To view the trace, [Open Jaeger UI by clicking here]({{TRAFFIC_HOST1_16686}}/search?service=service1), then click the span.

## What Happened?

1. A docker network was created so that the two containers could talk to each other
2. Jaeger all-in-one image was started. This image is a demo-ready system which includes an OpenTelemetry collector and a storage database
3. tracepusher generated a span and sent it to "http://jaeger:4318"
4. The OpenTelemetry collector forwarded the span to Jaeger
5. Jaeger stored the span in the database
6. You used the Jaeger UI to retrieve and view the span