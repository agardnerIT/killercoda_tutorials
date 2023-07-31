It is now time to generate some trace data. tracepusher will generate the trace and push it to the collector. The collector will then forward the trace to the OpenTelemetry backend (Dynatrace in this case).

## Generate a Trace

Create a new Tab by clicking the `+`{{}} button next to `Tab 1`{{}} at the top of the terminal window.

When tab 2 has loaded, switch over to it and click the following to generate a trace:

```
tracepusher \
--endpoint http://localhost:4318 \
--service-name killercoda \
--span-name span1 \
--duration 5 \
--span-attributes app=killercoda-demo
```{{exec}}

You should see "<Response [200]>". That means the span has successfully been sent to the collector. The collector will then automatically forward the span to Dynatrace.

## Explanation

That's a big command so let's break it down:

- `--service-name`{{}}: The service name of the generated OpenTelemetry trace
- `--span-name`{{}}: The span name of the generated OpenTelemetry trace
- `--duration`{{}}: The duration (in seconds) of the trace
- `--span-attributes`{{}}: Adds "key=value" information pairs to spans. Multiple "key=value" pairs can be added (separated by a space)

## View Trace

In your Dynatrace environment, go to "Distributed Traces" and you will see your trace.