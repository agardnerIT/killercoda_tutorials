#!/bin/bash
echo "starting up..."
sleep 2
echo "done sleeping"
END_TIME=$SECONDS
echo "Duration: ${END_TIME}"

# Generate OTEL Trace
echo "generating trace data for: killercoda / run.sh / ${END_TIME}s"
docker run \
--add-host=host.docker.internal:host-gateway \
gardnera/tracepusher:v0.4.0 \
--endpoint=http://host.docker.internal:4318 \
--service-name=killercoda \
--span-name=run.sh \
--duration=${END_TIME} \
--time-shift=True