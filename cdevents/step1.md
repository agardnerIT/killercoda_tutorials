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

## Send a Generic Event

Open a new terminal window and send an payload to the `demo.cdevents`{{}} channel:

```
nats publish demo.cdevents '
{
  "foo": "bar"
}
'
```{{exec}}

## View Event

Switch back to the first terminal window and notice that you've received the message.

## Send CDEvents

A helper Python script has been created to send any CDEvent:

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type pipelinerun_queued
```{{exec}}

Possible types are available [here](https://github.com/cdevents/spec/tree/main/examples). Types should be given in the format `<subject>_<predicate>`{{}} for example `branch_deleted`{{}}