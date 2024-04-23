#!/bin/bash

# https://docs.docker.com/config/containers/multi-service_container/

# Start the first process
/app/activitywatch/aw-server-rust/aw-server-rust --host 0.0.0.0 --no-legacy-import &

# Start the second process
/app/activitywatch/aw-server-rust/aw-sync &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
