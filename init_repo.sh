#!/bin/bash
set -e

echo "🚀 Initializing Terraform to create GitHub repository..."

terraform init

terraform plan -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'

terraform apply -auto-approve -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
