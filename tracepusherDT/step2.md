It is now time to generate some trace data. tracepusher will generate the trace and push it to the collector. The collector will then forward the trace to the OpenTelemetry backend (Dynatrace in this case).

## Generate a Trace

Create a new Tab by clicking the `+`{{}} button next to `Tab 1`{{}} at the top of the terminal window.

When tab 2 has loaded, switch over to it and click the following to generate a trace:

```
docker run --network host \
gardnera/tracepusher:v0.5.0 \
--endpoint http://0.0.0.0:4318 \
--service-name killercoda \
--span-name span1 \
--duration 5
```{{exec}}

You should see "<Response [200]>". That means the span has successfully been sent to the collector. The collector will then automatically forward the span to Dynatrace.

## Explanation

That's a big command so let's break it down:

- `docker run`{{}}: Docker, please run a container
- `--network host`{{}}: The OTEL collector is running on the Ubuntu machine, but tracepusher is running inside a container. tracepusher needs a way to "speak" to the OTEL collector endpoint. This flag allows docker to share the host network. The collector is available on `0.0.0.0:4318`{{}}.
- `--service-name`{{}}: The service name of the generated OpenTelemetry trace
- `--span-name`{{}}: The span name of the generated OpenTelemetry trace
- `--duration`{{}}: The duration (in seconds) of the trace

## View Trace

In your Dynatrace environment, go to "Distributed Traces" and you will see your trace.