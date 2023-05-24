## Start NATS Server

Run the NATS server in the background:

```
nats-server --addr 0.0.0.0 --port 4222 &
```{{exec}}

## Create and Subscribe to a Subject

Now subscribe to the `demo.cdevents`{{}} subject. Note that NATS automatically creates the subject when you subscribe.

This is where you will receive messages.

```
nats subscribe demo.cdevents
```{{exec}}

## Send a CDEvent

Open a new terminal window and send a CDEvent to the `demo.cdevents`{{}} channel:

```
nats publish demo.cdevents '
{
  "foo": "bar"
}
'
```

## View CDEvent

Switch back to the first terminal window and notice that you've received the CDEvent.

## Send Other CDEvents

A helper shell script has been created to send any CDEvent:

```
./helper.sh pipelinerun.queued
```{{exec}}

Analyse the `nginx:latest` image and write the output to a file:

```
dive --json output.json nginx:latest
```{{ exec }}

View the output:

```
cat output.json
```{{ exec }}

## CI / Quality Gating

Dive can be used in a CI process where thresholds are provided and if breached, the image is set to failed.

Three metrics are supported: `lowestEfficiency`, `highestWastedBytes` and `highestUserWastedPercentage`

Create a file called `.dive-ci`
```
cat << EOF > .dive-ci
rules:
  # If the efficiency is measured below X%, mark as failed.
  # Expressed as a ratio between 0-1.
  lowestEfficiency: 0.99

  # If the amount of wasted space is at least X or larger than X, mark as failed.
  # Expressed in B, KB, MB, and GB.
  highestWastedBytes: 20MB

  # If the amount of wasted space makes up for X% or more of the image, mark as failed.
  # Note: the base image layer is NOT included in the total image size.
  # Expressed as a ratio between 0-1; fails if the threshold is met or crossed.
  highestUserWastedPercent: 0.20
EOF
```{{ exec }}

Re-run `dive` in CI mode (instead of the `--ci` flag you can also `export CI=true`):
```
dive --ci nginx:latest
```{{ exec }}

This time the test should fail because the `lowestEfficiency` was greater than the value we gave of `0.99`.