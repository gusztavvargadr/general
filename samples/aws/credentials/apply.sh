#!/usr/bin/env bash

terraform init
terraform apply -auto-approve

TERRAFORM_OUPUT=$(terraform output -json)

ACCESS_KEY=$(echo $TERRAFORM_OUPUT | jq -r .access_key.value)
SECRET_KEY=$(echo $TERRAFORM_OUPUT | jq -r .secret_key.value)
# SECURITY_TOKEN=$(echo $TERRAFORM_OUPUT | jq -r .security_token.value)

export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
# export AWS_SESSION_TOKEN=$SECURITY_TOKEN
