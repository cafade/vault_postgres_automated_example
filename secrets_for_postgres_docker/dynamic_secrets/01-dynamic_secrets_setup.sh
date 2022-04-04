#!/usr/bin/env bash


# Source reference: https://learn.hashicorp.com/tutorials/vault/database-secrets?in=vault/secrets-management

##
# Replace postgres server address with custom one
##
HOSTNAME="192.168.0.9"

##
# Create read only role
##
sudo docker exec -i \
    learn-postgres \
    psql -U root -c "CREATE ROLE \"ro\" NOINHERIT;"

##
# Grant the ability to read all tables to the role named `ro`
##
sudo docker exec -i \
    learn-postgres \
    psql -U root -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"ro\";"

vault secrets enable database
vault policy write db_creds db_creds.hcl

##
# Replace postgres server address with custom one
##
vault write database/config/postgresql \
     plugin_name=postgresql-database-plugin \
     connection_url="postgresql://{{username}}:{{password}}@$HOSTNAME:5432/postgres?sslmode=disable" \
     allowed_roles=readonly \
     username="root" \
     password="$(vault kv get -format=json docker/selfhosted/postgres | jq -r .data.data.POSTGRES_PASSWORD)"

##
# Create the role named `readonly` that creates credentials with the `readonly.sql`
##
vault write database/roles/readonly \
      db_name=postgresql \
      creation_statements=@readonly.sql \
      default_ttl=1h \
      max_ttl=24h

##
# Read credentials from the readonly database role
##
# vault read database/creds/readonly

##
# Connect to the Postgres database and list all database users
##
# sudo docker exec -i \
#     learn-postgres \
#     psql -U root -c "SELECT usename, valuntil FROM pg_user;"

# VAULT_TOKEN=$(vault token create -policy="db_creds" -field=token -ttl 1m) consul-template \
#         -template="config.yml.tpl:config.yml" -once

# VAULT_TOKEN=$(vault token create -policy="db_creds" -field=token -ttl 1m) envconsul -upcase -secret database/creds/readonly ./app.sh

# vault lease revoke -prefix database/creds/readonly



