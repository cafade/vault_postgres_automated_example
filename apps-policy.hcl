# vault policy write apps apps-policy.hcl

# Read-only permit
path "misc/data/eng/apikey/Google" {
  capabilities = [ "read" ]
}

# Read-only permit
path "misc/prod/cert/mysql" {
  capabilities = [ "read" ]
}

# Get credentials from the database secrets engine 'readonly' role.
path "database/creds/readonly" {
  capabilities = [ "read" ]
}
