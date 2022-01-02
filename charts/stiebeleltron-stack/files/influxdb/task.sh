#!/bin/bash

echo "creating bucket ${INFLUX_BUCKET_NAME}"
response=$(influx bucket create -r ${INFLUX_BUCKET_RETENTION})
exit_code=$?
echo "$response"
if [[ "$response" != *"already exists"* && $exit_code -gt 0 ]]; then
  exit $exit_code
fi

echo "listing existing tasks"
response=$(influx task list)
if [[ "$response" == *"Downsampling Stiebeleltron"* ]]; then
  echo "task exists already, nothing to do"
  exit 0
fi

echo "creating task"
influx task create -f /config/task.flux
