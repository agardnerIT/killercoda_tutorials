# Run With Enrichment
This time, run the experiment now **with** event enrichment.

Click the following box to simulate the issue.
```
~/enrichedDeployment.sh
```{{exec}}

## Wait For Problem
Wait a few moments and Dynatrace should automatically detect the CPU problem.

The problem now has a full root cause.

When you see the problem, stop the experiment:

```
./endExperiment.sh
```{{exec interrupt}}

## Discover How

Look at the `enrichedDeployment.sh` file to understand how the event was sent.

```
cat ~/enrichedDeployment.sh
```{{exec}}