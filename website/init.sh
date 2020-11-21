#!/bin/bash

start()
{
    PROJECT=$1
    ADDRESS=$2
    PASSWORD=$(openssl rand -base64 18 | sed 's/\///g' | sed 's/==//g')
    rm -rf "$PROJECT"
    cp -r template "$PROJECT"
    sed -i -e "s/template/$PROJECT/g" $PROJECT/docker-compose.yml
    sed -i -e "s/hostname/$ADDRESS/g" $PROJECT/docker-compose.yml
    sed -i -e "s/randompassword/$PASSWORD/g" $PROJECT/docker-compose.yml
    sed -i -e "s/hostname/$ADDRESS/g" $PROJECT/conf/vhost.conf
    cd $PROJECT
}

if [ "$#" -eq  "0" ]
  then
    echo "No arguments supplied"
else
    start $1 $2
fi

