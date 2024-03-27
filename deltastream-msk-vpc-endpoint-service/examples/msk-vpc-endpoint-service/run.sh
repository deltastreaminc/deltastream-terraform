#!/bin/bash

# -------------------------------------------------------------------------
# run.sh: Run the current example.
# -------------------------------------------------------------------------

set -e

terraform fmt *.tf && terraform init
terraform plan -var-file vpces.tfvars
terraform apply -var-file vpces.tfvars
