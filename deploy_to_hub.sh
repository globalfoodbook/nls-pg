#!/bin/bash

# Make sure to start boot2docker before running this script
eval "$(docker-machine env default)"

/usr/local/bin/docker login
/usr/local/bin/docker build -t globalfoodbook/nls-pg:latest .
/usr/local/bin/docker push globalfoodbook/nls-pg:latest
