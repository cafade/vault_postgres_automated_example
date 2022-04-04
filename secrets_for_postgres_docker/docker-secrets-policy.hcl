path "docker/selfhosted/postgres" {
  capabilities = [ "read" ]
}

path "docker/data/selfhosted/postgres" {
  capabilities = [ "read" ]
}

path "sys/leases/renew" {
  capabilities = [ "update" ]
}
