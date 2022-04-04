#!/usr/bin/env bash


##
# use like: `VAULT_TOKEN=$(vault token create -policy="docker_creds" -field=token -ttl 1m) envconsul -upcase -secret docker/selfhosted/postgres ./run_postgres.sh`
##

# echo "postgres_user: '${DOCKER_SELFHOSTED_POSTGRES_POSTGRES_USER}'"
# echo "postgres_password: '${DOCKER_SELFHOSTED_POSTGRES_POSTGRES_PASSWORD}'"

# sudo docker pull postgres:latest
sudo docker run \
    --detach \
    --name learn-postgres \
    -e POSTGRES_USER=$DOCKER_SELFHOSTED_POSTGRES_POSTGRES_USER \
    -e POSTGRES_PASSWORD=$DOCKER_SELFHOSTED_POSTGRES_POSTGRES_PASSWORD \
    -p 5432:5432 \
    --rm \
    postgres
