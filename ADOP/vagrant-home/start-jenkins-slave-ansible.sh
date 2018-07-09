#!/bin/bash

# remove existing container
if [ "$( docker ps -a | grep jenkins-slave-ansible )" ]; then echo docker rm -f jenkins-slave-ansible; fi

# create an own image
docker build --tag demo/jenkins-slave:latest -f ./dockerfile-jenkins-slave-ansible .

# start the slave using compose
docker-compose -f compose-jenkins-slave-ansible.yaml create
docker-compose -f compose-jenkins-slave-ansible.yaml start
