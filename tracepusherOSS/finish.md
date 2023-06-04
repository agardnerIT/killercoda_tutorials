## Summary

You have used tracepusher (an open source tool) to generate OpenTelemetry spans and send them to Jaeger (another open source tool) via an OpenTelemetry collector.

### tracepusher Requires a Collector

[tracepusher](https://agardnerit.github.io/tracepusher/) is general purpose. It can be used to [trace CICD pipelines](https://www.youtube.com/watch?v=zZDFQNHepyI), [shell scripts](https://github.com/agardnerIT/tracepusher/blob/main/samples/script.sh) or anything else you need. Be aware that tracepusher needs to send data to an [OpenTelemetry collector](https://opentelemetry.io/docs/collector/getting-started/).