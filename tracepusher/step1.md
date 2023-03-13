The terminal window opposite represents an Ubuntu VM that you have full control over.

We have already downloaded the OpenTelemetry (OTEL) collector and docker is installed. You'll see a file called `config.yaml`{{}} which contains the configuration required to run the OTEL collector.

tracepusher will generate a trace and send it to the collector. We then need a trace backend. We will use the Observability platform Dynatrace to store and visualise trace data.

## Generate an Access Token

In Dynatrace, go to **Access Tokens**, click **Generate Access Token** and provide it with `openTelemetryTrace.ingest` scope.

> For security, you may want to set this token to expire.

## Modify Config
Open the editor (click the word *Editor* on the top left of the terminal window) and modify the following in the `config.yaml`{{}} file.

Modify the `endpoint`{{}} variable to point to your free trial environment. You should only need to change `abc12345`{{}} to whatever your environment ID is.

Modify the `Authorization`{{}} value to use your API token instead of the dummy one You should only need to change `dt0c01.sample.secret`{{}} and use your token instead (yours will be much longer.)

## Start Collector

When you have modified the `config.yaml`{{}}, click `Tab 1`{{}} and click the following line to start the collector:

```
./otelcol --config=config.yaml
```{{exec}}