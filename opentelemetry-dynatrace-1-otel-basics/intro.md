OpenTelemetry is powerful, but difficult. You've read the documentation and probably spun up a demo system.

But a lot of that is "magic". A lot happens behind the scenes and sometimes it is useful to strip it back and start from the basics to truly understand what is happening.

## Prerequisites

To follow this hands-on you will need:

- A Dynatrace environment
- The ability to generate a Dynatrace API token

You will generate a new API token for this tutorial and delete it immediately afterwards.

## A Basic OpenTelemetry Setup

The most basic setup has 3 components:

1. An OpenTelemetry trace generator. Usually an application that emits OTEL data (metrics, logs, traces etc.).
2. An OpenTelemetry collector. This is the aggregation point for all that data.
3. A storage backend. This is where you want to send the data. In this demo, the backend will be Dynatrace.

Of course, you can have multiples of these components but above is the most basic setup.

![](assets/basic_architecture.jpg)

# What Will Be Built

In this demo, a utility called [tracegen](https://github.com/open-telemetry/opentelemetry-collector-contrib/releases) is used to generate trace data.

The trace data will be sent to an OpenTelemetry collector.

The collector will be configured to pass the trace data to Dynatrace.

In real life, `tracegen` would be replaced by your application(s). Of course, if you chose to install the OneAgent on your hosts, the OpenTelemetry collector becomes an optional component.

![](assets/our_architecture.jpg)