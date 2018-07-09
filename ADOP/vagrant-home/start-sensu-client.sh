#!/bin/bash

defaultFakturaIp=35.157.234.116
fakturaIp=""

# geth the faktura ip argument or use default
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, using default faktura ip $defaultFakturaIp"
	fakturaIp=$defaultFakturaIp
  else
	echo "Using provided faktura ip $1"
	fakturaIp=$1
fi



# create an own image
docker build --no-cache --tag demo/sensu-client-faktura:latest  -f ./dockerfile-sensu-client .

# remove existing container
#docker rm -f sensu-client-faktura-${fakturaIp}


# DISABLE. BUILD FROM TEMPLATE INSTEAD
# start the slave using compose
#docker-compose -f compose-sensu-client.yaml create
#docker-compose -f compose-sensu-client.yaml start



# generate a temp compose file by insertin an ip into the template
tmppath="/tmp/"
tmpfile="sensu-client-faktura-`date +%s`.yaml"

if [ -f "$tmppath" ]; then	mkdir -p $tmppath; fi
touch ${tmppath}${tmpfile}

# copy the template
cat "compose-sensu-client.template.yaml" > "${tmppath}${tmpfile}"

# modify the faktura ip 
sed -i "s/{{ faktura_ip }}/$fakturaIp/" "${tmppath}${tmpfile}"

echo "Creating the container using compose. Do not touch (recreate) existing containers"
docker-compose -p $fakturaIp  -f "${tmppath}${tmpfile}" create --force-recreate

#echo "Starting the container"
docker-compose -p $fakturaIp -f "${tmppath}${tmpfile}" start

