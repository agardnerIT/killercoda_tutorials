# Run Without Enrichment
Run the experiment now with no event enrichment.

This simulates making a change on a host but not informing Dynatrace. Unknown to you, the change causes a CPU issue.

Click the following box to simulate the issue.
```
stress -c 10 -t 5m
```{{exec}}

## Wait For Problem
Wait a few moments and Dynatrace should automatically detect the CPU problem, but it has no root cause.

When you see the problem, stop the experiment:

```
./endExperiment.sh
```{{exec interrupt}}