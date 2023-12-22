## Run logpusher

Use logpusher to generate a log line and send to the OTEL collector.

The OpenTelemetry collector is configured to send that log line to Loki.

```
./logpusher \
 --endpoint http://0.0.0.0:4318 \
 --content "This is my log line" \
 --insecure true
```{{exec}}

You can also push logs with attributes:
```
./logpusher \
 --endpoint http://0.0.0.0:4318 \
 --content "This is my log line" \
 --attributes foo=bar userID=123=intValue \
 --insecure true
```{{exec}}

## View Logs in Grafana

To view the logs, [Open Grafana UI by clicking here]({{TRAFFIC_HOST1_3000}}/explore?orgId=1&left=%7B%22datasource%22:%22P8E80F9AEF21F6940%22,%22queries%22:%5B%7B%22refId%22:%22A%22,%22expr%22:%22%7Bexporter%3D%5C%22OTLP%5C%22%7D%22,%22queryType%22:%22range%22,%22datasource%22:%7B%22type%22:%22loki%22,%22uid%22:%22P8E80F9AEF21F6940%22%7D,%22editorMode%22:%22builder%22%7D%5D,%22range%22:%7B%22from%22:%22now-5m%22,%22to%22:%22now%22%7D%7D).

Notice that the log also has a *string* attribute added called "foo: bar" and an *integer* attribute called "userID: 123".

For instructions on how to push other types of log attribute (Integers, booleans etc.) see [log attribute types](https://agardnerit.github.io/logpusher/reference/attribute-types/).

## What Happened?

1. Docker compose created the components. A docker network called `root_loki` was created by docker compose.
2. The logging stack was started
3. logpusher generated the content and sent it to the OpenTelemetry collector at: "http://0.0.0.0:4318"
4. The OpenTelemetry collector forwarded the log line(s) to Loki
5. Loki stored the log(s) using MinIO
6. You used the Grafana UI to retrieve and view the log(s)