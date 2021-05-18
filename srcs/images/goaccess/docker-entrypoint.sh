#!/bin/sh

# Start goaccess every 5 seconds to keep index.html up to date
# TODO: Use real-time-html option, with WebSocket server
while true; do
	goaccess --no-global-config --config-file=/goaccess/goaccess.conf
	sleep 5
done
