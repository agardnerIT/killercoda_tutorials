# Install the required observability features

The Keptn Lifecycle Toolkit emits OpenTelemetry data as standard but the toolkit does not come pre-bundled with Observability backend tooling. This is deliberate as it provides flexibility for you to bring your own Observability backend that consumes this emitted data.

In order to use the observability features of the lifecycle toolkit, we need a monitoring and tracing backend.

In this guide, we use:

- Prometheus for Metrics
- Jaeger for Traces