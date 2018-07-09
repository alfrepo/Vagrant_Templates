#!/bin/bash

# create an own image
docker build --tag demo/sensu-server:latest -f ./dockerfile-sensu-server .

# remove existing container
docker rm -f sensu-server

# start the slave using compose
docker-compose -f compose-sensu-server.yaml create
docker-compose -f compose-sensu-server.yaml start
