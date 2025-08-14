#!/bin/bash
# Self-healing script for Docker containers
while true; do
    for container in $(docker ps -q); do
        status=$(docker inspect --format='{{.State.Status}}' $container)
        if [ "$status" != "running" ]; then
            echo "Container $container stopped. Restarting..."
            docker restart $container
        fi
    done
    sleep 10
done
 
