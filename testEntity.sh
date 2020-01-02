# login as Bob into education namespace
vault login -namespace=education -method=userpass \
        username="bob" password="training"

# test policies 

# Set the target namespace as an env variable
export VAULT_NAMESPACE="education"

# Create a new namespace called 'web-app'
 vault namespace create web-app

# Enable key/value v2 secrets engine at edu-secret
$ vault secrets enable -path=edu-secret kv-v2

# unset namespace
unset VAULT_NAMESPACE