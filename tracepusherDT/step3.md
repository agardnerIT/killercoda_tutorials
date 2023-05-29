# Trace a Shell Script

In Tab 2, click the following:

```
cat ~/script.sh
./script.sh
```{{exec}}

This shell script does nothing fancy. It sleeps for 2 seconds then pushes a trace using the same method as before. Notice one new parameter: `--time-shift`{{}}

## Time Shifting Explained

When tracing things that have already happened (like the shell script above), it is necessary to add the `--time-shift=True` parameter because, by default, tracepusher generates the start and end time *from now*.

Imagine a shell script starts `13:00:00`{{}} and lasts for 4 seconds. It would end at `13:00:04`{{}}. Used in the default mode (ie. without `--time-shift=True`), tracepusher would generate a OTEL trace who's start time was `13:00:04`{{}} and duration was correct (4 seconds). This would make the end time `13:00:08`{{}}.

In other words, the trace has shifted by however long the duration of the task was.

The `--time-shift`{{}} parameter simply moves the `start`{{}} and `end`{{}} time back by the `duration`{{}} which makes the trace timing accurate.