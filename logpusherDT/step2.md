It is now time to generate some log data. logpusher will generate the log line and push it to the collector. The collector will then forward the line to the OpenTelemetry backend (Dynatrace in this case).

## Generate a Log Line

Create a new Tab by clicking the `+`{{}} button next to `Tab 1`{{}} at the top of the terminal window.

When tab 2 has loaded, switch over to it and click the following to generate a log line:

```
docker run --network host \
gardnera/logpusher:v0.1.0 \
 --endpoint http://0.0.0.0:4318 \
 --content "This is my log line"
```{{exec}}

You should see "<Response [200]>". That means the log has successfully been sent to the collector. The collector will then automatically forward the log line to Dynatrace.

## Add Attributes

Logpusher can also add key,value attributes to your log line.

If you don't specify, Logpusher assumes the value to be a string. However, you can specify the type (as shown below).

Send another log line with two attributes:

- `foo`{{}} has a string value (implied) of `bar`{{}}.
- `userID`{{}} has an integer value of `123`{{}}

Documentation for the acceptable types can be found here.

```
docker run --network host \
gardnera/logpusher:v0.1.0 \
 --endpoint http://0.0.0.0:4318 \
 --content "This is my second log line with attributes" \
 --attributes foo=bar userID=123=intValue
```{{exec}}

## View Log line

In your Dynatrace environment, go to "Logs" and type:

```
fetch logs, scanLimitGBytes: 1
| sort timestamp desc
```{{copy}}