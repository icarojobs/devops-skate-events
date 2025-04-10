#!/bin/bash

# Carrega o .env
set -a
source .docker-env
set +a

docker build \
  --build-arg WWWUSER=$WWWUSER \
  --build-arg WWWGROUP=$WWWGROUP \
  -t mob2you/devops-skate-events/sail-8.4-app:latest .
