#!/usr/bin/env bash


vault write sys/policies/password/postgres policy=@password_policy.hcl
vault secrets enable -path=docker -version=2 kv
vault policy write docker_creds docker-secrets-policy.hcl
vault kv put docker/selfhosted/postgres POSTGRES_USER=root POSTGRES_PASSWORD=$(vault read -format=json sys/policies/password/postgres/generate | jq -r .data.password) >/dev/null 2>&1
# VAULT_TOKEN=$(vault token create -policy="docker_creds" -field=token -ttl 1m)
# VAULT_TOKEN=$(vault token create -policy="docker_creds" -field=token -ttl 1m) envconsul -upcase -secret docker/selfhosted/postgres ./run_postgres.sh
