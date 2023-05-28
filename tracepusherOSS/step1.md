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

[Open Jaeger UI by clicking here]({{TRAFFIC_HOST_16686}})

## Run tracepusher

```
docker run --network demo gardnera/tracepusher:v0.5.0 \
  --endpoint=http://jaeger:4318 \
  --service-name=service1 \
  --span-name=span2 \
  --duration=2
```{{exec}}

## View Traces in Jaeger

Open Jaeger, select `service1`{{}} from the `Service`{{}} dropdown (you may need to refresh the page).

Then click the span.