## More Examples

What follows is a non-exhaustive list of CDEvent examples.

[The specification](https://cdevents.dev/docs/) contains all possible events.

Remember:

- **SEND** the events (by clicking the code snippets below) on Tab 2.
- **VIEW** the received events on Tab 1.

### Signal Pipeline State (queued, started and finished)

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type pipelinerun_queued
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type pipelinerun_started
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type pipelinerun_finished
```{{exec}}

### Signal Service Events (deployed, rolledback, removed)

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type service_deployed
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type service_upgraded
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type service_rolledback
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type service_removed
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type service_published
```{{exec}}

### Incident Events (detected, reported, resolved)

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type incident_detected
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type incident_reported
```{{exec}}

```
python3 ~/cdeventsender.py \
  --endpoint localhost:4222 \
  --subject demo.cdevents \
  --event-type incident_resolved
```{{exec}}