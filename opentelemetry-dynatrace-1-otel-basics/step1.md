# Preparation

Please login to Dynatrace and go to `Access Tokens`{{}}.

Create a token with `openTelemetryTrace.ingest` scope.

![dynatrace access token](assets/dt_access_token.jpg)

Click this to set your details:

```
. ./setDTDetails.sh
```{{exec}}

When you are happy, click the following. This will modify the Collector `config.yaml` to point to your Dynatrace environment.

```
./updateCollectorConfig.sh
```{{exec}}

> Made a mistake? Just modify `config.yaml` to ensure the Dynatrace URL and API token are correct.