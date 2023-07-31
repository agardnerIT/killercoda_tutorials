
## Trace a Shell Script

Now use tracepusher to trace a shell script.

```
~/script.sh
```{{exec}}

[Open Jaeger again]({{TRAFFIC_HOST1_16686}}/search?service=service1) (or click "Find Traces" to refresh the trace list) to see the trace (you may need to refresh the page).

View what the shell script looks like, either open the Editor window or click this:

```
cat ~/script.sh
```{{exec}}