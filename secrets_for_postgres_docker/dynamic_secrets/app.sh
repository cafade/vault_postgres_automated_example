#!/usr/bin/env bash

printenv DATABASE_CREDS_READONLY_USERNAME

cat <<EOT
My connection info is:

username: "${DATABASE_CREDS_READONLY_USERNAME}"
password: "${DATABASE_CREDS_READONLY_PASSWORD}"
database: "my-app"
EOT
