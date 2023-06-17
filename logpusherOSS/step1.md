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

## Run logpusher

Use logpusher to generate a log line and send to the OTEL collector.

The OpenTelemetry collector is configured to send that log line to Loki.

```
docker run --network root_loki gardnera/logpusher:v0.1.0 \
 --endpoint http://otelcol:4318 \
 --content "This is my log line"
```{{exec}}

You can also push logs with attributes:
```
docker run --network root_loki gardnera/logpusher:v0.1.0 \
 --endpoint http://otelcol:4318 \
 --content "This is my log line" \
 --attributes foo=bar userID=123=intValue
```{{exec}}

## View Traces in Jaeger

To view the logs, [Open Grafana UI by clicking here]({{TRAFFIC_HOST1_3000}}/explore?orgId=1&left=%7B%22datasource%22:%22P8E80F9AEF21F6940%22,%22queries%22:%5B%7B%22refId%22:%22A%22,%22expr%22:%22%7Bexporter%3D%5C%22OTLP%5C%22%7D%22,%22queryType%22:%22range%22,%22datasource%22:%7B%22type%22:%22loki%22,%22uid%22:%22P8E80F9AEF21F6940%22%7D,%22editorMode%22:%22builder%22%7D%5D,%22range%22:%7B%22from%22:%22now-5m%22,%22to%22:%22now%22%7D%7D).

Notice that the log also has a *string* attribute added called "foo: bar" and an *integer* attribute called "userID: 123".

For instructions on how to push other types of log attribute (Integers, booleans etc.) see [log attribute types](https://agardnerit.github.io/logpusher/reference/attribute-types/).

## What Happened?

1. Docker compose created the components. A docker network called `root_loki` was created by docker compose.
2. The logging stack was started
3. logpusher generated a log and sent it to "http://otel-col:4318"
4. The OpenTelemetry collector forwarded the span to Loki
5. Loki stored the log using MinIO
6. You used the Grafana UI to retrieve and view the log