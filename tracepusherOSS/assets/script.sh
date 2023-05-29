#!/bin/bash

trace_id=$(hexdump -vn16 -e'4/4 "%08X" 1 "\n"' /dev/urandom)
span_id=$(hexdump -vn8 -e'4/4 "%08X" 1 "\n"' /dev/urandom)

echo "trace_id: ${trace_id}"
echo "span_id: ${span_id}"

main_time_start=0
echo "main time_start: ${main_time_start}"

counter=1
limit=3

while [ $counter -le $limit ]
do
  # This is unique to this span
  sub_span_id=$(hexdump -vn8 -e'4/4 "%08X" 1 "\n"' /dev/urandom)
  time_start=$SECONDS
  echo "loop: ${counter}"
  sleep 1
  time_end=$SECONDS
  duration=$(( $time_end - $time_start ))
  echo "loop time_start: ${time_start}. time_end: ${time_end}. duration: ${duration}"

  docker run --network demo gardnera/tracepusher:v0.5.0 \
    --endpoint=http://localhost:4318 \
    --service-name=serviceA \
    --span-name="subspan${counter}" \
    --duration=${duration} \
    --trace-id=${trace_id} \
    --parent-span-id=${span_id} \
    --span-id=${sub_span_id} \
    --time-shift=True &
  echo "pushing subspan: ${sub_span_id} with span name: subspan${counter}. trace id: ${trace_id} and parent span id: ${span_id} and time shifted"

  counter=$(( $counter + 1 ))
  
done

time_end=$SECONDS

echo "main time_start: ${main_time_start}. time_end: ${time_end}"

echo "pushing main_trace with duration: ${time_end} and trace_id: ${trace_id} and span_id=${span_id} and time shifted"

docker run --network demo gardnera/tracepusher:v0.5.0 \
  --endpoint http://localhost:4318 \
  --service-name service1 \
  --span-name script.sh \
  --duration 2 \
  --trace-id=${trace_id} \
  --span-id=${span_id} \
  --time-shift=True &