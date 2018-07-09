#!/bin/bash

# remove existing container
docker rm -f jenkins

# create the jenkins-home folder on host. TODO: restore it from S3
#mkdir -p /vagrant/vagrant-home/jenkins/jenkins_home

# start the slave using compose
docker-compose -f compose-jenkins.yaml create
docker-compose -f compose-jenkins.yaml start
