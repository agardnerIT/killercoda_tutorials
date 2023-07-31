#!/bin/bash

echo "Starting script.sh"
echo "This should take about 4 seconds to complete..."

trace_id=$(hexdump -vn16 -e'4/4 "%08X" 1 "\n"' /dev/urandom)
span_id=$(hexdump -vn8 -e'4/4 "%08X" 1 "\n"' /dev/urandom)

main_time_start=0

counter=1
limit=3

while [ $counter -le $limit ]
do
  # This is unique to this span
  sub_span_id=$(hexdump -vn8 -e'4/4 "%08X" 1 "\n"' /dev/urandom)
  time_start=$SECONDS
  sleep 1
  time_end=$SECONDS
  duration=$(( $time_end - $time_start ))

  tracepusher \
    --endpoint=http://localhost:4318 \
    --service-name service1 \
    --span-name "subspan${counter}" \
    --duration ${duration} \
    --trace-id ${trace_id} \
    --parent-span-id ${span_id} \
    --span-id ${sub_span_id} \
    --time-shift True \
    --span-attributes app=script.sh &

  counter=$(( $counter + 1 ))
  
done

main_time_end=$SECONDS

duration=$(( (main_time_end - main_time_start) + 1))

tracepusher \
  --endpoint http://localhost:4318 \
  --service-name service1 \
  --span-name script.sh \
  --duration ${duration} \
  --trace-id ${trace_id} \
  --span-id ${span_id} \
  --time-shift True \
  --span-attributes app=script.sh

echo "================================="
echo "script.sh completed successfully."
echo "================================="