It is now time to generate some trace data. tracepusher will generate the trace and push it to the collector. The collector will then forward the trace to the OpenTelemetry backend (Dynatrace in this case).

## Generate a Trace

Click the following to generate a trace:

```
docker run \
--add-host=host.docker.internal:host-gateway \
--endpoint=http://host.docker.internal:4318 \
--service-name=killercoda \
--span-name=span1 \
--duration=5
```{{exec}}

## Explanation

That's a big command so let's break it down:

- `docker run`{{}}: Docker, please run a container
- `--add-host=host.docker.internal:host-gateway`{{}}: The OTEL collector is running on the Ubuntu machine, but tracepusher is running inside a container. tracepusher needs a way to "speak" to the OTEL collector endpoint. This creates a special URL on the docker container called `host.docker.internal`{{}} which points to `localhost`{{}} on the VM.
- `--service-name`{{}}: The service name of the generated OpenTelemetry trace
- `--span-name`{{}}: The span name of the generated OpenTelemetry trace
- `--duration`{{}}: The duration (in seconds) of the trace

## View Trace

In your Dynatrace environment, go to `Distributed Traces`{{}} and you will see your trace.