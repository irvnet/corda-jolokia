#!/bin/bash

# Description: calls the terraform templates to deploy the environment

# Notes:
# - currently configured and tested on macos to provision to Azure
# - make sure to copy the example.terraform.tfvars to terraform.tfvars and providing credentials

terraform apply -auto-approve

