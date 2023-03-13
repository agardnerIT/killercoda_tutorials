#!/bin/sh
time_now=$SECONDS
echo "main() time now: ${time_now}"

# Generate parent trace id
trace_id=$(openssl rand -hex 16)

do_work() {
    echo "doing work..."
    echo "parent trace id: $1"
    echo "loop counter: $2"
    sleep 1
    time_now=$SECONDS
    echo "do_work() time now: ${time_now}"
    # Push child span
    echo "pushing child span with parent trace id set to ${1}"
    docker run \
    --add-host=host.docker.internal:host-gateway \
    tp:ss \
    --endpoint=http://host.docker.internal:4318 \
    --service-name=killercoda \
    --span-name=loop${2} \
    --duration=${END_TIME} \
    --time-shift=True \
    --parent-trace-id=${1}
}

counter=1
while [ $counter -le 2 ]
do
  do_work $trace_id $counter
  counter=$((counter+1))
done

time_now=$SECONDS
echo "main() end time_now: ${time_now}"

echo "pushing main trace with trace_id: ${trace_id}"
docker run \
--add-host=host.docker.internal:host-gateway \
tp:ss \
--endpoint=http://host.docker.internal:4318 \
--service-name=killercoda \
--span-name=run.sh \
--duration=${END_TIME} \
--time-shift=True \
--trace-id=${trace_id}